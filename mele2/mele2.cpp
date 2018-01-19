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

const LL LM = 1000000000000000005LL;

int a[3], base;
LL h, res, f[100005];
set< pair<LL,int> > q;

void input() {
    scanf("%lld", &h);
    REP(i,0,3) scanf("%d", &a[i]);
    sort(a,a + 3);
    base = a[0];
}

void process() {
    q.insert(mp(f[0] = 0,0));
    REP(i,1,base) f[i] = LM;
    int u, v;
    while (!q.empty()) {
        u = q.begin() -> second;
        q.erase(q.begin());
        REP(i,1,3) {
            v = (f[u] + a[i]) % base;
            if (f[v] > f[u] + a[i]) {
                if (f[v] < LM) q.erase(q.find(mp(f[v],v)));
                q.insert(mp(f[v] = f[u] + a[i],v));
            }
        }
    }
 
    res = h --;
    REP(i,0,base) {
        if (f[i] > h) res -= (h - i + base) / base;
        else res -= f[i] / base;
    }
}

void output() {
    printf("%lld", res);
}

int main() {
    //freopen("eabc.inp", "r", stdin);
    //freopen("eabc.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
