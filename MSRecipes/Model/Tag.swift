import Foundation
import Contentful

class Tag: NSObject, EntryDecodable, FieldKeysQueryable, Resource {
    static let contentTypeId = "tag"
    let sys: Sys
    let name: String
    
    required init(from decoder: Decoder) throws {
        sys          = try decoder.sys()
        let fields   = try decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
        name         = try fields.decode(String.self, forKey: .name)
        super.init()
    }
    
    enum FieldKeys: String, CodingKey {
        case name
    }
}
