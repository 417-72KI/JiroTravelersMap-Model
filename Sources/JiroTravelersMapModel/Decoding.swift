import Foundation

public extension Shop {
    static func decode(from data: Data) throws -> Shop {
        try decoder.decode(Shop.self, from: data)
    }

    static func decodeArray(from data: Data) throws -> [Shop] {
        try decoder.decode([Shop].self, from: data)
    }
}

public extension Shop {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

extension Shop {
    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
        df.dateFormat = "yyyy/MM/dd"
        return df
    }
}
