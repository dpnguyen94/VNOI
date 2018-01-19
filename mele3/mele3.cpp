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

const int MAXN = 1005;
const int LM = 1000000000;

int n, m, d[MAXN];
vvii a;
set<ii> q;

void input() {
    scanf("%d %d", &n, &m);    
    a.resize(n);
    int u, v, t;
    REP(i,0,m) {
        scanf("%d %d", &u, &v);
        u --; v --;
        t = v - u;
        a[u].pb(mp(v,t));
        a[v].pb(mp(u,t));
    }
}

void process() {
    REP(i,0,n) d[i] = LM;
    q.insert(mp(d[0] = 0,0));
    int u, v, t, k, x;
    while (!q.empty()) {
        u = q.begin()->second;        
        q.erase(q.begin());
        
        TR(a[u],it) {
            v = it->first, t = it->second;
            
            k = d[u] / t;
            if (u < v) {
                if (d[u] % t == 0) {
                    if (k % 2 == 0) x = d[u];
                    else x = t * (k + 1);   
                }
                else {
                    if (k % 2 == 0) x = t * (k + 2);
                    else x = t * (k + 1);
                }
            }
            else {
                if (d[u] % t == 0) {
                    if (k % 2 == 1) x = d[u];
                    else x = t * (k + 1);
                }
                else {
                    if (k % 2 == 1) x = t * (k + 2);
                    else x = t * (k + 1);
                }
            }
            
            if (x + t < d[v]) {
                if (d[v] < LM) q.erase(q.find(mp(d[v],v)));
                q.insert(mp(d[v] = x + t,v));
            }    
        }
    }
}

void output() {
    printf("%d", 5 * (LL)d[n - 1]);
}

int main() {
    //freopen("mele3.inp", "r", stdin);
    //freopen("mele3.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
