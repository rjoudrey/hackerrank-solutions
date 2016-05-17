extension String {
    func toIntArray() -> [Int] {
        return self.characters.split(" ").map { Int(String($0))! }
    }
}

// Data Structures ->  Arrays -> Arrays - DS

func hourglass(input: [[Int]]) -> Int {
    var largestSum: Int? = nil
    for i in 0...3 {
        for j in 0...3 {
            var currentSum = 0
            for x in 0...2 {
                for y in 0...2 {
                    if y == 1 && x != 1 {
                        continue
                    }
                    currentSum += input[y + i][x + j]
                }
            }
            if largestSum == nil || currentSum > largestSum {
                largestSum = currentSum
            }
        }
    }
    return largestSum!
}

func hourglassDriver(inputFunc: () -> String) {
    var lines: [[Int]] = []
    for _ in 1...6 {
        lines.append(inputFunc().toIntArray())
    }
    print(hourglass(lines))
}

// Data Structures ->  Arrays ->  Dynamic Array

func query1(x: Int, y: Int, lastAns: Int, n: Int, inout seqList: [[Int]]) {
    let seqIndex = (x ^ lastAns) % n;
    seqList[seqIndex].append(y)
}

func query2(x: Int, y: Int, inout lastAns: Int, n: Int, inout seqList: [[Int]]) {
    let seqIndex = (x ^ lastAns) % n;
    var seq = seqList[seqIndex]
    lastAns = seq[y % seq.count]
    print(lastAns)
}

func doQueries(queries: [[Int]], numSequences: Int) {
    var lastAns = 0
    var seqList: [[Int]] = []
    for _ in 1...numSequences {
        seqList.append([])
    }
    for query in queries {
        let queryType = query[0]
        let x = query[1]
        let y = query[2]
        if (queryType == 1) {
            query1(x, y: y, lastAns: lastAns, n: numSequences, seqList: &seqList)
        }
        else {
            query2(x, y: y, lastAns: &lastAns, n: numSequences, seqList: &seqList)
        }
    }
}

func queryDriver(readInput: () -> String) {
    let queryMetadata = readInput().toIntArray()
    let numSequences = queryMetadata[0]
    let numQueries = queryMetadata[1]
    var queries: [[Int]] = []
    for _ in 1...numQueries {
        queries.append(readInput().toIntArray())
    }
    doQueries(queries, numSequences: numSequences)
}

// Data Structures ->  Arrays ->  Sparse Arrays

func stringOccurs(strings: [String], query: String) -> Int {
    return strings.filter { $0 == query }.count
}

func sparseArraysDriver(readInput: () -> String) {
    let numStrings = Int(readInput())!
    var strings: [String] = []
    for _ in 1...numStrings {
        strings.append(readInput())
    }
    let numQueries = Int(readInput())!
    for _ in 1...numQueries {
        let query = readInput()
        print(stringOccurs(strings, query: query))
    }
}

// Algorithms ->  Implementation -> [Algo] Matrix Rotation

// calculates the matrix indices given some vertex index
// in the example matrix below , f(4) returns (3, 1)
// 0 b a 9
// 1     8  (<-- these are the vertex indices in hex)
// 2     7
// 3 4 5 6
func xyFromVertexIndex(index: Int, numRows: Int, numCols: Int, numVertices: Int) -> (x: Int, y: Int) {
    if index < numRows { // top left to bottom left
        return (index, 0)
    }
    if index < numRows + numCols - 1 { // bottom left to bottom right
        return (numRows - 1, index - numRows + 1)
    }
    let topRight = numVertices - numCols + 1
    if index <= topRight {  // bottom right to top right
        return (topRight - index, numCols - 1)
    }
    return (0, numVertices - index) // top
}

func rotateVertex(index: Int, numRotations: Int, numRows: Int, numCols: Int, numVertices: Int) -> (x: Int, y: Int) {
    let rotatedIndex = (index + numRotations) % numVertices
    return xyFromVertexIndex(rotatedIndex, numRows: numRows, numCols: numCols, numVertices: numVertices)
}

func rotateMatrixEdge(inout matrix: [[Int]], start: Int, numRows: Int, numCols: Int, numRotations: Int) {
    let numVertices = 2 * (numRows + numCols) - 4
    var vertexValues: [Int] = []
    for i in 0..<numVertices {
        let xyOffset = xyFromVertexIndex(i, numRows: numRows, numCols: numCols, numVertices: numVertices)
        let xy = (start + xyOffset.x, start + xyOffset.y)
        vertexValues.append(matrix[xy.0][xy.1])
    }
    for i in 0..<numVertices {
        let rotatedXyOffset = rotateVertex(i, numRotations: numRotations, numRows: numRows,
                                           numCols: numCols, numVertices: numVertices)
        let rotatedXy = (start + rotatedXyOffset.x, start + rotatedXyOffset.y)
        matrix[rotatedXy.0][rotatedXy.1] = vertexValues[i]
    }
}

func rotateMatrix(inout matrix: [[Int]], totalNumRows: Int, totalNumCols: Int, numTimes: Int) {
    var start = 0, numCols = totalNumCols, numRows = totalNumRows
    while numRows > 1 && numCols > 1 {
        rotateMatrixEdge(&matrix, start: start, numRows: numRows, numCols: numCols, numRotations: numTimes)
        start = start + 1
        numRows = numRows - 2
        numCols = numCols - 2
    }
}

func rotateMatrixDriver(readInput: () -> String) {
    let problemMetadata = readInput().toIntArray()
    let numRows = problemMetadata[0]
    let numCols = problemMetadata[1]
    let numRotations = problemMetadata[2]
    var matrix: [[Int]] = []
    for _ in 1...numRows {
        matrix.append(readInput().toIntArray())
    }
    rotateMatrix(&matrix, totalNumRows: numRows, totalNumCols: numCols, numTimes: numRotations)
    let matString = matrix.map { $0.map(String.init).joinWithSeparator(" ") }.joinWithSeparator("\n")
    print(matString)
}

var mat = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
]

rotateMatrix(&mat, totalNumRows: 4, totalNumCols: 4, numTimes: 1)
