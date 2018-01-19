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
#define FOR(i,a,b) 	    for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 	    for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c, it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef pair<int, int> 	pii;
typedef pair<pii, int> 	piii;

const int MAXN = 505;
const int LM = 1000000000;

int n, m, p, b[MAXN], d[MAXN], res;
vector< vector<pii> > a;
set<pii> q;

void input() {
    scanf("%d %d %d", &n, &p, &m);
    a.resize(n);

    REP(i,0,p) {
        scanf("%d", &b[i]);
        b[i] --;
    }
    int u, v, t;
    REP(i,0,m) {
        scanf("%d %d %d", &u, &v, &t);
        u --; v --;
        a[u].pb(mp(v,t));
        a[v].pb(mp(u,t));
    }
}

void solve(int s) {
    REP(i,0,n) d[i] = LM;
    q.clear();
    q.insert(mp(d[s] = 0,s));

    int u, v, t;
    while (!q.empty()) {
        u = q.begin() -> second;
        q.erase(q.begin());
        TR(a[u],it) {
            v = it -> first, t = it -> second;
            if (d[v] > d[u] + t) {
                if (d[v] < LM) q.erase(q.find(mp(d[v],v)));
                q.insert(mp(d[v] = d[u] + t,v));
            }
        }
    }
}

void process() {
    int best = LM;
    REP(i,0,n) {
        solve(i);
        
        int sum = 0;
        REP(k,0,p) sum += d[b[k]];
        if (sum < best) {
            best = sum;
            res = i;
        }
    }
}

void output() {
    printf("%d", res + 1);
}

int main() {
//    freopen("bestspot.inp", "r", stdin);
//    freopen("bestspot.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
