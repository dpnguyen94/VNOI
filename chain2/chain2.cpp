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

const int LM = 250005;

int m, cnt;
string s;

struct Trie {
    bool w;
    int e[26], num;
} v[LM];

void addWords(int i, int k) {
    if (k == s.length()) {
        v[i].w = 1;
        return;
    }
    
    int id = s[k] - 'a';
    if (v[i].e[id] == 0) {
        v[i].e[id] = ++ cnt;
    }
    addWords(v[i].e[id],k + 1);    
}

void input() {
    scanf("%d", &m);
    REP(i,0,m) {
        cin >> s;
        addWords(0,0);
    }
}

void dfs(int i) {
    int child;
    REP(k,0,26) {
        child = v[i].e[k];
        if (child == 0) continue;
        
        dfs(child);
        v[i].num = max(v[i].num,v[child].num + v[child].w);
    }
}

void process() {
    dfs(0);
    
    printf("%d\n", v[0].num);
}

void output() {
}

int main() {
    //freopen("chain2.inp", "r", stdin);
    //freopen("chain2.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
