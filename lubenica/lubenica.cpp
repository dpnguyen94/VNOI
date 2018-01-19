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

const int MAXN = 100005;
const int LOGMAXN = 18;
const int INF = 1000000000;

int n, m, T[MAXN], L[MAXN], P[MAXN][LOGMAXN], M1[MAXN][LOGMAXN], M2[MAXN][LOGMAXN];
bool visit[MAXN];
vvii a;

void input() {
    scanf("%d", &n);
    a.resize(n);
    int u, v, t;
    REP(i,0,n - 1) {
        scanf("%d %d %d", &u, &v, &t);
        u --; v --;
        a[u].pb(mp(v,t));
        a[v].pb(mp(u,t));
    }
}

void dfs(int u) {
    visit[u] = 1;

    int v;
    REP(i,0,sz(a[u])) {
        v = a[u][i].first;
        if (!visit[v]) {
            T[v] = u;
            L[v] = L[u] + 1;
            P[v][0] = u;
            M1[v][0] = M2[v][0] = a[u][i].second;
            dfs(v);
        }
    }
}

int LCA1(int u, int v) {
    if (L[u] < L[v]) swap(u,v);
    
    //
    int log;
    for (log = 1; 1 << log <= L[u]; log ++);
    log --;
    
    //
    int minedge = INF;
    DOW(i,log,0) if (L[u] - (1 << i) >= L[v]) {
        minedge = min(minedge,M1[u][i]);        
        u = P[u][i];
    }
    
    if (u == v) return minedge;
    
    DOW(i,log,0) if (P[u][i] != -1 && P[u][i] != P[v][i]) {
        minedge = min(minedge,M1[u][i]);
        minedge = min(minedge,M1[v][i]);
        u = P[u][i], v = P[v][i];
    }
    
    minedge = min(minedge,min(M1[u][0],M1[v][0]));
    return minedge;
}

int LCA2(int u, int v) {
    if (L[u] < L[v]) swap(u,v);
    
    //
    int log;
    for (log = 1; 1 << log <= L[u]; log ++);
    log --;
    
    //
    int maxedge = -INF;
    DOW(i,log,0) if (L[u] - (1 << i) >= L[v]) {
        maxedge = max(maxedge,M2[u][i]);
        u = P[u][i];
    }
    
    if (u == v) return maxedge;
    
    DOW(i,log,0) if (P[u][i] != -1 && P[u][i] != P[v][i]) {
        maxedge = max(maxedge,M2[u][i]);
        maxedge = max(maxedge,M2[v][i]);
        u = P[u][i], v = P[v][i];
    }
    
    maxedge = max(maxedge,max(M2[u][0],M2[v][0]));
    return maxedge;
}

void process() {
    REP(i,0,n)
        for (int k = 0; 1 << k < n; k ++) {
            P[i][k] = -1;
            M1[i][k] = INF;
            M2[i][k] = -INF;
        }
    
    T[0] = -1, L[0] = 0;
    dfs(0);
    for (int k = 1; 1 << k < n; k ++)
        REP(i,0,n) if (P[i][k - 1] != -1) {
            P[i][k] = P[P[i][k - 1]][k - 1];
            M1[i][k] = min(M1[i][k - 1],M1[P[i][k - 1]][k - 1]);
            M2[i][k] = max(M2[i][k - 1],M2[P[i][k - 1]][k - 1]);
        }
    
    //
    scanf("%d", &m);
    int u, v;
    REP(i,0,m) {
        scanf("%d %d", &u, &v);
        u --; v --;
        printf("%d %d\n", LCA1(u,v), LCA2(u,v));
    }
}

void output() {
}

int main() {
    //freopen("lubenica.inp", "r", stdin);
    //freopen("lubenica.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
