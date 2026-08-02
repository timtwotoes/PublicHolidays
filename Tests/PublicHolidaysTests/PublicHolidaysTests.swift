import Testing
import Foundation
@testable import PublicHolidays

@Test func `Successfull response from holiday API`() async throws {
    let client = Client()
    client.session.configuration.requestCachePolicy = .returnCacheDataDontLoad
    let url = URL(string: "https://caldays.com/api/holidays/dk")!
    let request = URLRequest(url: url)
    let response = HTTPURLResponse(url: url,
                                   statusCode: 200,
                                   httpVersion: nil,
                                   headerFields: nil)!
    
    let json = """
        {
          "code": "dk",
          "country": "Denmark",
          "countryLocal": "Danmark",
          "locale": "da-DK",
          "year": 2026,
          "license": "CC BY 4.0",
          "count": 10,
          "holidays": [
            {
              "date": "2026-01-01",
              "name": "Nytårsdag"
            },
            {
              "date": "2026-04-02",
              "name": "Skærtorsdag"
            },
            {
              "date": "2026-04-03",
              "name": "Langfredag"
            },
            {
              "date": "2026-04-05",
              "name": "Påskedag"
            },
            {
              "date": "2026-04-06",
              "name": "2. påskedag"
            },
            {
              "date": "2026-05-14",
              "name": "Kristi himmelfartsdag"
            },
            {
              "date": "2026-05-24",
              "name": "Pinsedag"
            },
            {
              "date": "2026-05-25",
              "name": "2. pinsedag"
            },
            {
              "date": "2026-12-25",
              "name": "Juledag"
            },
            {
              "date": "2026-12-26",
              "name": "2. juledag"
            }
          ]
        }
        """
    let data = json.data(using: .utf8)!
    let cachedResponse = CachedURLResponse(response: response, data: data)

    client.session.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)
    
    let result = try await client.fetchHolidays(for: Locale.Region("dk"))
    
    #expect(result.code == "dk")
    #expect(result.country == "Denmark")
    #expect(result.countryLocal == "Danmark")
    #expect(result.locale == "da-DK")
    #expect(result.year == 2026)
    #expect(result.license == "CC BY 4.0")
    #expect(result.count == 10)
    #expect(result.holidays.count == 10)
}
