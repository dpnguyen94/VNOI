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
const double INF = 1000000000.0;

int n, x[MAXN], y[MAXN], s[MAXN], a[MAXN][MAXN];
double d[MAXN];
set< pair<double,int> > q;

void input() {
    scanf("%d", &n);
    REP(i,0,n) {
        scanf("%d %d %d", &x[i], &y[i], &s[i]);
        REP(k,0,n - 1) {
            scanf("%d", &a[i][k]);
            a[i][k] --;
        }
    }
}

double dist(int i, int k) {
    int X = x[i] - x[k], Y = y[i] - y[k];
    return sqrt(X * X + Y * Y);
}

void process() {
    REP(i,1,n) d[i] = INF;
    q.insert(mp(d[0] = 0.0,0));
    
    int u, v, cnt;
    double t;
    while (!q.empty()) {
        u = q.begin()->second;
        q.erase(q.begin());
        
        cnt = 0;
        REP(i,0,n - 1) {
            v = a[u][i];
            if (d[v] > d[u]) {
                t = dist(u,v);
                if (d[v] > d[u] + t) {
                    if (d[v] < INF) q.erase(q.find(mp(d[v],v)));
                    q.insert(mp(d[v] = d[u] + t,v));
                }
                
                cnt ++;
                if (cnt == s[u]) break;
            }
        }
    }
    
    REP(i,0,n) printf("%.6f\n", d[i]);
}

void output() {
}

int main() {
    //freopen("gondor.inp", "r", stdin);
    //freopen("gondor.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
