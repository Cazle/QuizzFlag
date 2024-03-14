import Foundation


struct Model: Decodable {
    let europe: [Country]
    let amerique: [Country]
    let asie: [Country]
    let afrique: [Country]
    let oceanie: [Country]
}

struct Country: Decodable {
    let name: String
    let flag: String
    let history: String
    let coatOfArms: String
    let capital: String
    let continent: String
}


