import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
    public enum ClientError: Error {
        case errorFromServer(HTTPURLResponse)
        case urlLoading(URLError)
        case parsingError(DecodingError)
    }
}
