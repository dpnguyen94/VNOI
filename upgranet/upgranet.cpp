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

const int LM = 100005;
const int LOGLM = 18;
const int INF = 1000000000;

struct edge {
    int x, y, t;
    bool mark;
} e[LM];

bool operator < (edge e1, edge e2) {
    return e1.t > e2.t;
}

int n, m, rank[LM], root[LM], T[LM], L[LM], P[LM][LOGLM], M[LM][LOGLM];
bool visit[LM];
vvii a;

void input() {
    scanf("%d %d", &n, &m);
    REP(i,0,m) {
        scanf("%d %d %d", &e[i].x, &e[i].y, &e[i].t);
        e[i].x --; e[i].y --;
    }
    sort(e,e + m);
}

int find_set(int u) {
    if (u != root[u]) root[u] = find_set(root[u]);
    return root[u];
}

void merge_set(int ru, int rv) {
    if (rank[ru] > rank[rv]) root[rv] = ru;
    else root[ru] = rv;
    if (rank[ru] == rank[rv]) rank[rv] ++;
}

void buildtree() {
    REP(i,0,n) {
        root[i] = i;
        rank[i] = 0;
    }
    
    int u, v, ru, rv, cnt = 0;
    a.resize(n);
    REP(i,0,m) {
        u = e[i].x;
        v = e[i].y;
        
        ru = find_set(u);
        rv = find_set(v);
        
        if (ru != rv) {
            merge_set(ru,rv);
            e[i].mark = 1;
            cnt ++;
            
            a[u].pb(mp(v,e[i].t));
            a[v].pb(mp(u,e[i].t));
            
            if (cnt == n - 1) break;   
        }
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
            M[v][0] = a[u][i].second;
            dfs(v);
        }
    }
}

int LCA(int u, int v) {
    if (L[u] < L[v]) swap(u,v);
    
    //
    int log;
    for (log = 1; 1 << log <= L[u]; log ++);
    log --;
    
    //
    int minedge = INF;
    DOW(i,log,0) if (L[u] - (1 << i) >= L[v]) {
        minedge = min(minedge,M[u][i]);        
        u = P[u][i];
    }
    
    if (u == v) return minedge;
    
    DOW(i,log,0) if (P[u][i] != -1 && P[u][i] != P[v][i]) {
        minedge = min(minedge,M[u][i]);
        minedge = min(minedge,M[v][i]);
        u = P[u][i], v = P[v][i];
    }
    
    minedge = min(minedge,min(M[u][0],M[v][0]));
    return minedge;
}

void process() {
    REP(i,0,n) 
        for (int k = 0; 1 << k < n; k ++) {
            P[i][k] = -1;
            M[i][k] = INF;
        }
        
    T[0] = -1; L[0] = 0;
    dfs(0);
    for (int k = 1; 1 << k < n; k ++)
        REP(i,0,n) if (P[i][k - 1] != -1) {
            P[i][k] = P[P[i][k - 1]][k - 1];
            M[i][k] = min(M[i][k - 1],M[P[i][k - 1]][k - 1]);
        }
        
    LL res = 0;
    int tmp;
    REP(i,0,m) if (!e[i].mark) {
        tmp = LCA(e[i].x,e[i].y);
        res += (tmp - e[i].t);
    }
    
    printf("%lld\n", res);
}

void output() {
}

int main() {
    //freopen("upgranet.inp", "r", stdin);
    //freopen("upgranet.out", "w", stdout);

    input();
    buildtree();
    process();
    output();

    return 0;
}
