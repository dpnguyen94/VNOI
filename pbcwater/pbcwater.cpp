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

const int LM = 105;

int m, n, a[LM][LM], b[LM][LM], c[LM][LM];
int offx[] = {0,0,-1,1}, offy[] = {-1,1,0,0};
bool found = 1, x[LM * LM];

void input() {
    scanf("%d %d", &m, &n);
    FOR(i,1,m) 
        FOR(k,1,n) {
            scanf("%d", &a[i][k]);
            b[i][k] = a[i][k];
        }
}

void dfs(int i, int k, int cnt) {
    c[i][k] = cnt;    
    int i1, k1;
    REP(t,0,4) {
        i1 = i + offx[t];
        k1 = k + offy[t];
        
        if (i1 < 1 || i1 > m || k1 < 1 || k1 > n 
            || b[i1][k1] != b[i][k] || c[i1][k1] != 0) continue;
        
        dfs(i1,k1,cnt);
    }
}

void solve() {
    FOR(i,1,m)
        FOR(k,1,n) b[i][k] ++;
    
    memset(c,0,sizeof(c));
    memset(x,0,sizeof(x));
    int cnt = 0;
    FOR(i,1,m) 
        FOR(k,1,n) if (c[i][k] == 0) {
            cnt ++;
            dfs(i,k,cnt);
        }
    
    int i1, k1;    
    FOR(i,1,m) 
        FOR(k,1,n)
            REP(t,0,4) {
                i1 = i + offx[t];
                k1 = k + offy[t];
                
                if (b[i1][k1] < b[i][k]) x[c[i][k]] = 1;
            }            
            
    FOR(i,1,m) 
        FOR(k,1,n) if (x[c[i][k]]) b[i][k] --;
        else found = 1;
}

void process() {
    while (found) {
        found = 0;
        solve();
    }
    
    int res = 0;
    FOR(i,1,m)
        FOR(k,1,n) res += (b[i][k] - a[i][k]);
        
    printf("%d\n", res);
}

void output() {
}

int main() {
    freopen("pbcwater.inp", "r", stdin);
    freopen("pbcwater.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
