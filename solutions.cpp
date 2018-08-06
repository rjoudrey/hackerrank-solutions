// -------------------------------- Count Triplets --------------------------------
// https://www.hackerrank.com/challenges/count-triplets-1

long countTriplets(vector<long> A, long r) {
    unordered_map<long, long> F, S;
    long count = 0;
    for (auto it = A.rbegin(); it != A.rend(); it++) {
        count += S[*it * r];
        S[*it] += F[*it * r];
        F[*it]++;
    }
    return count;
}

// -------------------------------- Triple sum --------------------------------
// https://www.hackerrank.com/challenges/triple-sum

// Create a map of value -> index
const map<int, int> mapElements(const vector<int> &A) {
    map<int, int> map;
    for (int i = 0; i < A.size(); ++i) {
        map[A[i]] = i;
    }
    return map;
}

// Assumes the vector is sorted and the minimum element is 1
const vector<int> removeDuplicates(const vector<int> &A) {
    vector<int> B;
    // the last distinct element in A that we've seen so far
    int Ald = 0;
    for (int a : A) {
        if (a != Ald) {
            B.push_back(a);
            Ald = a;
        }
    }
    return B;
}

const long numGreaterThan(const map<int, int> &M, int v) {
    // upper bound of v in M
    auto Mu = M.upper_bound(v);
    if (Mu == M.end()) {
        return M.size();
    }
    return Mu->second;
}

// Complete the triplets function below.
long triplets(vector<int> A, vector<int> B, vector<int> C) {
    // sort all of the vectors
    sort(A.begin(), A.end());
    sort(B.begin(), B.end());
    sort(C.begin(), C.end());
    
    // remove duplicates from the vectors
    auto A2 = removeDuplicates(A);
    auto B2 = removeDuplicates(B);
    auto C2 = removeDuplicates(C);
    
    // create maps of a2 and c2
    auto A2M = mapElements(A2);
    auto C2M = mapElements(C2);
    
    // get # of triplets
    long count = 0;
    for (int b: B2) {
        count += numGreaterThan(A2M, b) * numGreaterThan(C2M, b);
    }    
    return count;
}

// -------------------------------- Pairs --------------------------------
// https://www.hackerrank.com/challenges/pairs

// Complete the pairs function below.
int pairs(int money, vector<int> cost) {
    unordered_map<int, int> indexForDiff;
    for (int i = 0; i < cost.size(); ++i) {
        int c = cost[i];
        indexForDiff[money + c] = i;
    }
    
    int pairs = 0;
    for (int i = 0; i < cost.size(); ++i) {
        int c = cost[i];
        auto it = indexForDiff.find(c);
        if (it != indexForDiff.end()) {
            ++pairs;
        }
    }
    return pairs;
}

// --------------------- Hash Tables: Ice Cream Parlor ---------------------
// https://www.hackerrank.com/challenges/pairs

void whatFlavors(vector<int> cost, int money) {
    unordered_map<int, int> indexForDiff;
    for (int i = 0; i < cost.size(); ++i) {
        int c = cost[i];
        indexForDiff[money - c] = i;
    }
    
    for (int i = 0; i < cost.size(); ++i) {
        int c = cost[i];
        auto it = indexForDiff.find(c);
        if (it != indexForDiff.end()) {
            printf("%d %d\n", i + 1, it->second + 1);
            return;
        }
    }
}

// ------------------ Trees: Is This a Binary Search Tree? ------------------
// https://www.hackerrank.com/challenges/ctci-is-binary-search-tree/problem

void sort(Node *root, vector<Node *> &output) {
    if (root == NULL) {
        return;
    }
    sort(root->left, output);
    output.push_back(root);
    sort(root->right, output);
}

bool checkBST(Node* root) {
    vector<Node *> sorted;
    sort(root, sorted);
    int last = 0;
    for (auto n : sorted) {
        if (n->data <= last) {
            return false;
        }
        last = n->data;
    }
    return true;
}

// https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem
// ------------------ Sherlock and the Valid String ------------------

string isValid(string s) {
    unordered_map<char, int> frequencies;
    // get frequencies of all the characters
    for (char c : s) {
        frequencies[c]++;
    }
    // get frequencies of the frequencies
    unordered_map<char, int> freakyFrequencies;
    for (auto it : frequencies) {
        freakyFrequencies[it.second]++;
    }    
    int size = freakyFrequencies.size();
    // is there only 1 unique frequency?
    if (size == 1) {
        return "YES";
    }
    if (size == 2) {
        pair<int, int> high, low;
        for (auto it : freakyFrequencies) {
            if (it.first > high.first) {
                high = it;
            }
            if (it.first < low.first) {
                low = it;
            }
            if (it.first == 1 && it.second == 1) {
                return "YES";
            }
        }
        if (high.second == 1 && high.first - low.first == 1) {
            return "YES";
        }
    }
    return "NO";
}

