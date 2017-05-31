// Data Structures ->  Arrays ->  Dynamic Array

func query1(x: Int, y: Int, lastAns: Int, n: Int, seqList: inout [[Int]]) {
    let seqIndex = (x ^ lastAns) % n;
    seqList[seqIndex].append(y)
}

func query2(x: Int, y: Int, lastAns: inout Int, n: Int, seqList: inout [[Int]]) {
    let seqIndex = (x ^ lastAns) % n;
    var seq = seqList[seqIndex]
    lastAns = seq[y % seq.count]
    print(lastAns)
}

func doQueries(_ queries: [[Int]], numSequences: Int) {
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
            query1(x: x, y: y, lastAns: lastAns, n: numSequences, seqList: &seqList)
        }
        else {
            query2(x: x, y: y, lastAns: &lastAns, n: numSequences, seqList: &seqList)
        }
    }
}

func queryDriver() {
    let queryMetadata = [Int](string: readLine()!)
    let numSequences = queryMetadata[0]
    let numQueries = queryMetadata[1]
    var queries: [[Int]] = []
    for _ in 1...numQueries {
        let query = [Int](string: readLine()!)
        queries.append(query)
    }
    doQueries(queries, numSequences: numSequences)
}
