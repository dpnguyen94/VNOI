#include <stdio.h>
#include <math.h>
#include <limits.h>
#include <memory.h>
#include <algorithm>
#include <numeric>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <queue>
#include <stack>
#include <map>
#include <set>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 		for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c,it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef pair<int, int> 	ii;
typedef pair<ii, int> 	iii;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef vector<ii> 	    vii;
typedef vector<vii> 	vvii;

const int MAXN = 4005;
const int LM = 105 * MAXN;
const int MOD = 1337377;

struct Trie {
    bool w;
    int e[26];
} v[LM];

int n, cnt, f[300005];
string s, str;

inline void addWords(int i, int k) {
    if (k == str.length()) {
        v[i].w = 1;
        return;        
    }
    
    int id = str[k] - 'a';
    if (v[i].e[id] == 0) {
        v[i].e[id] = ++cnt;
    }
    
    addWords(v[i].e[id],k + 1);
}

inline int isWord(int i, int k) {
    if (k == str.length()) return i;
    
    int id = str[k] - 'a';
    if (v[i].e[id] == 0) return -1;
    return isWord(v[i].e[id],k + 1);
}

void input() {
    cin >> s;
    scanf("%d\n", &n);
    REP(i,0,n) {
        cin >> str;
        scanf("\n");
        
        reverse(all(str));
        addWords(0,0);
    }
}

void process() {
    n = s.length();
    s = ' ' + s;

    int last;    
    f[0] = 1;
    FOR(i,1,n) {
        str = "";
        last = 0;
        DOW(k,i,max(1,i - 99)) {
            str += s[k];
            
            last = isWord(last,str.length() - 1);
            if (last == -1) break;
            if (v[last].w) f[i] = (f[i] + f[k - 1]) % MOD;
        }
    }
    
    printf("%d\n", f[n]);
}

void output() {
}

int main() {
    //freopen("nksev.inp", "r", stdin);
    //freopen("nksev.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
