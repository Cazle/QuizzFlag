import Foundation


struct Model: Decodable {
    let europe: [Country]
    let amerique: [Country]
    let asie: [Country]
}

struct Country: Decodable {
    let name: String
    let flag: String
    let flagHistory: String
    let coatOfArms: String
    let capital: String
    let continent: String
}


