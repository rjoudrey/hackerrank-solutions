// All Contests -> World CodeSprint 11 -> Numeric String

// the result of (a^b * c) mod m
func modularExponentiation(base a: Int, exponent b: Int, coefficient c: Int, modulus m: Int) -> Int {
    // 1. Find the exponent of the largest power of 2 less than b, assuming b > 0.
    let e: Int
    do {
        var k = b
        var n = -1
        while k != 0 {
            k = k >> 1
            n += 1
        }
        e = n
    }
    // 2. Since (a^b * c) mod m = ((a^b mod m) * (c mod m)) mod m, solve (a^b mod m) first.
    // Using, multiplication property again, break a^b into multiple numbers multiplied together, each with a power of two exponent.
    let k: Int
    do {
        var n = 0
        var p = a % m
        var t = 1
        while n <= e {
            if (1 << n) & b > 0 {
                t = (t * p) % m
            }
            p = (p * p) % m
            n += 1
        }
        k = t
    }
    // 3. Solve (c mod m) and combine with previous result
    return ((c % m) * k) % m
}

// b = base
// k = substring len (assumed to be <= k)
// m = modulus
// s = input string
func numericString(s: String, k: Int, b: Int, m: Int) -> Int {
    var hash = 0
    var sum = 0
    for (i, c) in s.characters.prefix(k).reversed().enumerated() {
        let c = Int(String(c))!
        let p = modularExponentiation(base: b, exponent: i, coefficient: c, modulus: m)
        hash = (hash + p) % m
    }
    sum = hash
    for (a, r) in zip(s.characters.dropFirst(k), s.characters) {
        // Remove old character (e.g. 122_3 -> 22_3)
        let d = modularExponentiation(base: b, exponent: k - 1, coefficient: Int(String(r))!, modulus: m)
        hash = (hash - d + m) % m
        
        // Shift digits left once (e.g. 22_3 -> 220_3)
        hash = modularExponentiation(base: b, exponent: 1, coefficient: hash, modulus: m)
        
        // Add new character (e.g. 220_3 -> 221_3)
        let s = modularExponentiation(base: b, exponent: 0, coefficient: Int(String(a))!, modulus: m)
        hash = (hash + s) % m
        
        sum += hash
    }
    return sum
}

func numericStringDriver() {
    let line1 = readLine()! // e.g. "111101"
    let line2 = readLine()! // e.g. "4 2 15"
    let v = [Int](string: line2)
    let answer = numericString(s: line1, k: v[0], b: v[1], m: v[2])
    print(answer)
}
