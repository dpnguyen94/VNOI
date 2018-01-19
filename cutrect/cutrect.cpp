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

const int LM = 405;
const LL INF = 1000000000000000000LL;

int n, m, a[LM][LM], b[LM][LM];
int offx[] = {-1,1,0,0}, offy[] = {0,0,-1,1};
LL d[LM][LM];
set< pair<LL,ii> > q;

void input() {
    scanf("%d %d", &m, &n);    
    FOR(i,1,m) 
        FOR(k,1,n - 1) scanf("%d", &a[i][k]);
    FOR(i,1,m - 1) 
        FOR (k,1,n) scanf("%d", &b[i][k]);
}

void process() {
    FOR(i,0,m)
        FOR(k,0,n) d[i][k] = INF;
    d[0][0] = d[0][n] = d[m][0] = d[m][n] = 0;
            
    FOR(i,1,m - 1) q.insert(mp(d[i][0] = 0,mp(i,0)));
    FOR(i,1,n - 1) q.insert(mp(d[m][i] = 0,mp(m,i)));
    
    LL res = INF;
    ii p;
    int x, y, u, v, t;
    while (!q.empty()) {
        p = q.begin()->second;
        x = p.first, y = p.second;        
        q.erase(q.begin());

        if (x == 0 || y == n) {
            if (d[x][y] < res) res = d[x][y];
            continue;
        }
        
        REP(i,0,4) {
            u = x + offx[i];            
            v = y + offy[i];
            
            if (u < 0 || u > m || v < 0 || v > n) continue;
            
            if (i == 0) t = a[x][y];
            if (i == 1) t = a[x + 1][y];
            if (i == 2) t = b[x][y];
            if (i == 3) t = b[x][y + 1];
            
            if (d[u][v] > d[x][y] + t) {
                if (d[u][v] < INF) q.erase(q.find(mp(d[u][v],mp(u,v))));
                q.insert(mp(d[u][v] = d[x][y] + t,mp(u,v)));
            }
        }
    }
    
    printf("%lld\n", res);
}

void output() {
}

int main() {
    //freopen("cutrect.inp", "r", stdin);
    //freopen("cutrect.out", "w", stdout);

    input();
    if (m == 1 && n == 1) printf("-1");
    else process();
    output();

    return 0;
}
