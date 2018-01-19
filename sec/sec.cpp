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

const int LM = 500005;

struct Trie {
    int e[2], w, num;
} v[LM];

int m, n, cnt, len;
int a[10005];

void addWords(int i, int k) {
    if (k == len) {
        v[i].w ++;
        return;
    }
    
    if (v[i].e[a[k]] == 0) {
        v[i].e[a[k]] = ++ cnt;
    }
    addWords(v[i].e[a[k]],k + 1);
}

void dfs(int i) {
    int child;
    FOR(k,0,1) {
        child = v[i].e[k];
        if (child == 0) continue;
        
        dfs(child);
        v[i].num += (v[child].num + v[child].w);
    }
}

void input() {
    scanf("%d %d", &m, &n);
    REP(i,0,m) {
        scanf("%d", &len);
        REP(k,0,len) scanf("%d", &a[k]);
        
        addWords(0,0);
    }
}

int countWords(int i, int k) {
    cnt += v[i].w;
    if (k == len) return (cnt + v[i].num);
    
    if (v[i].e[a[k]] == 0) return cnt;
    else return countWords(v[i].e[a[k]],k + 1);
}

void process() {
    dfs(0);
    REP(i,0,n) {
        scanf("%d", &len);
        REP(k,0,len) scanf("%d", &a[k]);
        
        cnt = 0;    
        printf("%d\n", countWords(0,0));
    }
}

void output() {
}

int main() {
    //freopen("sec.inp", "r", stdin);
    //freopen("sec.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
