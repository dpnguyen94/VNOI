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
const int INF = 100000000;

int n, n1, n2, x[10], y[10], vt[MAXN][2], c[MAXN], d[MAXN];
bool mark[MAXN][MAXN];
vvii a;
set<ii> q;

void input() {
    scanf("%d", &n);
    a.resize(2 * n);
    REP(i,0,n) {
        vt[i][0] = 2 * i;
        vt[i][1] = 2 * i + 1;
    }
    
    int id, len, u, v;
    REP(i,0,n) {
        scanf("%d %d %d %d", &id, &len, &n1, &n2);
        id --;
        
        a[vt[id][0]].pb(mp(vt[id][1],len));
        a[vt[id][1]].pb(mp(vt[id][0],len));

        REP(i,0,n1) {
            scanf("%d", &x[i]);
            x[i] --;
        }
        if (!mark[id][x[0]]) {
            u = vt[id][c[id]];
            REP(i,0,n1) {
                v = vt[x[i]][c[x[i]]++];
                a[u].pb(mp(v,0));
                a[v].pb(mp(u,0));
                
                mark[id][x[i]] = mark[x[i]][id] = 1;
            }
            REP(i,0,n1) 
                REP(k,0,n1) if (i != k) mark[x[i]][x[k]] = 1;
                
            c[id] ++;
        }
        
        REP(i,0,n2) {
            scanf("%d", &x[i]);
            x[i] --;
        }
        if (!mark[id][x[0]]) {
            u = vt[id][c[id]];
            REP(i,0,n2) {
                v = vt[x[i]][c[x[i]]++];
                a[u].pb(mp(v,0));
                a[v].pb(mp(u,0));
                
                mark[id][x[i]] = mark[x[i]][id] = 1;
            }
            REP(i,0,n2) 
                REP(k,0,n2) if (i != k) mark[x[i]][x[k]] = 1;
        }
    }
    
    /*
    REP(i,0,2 * n) {
        printf("%d: ", i / 2 + 1);
        REP(k,0,sz(a[i])) printf("%d(%d) ", a[i][k].first / 2 + 1, a[i][k].second);
        printf("\n");
    }
    */
}

int dijkstra(int s, int t) {
    REP(i,0,2 * n) d[i] = INF;
    q.clear();
    q.insert(mp(d[s] = 0,s));
    
    int u, v, k;
    while (!q.empty()) {
        u = q.begin()-> second;
        q.erase(q.begin());
        
        if (u == t) break;
        
        REP(i,0,sz(a[u])) {
            v = a[u][i].first, k = a[u][i].second;
            if (d[v] > d[u] + k) {
                if (d[v] < INF) q.erase(q.find(mp(d[v],v)));
                q.insert(mp(d[v] = d[u] + k,v));
            }
        }
    }
    
    return d[t];
}

void process() {
    int res = INF, save;
    REP(i,0,2 * n) {
        if (i % 2 == 1) continue;
                
        REP(k,0,sz(a[i])) if (a[i][k].first == i + 1) {
            save = a[i][k].second;
            a[i][k].second = INF;
            res = min(res, dijkstra(i,i + 1) + save);
            a[i][k].second = save;
            break;
        }
    }    
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("tnhfence.inp", "r", stdin);
    //freopen("tnhfence.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
