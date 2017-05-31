import Foundation

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
            if largestSum == nil || currentSum > largestSum! {
                largestSum = currentSum
            }
        }
    }
    return largestSum!
}

func hourglassDriver() {
    var lines: [[Int]] = []
    for _ in 1...6 {
        let line = [Int](string: readLine()!)
        lines.append(line)
    }
    print(hourglass(input: lines))
}
