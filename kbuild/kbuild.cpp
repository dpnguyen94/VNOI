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

const int MAXN = 200005;
const int INF = 1000000000;

int n, m, cnt, res, par[MAXN], num[MAXN], low[MAXN];
vvi a;

void input() {
    scanf("%d", &n);
    a.resize(n);
    int u, v;
    REP(i,0,n - 1) {
        scanf("%d %d", &u, &v);
        u --; v --;
        a[u].pb(v);
        a[v].pb(u);
    }
    scanf("%d", &m);
    REP(i,0,m) {
        scanf("%d %d", &u, &v);
        u --; v --;
        a[u].pb(v);
        a[v].pb(u);
    }
}

void dfs(int u) {
    num[u] = ++ cnt;
    low[u] = INF;
    
    int v;
    REP(i,0,sz(a[u])) {
        v = a[u][i];
        if (v == par[u]) continue;
        
        if (num[v] > 0) low[u] = min(low[u],num[v]);
        else {
            par[v] = u;
            dfs(v);
            low[u] = min(low[u],low[v]);
            
            if (low[v] >= num[v]) res ++;
        }
    }
}

void process() {
    dfs(0);
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("kbuild.inp", "r", stdin);
    //freopen("kbuild.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
