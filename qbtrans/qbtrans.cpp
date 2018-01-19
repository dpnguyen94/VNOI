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

const int MAXN = 105;
const int INF = 1000000000;

int n, m, d[MAXN][MAXN];
vvii a;
set< pair<int,ii> > q;

void input() {
    scanf("%d %d", &n, &m);
    a.resize(n);
    int u, v, t;
    REP(i,0,m) {
        scanf("%d %d %d", &u, &v, &t);
        u --; v --;
        
        a[u].pb(mp(v,t));
    }
}

void dijkstra(int s) {
    q.clear();
    REP(i,0,n) 
        FOR(k,0,n) d[i][k] = INF;
    
    q.insert(mp(d[s][0] = 0,mp(s,0)));
    int u, v, x, y, t;
    ii p;
    while (!q.empty()) {
        p = q.begin()->second, u = p.first, x = p.second;
        q.erase(q.begin());
        
        if (u == s && x > 0) continue;
        if (x == n) continue;

        TR(a[u],it) {
            v = it->first;
            t = it->second;
            y = x + 1;                  
            if (d[v][y] > d[u][x] + t) {
                if (d[v][y] < INF) q.erase(mp(d[v][y],mp(v,y)));
                q.insert(mp(d[v][y] = d[u][x] + t,mp(v,y)));
            }
        }        
    }
}

void process() {
    double res = INF * 1.0;
    REP(i,0,n) {
        dijkstra(i);
        FOR(k,1,n) if (d[i][k] != INF) res = min(res,(double)d[i][k] / k);
    }
    
    if (res == INF) printf("-1\n");
    else printf("%.2f\n", res);
}

void output() {
}

int main() {
    //freopen("qbtrans.inp", "r", stdin);
    //freopen("qbtrans.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
