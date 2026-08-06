import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Client to access caldays API for holidays.
public final class Client {
    internal let session: URLSession
    
    private let holidayURL = URL(string: "https://caldays.com/api/holidays/")!
    
    public convenience init() {
        let configuration = URLSessionConfiguration.ephemeral
        self.init(configuration)
    }
    
    internal init(_ configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    /// Fetch holidays for a region
    /// - Parameter region: A region identifier defined in the BCP 47 iso standard or a predefined constant from Locale.Region.
    /// - Returns: Holidays for the given region.
    public func fetchHolidays(for region: Locale.Region) async throws (ClientError) -> Holidays {
        let request = URLRequest(url: holidayURL.appending(path: region.identifier))
        do {
            let (data, response) = try await session.data(for: request) // Throws URLError
            
            if 200...299 ~= (response as! HTTPURLResponse).statusCode {
                let decoder = JSONDecoder()
                let holidays = try decoder.decode(Holidays.self, from: data) // Throws DecodingError
                return holidays
            } else {
                throw ClientError.errorFromServer(response as! HTTPURLResponse) // throws HTTPURLResponse
            }
        } catch let error as URLError {
            throw ClientError.urlLoading(error)
        } catch ClientError.errorFromServer(let response) {
            throw ClientError.errorFromServer(response)
        } catch let error as DecodingError {
            throw ClientError.parsingError(error)
        } catch let error {
            fatalError("Received unexpected error of type \(String(describing: error.self))") // Programmer error if we encounter this
        }
    }
}

extension Client {
    /// Errors thrown by
    public enum ClientError: Error {
        /// Received a status code other than 2xx.
        case errorFromServer(HTTPURLResponse)
        /// Network error - no internet access and such.
        case urlLoading(URLError)
        /// Could not parse result received from caldays.
        case parsingError(DecodingError)
    }
}
