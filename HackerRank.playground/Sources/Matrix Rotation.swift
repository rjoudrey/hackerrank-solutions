// Algorithms ->  Implementation -> [Algo] Matrix Rotation

// calculates the matrix indices given some vertex index
// in the example matrix below , f(4) returns (3, 1)
// 0 b a 9
// 1     8  (<-- these are the vertex indices in hex)
// 2     7
// 3 4 5 6

func xyFromVertexIndex(_ index: Int, numRows: Int, numCols: Int, numVertices: Int) -> (x: Int, y: Int) {
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

func rotateMatrixEdge( matrix: inout [[Int]], start: Int, numRows: Int, numCols: Int, numRotations: Int) {
    let numVertices = 2 * (numRows + numCols) - 4
    var vertexValues: [Int] = []
    for i in 0..<numVertices {
        let xyOffset = xyFromVertexIndex(i, numRows: numRows, numCols: numCols, numVertices: numVertices)
        let xy = (start + xyOffset.x, start + xyOffset.y)
        vertexValues.append(matrix[xy.0][xy.1])
    }
    for i in 0..<numVertices {
        let rotatedXyOffset = rotateVertex(index: i, numRotations: numRotations, numRows: numRows,
                                           numCols: numCols, numVertices: numVertices)
        let rotatedXy = (start + rotatedXyOffset.x, start + rotatedXyOffset.y)
        matrix[rotatedXy.0][rotatedXy.1] = vertexValues[i]
    }
}

func rotateMatrix( matrix: inout [[Int]], totalNumRows: Int, totalNumCols: Int, numTimes: Int) {
    var start = 0, numCols = totalNumCols, numRows = totalNumRows
    while numRows > 1 && numCols > 1 {
        rotateMatrixEdge(matrix: &matrix, start: start, numRows: numRows, numCols: numCols, numRotations: numTimes)
        start = start + 1
        numRows = numRows - 2
        numCols = numCols - 2
    }
}

func rotateMatrixDriver() {
    let problemMetadata = [Int](string: readLine()!)
    let numRows = problemMetadata[0]
    let numCols = problemMetadata[1]
    let numRotations = problemMetadata[2]
    var matrix: [[Int]] = []
    for _ in 1...numRows {
        let row = [Int](string: readLine()!)
        matrix.append(row)
    }
    rotateMatrix(matrix: &matrix, totalNumRows: numRows, totalNumCols: numCols, numTimes: numRotations)
    let matString = matrix.map { $0.map(String.init).joined(separator: " ") }.joined(separator: "\n")
    print(matString)
}
