import Foundation
import Testing
import JiroTravelersMapModel

@Test
func decode() async throws {
    let input = #"[{"id":1,"kind":"origin","name":"三田本店","status":"open","prefecture":"tokyo","address":"港区三田2-16-4","location":{"lat":35.64806,"lng":139.7416326},"regular_holiday":["sunday","holiday"],"opening_hours":{"monday":[{"start":"09:00","end":"17:00"}],"tuesday":[{"start":"09:00","end":"17:00"}],"wednesday":[{"start":"09:00","end":"17:00"}],"thursday":[{"start":"09:00","end":"17:00"}],"friday":[{"start":"09:00","end":"17:00"}],"saturday":[{"start":"09:00","end":"17:00"}],"sunday":[],"holiday":[]},"has_parking":false,"hard_noodle_enabled":true}]"#
    let shops = try Shop.decodeArray(from: Data(input.utf8))
    let shop = try #require(shops.first)
    #expect(shop.name ==  "三田本店")
    #expect(shop.status == .open)
    #expect(shop.prefecture == .tokyo)
    #expect(shop.regularHoliday == [.sunday, .holiday])
    #expect(shop.openingHours.monday == [.init(start: "09:00", end: "17:00")])
    #expect(shop.openingHours.sunday == [])
}
