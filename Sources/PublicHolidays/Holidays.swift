import Foundation

public struct Holidays: Codable {
    public struct Holiday: Codable {
        public let date: String
        public let name: String
    }
    
    public let code: String
    public let country: String
    public let countryLocal: String
    public let locale: String
    public let year: Int
    public let license: String
    public let count: Int
    public let holidays: [Holiday]
}
