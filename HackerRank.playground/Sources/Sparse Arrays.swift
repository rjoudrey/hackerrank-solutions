// Data Structures ->  Arrays ->  Sparse Arrays

func sparseArraysDriver() {
    let numStrings = Int(readLine()!)!
    var strings: [String] = []
    for _ in 1...numStrings {
        strings.append(readLine()!)
    }
    let numQueries = Int(readLine()!)!
    for _ in 1...numQueries {
        let query = readLine()!
        print(strings.filter { $0 == query }.count)
    }
}
