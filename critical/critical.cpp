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

const int MAXN = 20005;
const int INF = 1000000000;

int n, m, nc, comp, cnt, id[MAXN], c[MAXN], f[MAXN], num[MAXN], low[MAXN];
LL res;
vvi a;

void input() {
    scanf("%d %d", &n, &m);
    a.resize(n);
    int u, v;
    REP(i,0,m) {
        scanf("%d %d", &u, &v);
        u --; v --;
        a[u].pb(v);
        a[v].pb(u);
    }
}

void dfs(int u) {
    comp ++;
    id[u] = nc;
    
    int v;
    REP(i,0,sz(a[u])) {
        v = a[u][i];
        if (id[v] == 0) dfs(v);
    }
}

void visit(int u) {
    num[u] = ++ cnt;
    low[u] = INF;
    f[u] = 1;
    
    int v, t = 0;
    REP(i,0,sz(a[u])) {
        v = a[u][i];
        
        if (num[v] > 0) low[u] = min(low[u],num[v]);
        else {
            visit(v);
            low[u] = min(low[u],low[v]);
            f[u] += f[v];
            
            if (low[v] >= num[u]) {
                t += f[v];                
                res += (LL)(c[id[u]] - t - 1) * f[v];
            }
        }
    }
}

void process() {
    REP(i,0,n) if (id[i] == 0) {
        nc ++;
        comp = 0;
        dfs(i);
        c[nc] = comp;
    }
    
    REP(i,0,n) if (num[i] == 0) visit(i);
    printf("%.2f\n", (double)res / n);
}

void output() {
}

int main() {
    //freopen("critical.inp", "r", stdin);
    //freopen("critical.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
