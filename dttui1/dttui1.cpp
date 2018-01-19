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

const int MAXN = 45;

int n, m, half1, half2, w[MAXN], v[MAXN];
vector< pair<LL,LL> > a, b;

void input() {
    scanf("%d %d", &n, &m);
    REP(i,0,n) scanf("%d %d", &w[i], &v[i]);
    
    half1 = n / 2;
    half2 = n - half1;
}

void process() {
    LL wt, vt;
    REP(mask,0,1 << half1) {
        wt = vt = 0;
        REP(i,0,half1) if ((mask >> i) & 1) {
                wt += w[i];
                vt += v[i];
            }

        a.pb(mp(wt,vt));
    }
    
    REP(mask,0,1 << half2) {
        wt = vt = 0;
        REP(i,0,half2) if ((mask >> i) & 1) {
                wt += w[i + half1];
                vt += v[i + half1];
            }
            
        b.pb(mp(wt,vt));
    }
    
    sort(all(a));
    sort(all(b));
    
    REP(i,1,sz(a)) if (a[i].second < a[i - 1].second) a[i].second = a[i - 1].second;
    REP(i,1,sz(b)) if (b[i].second < b[i - 1].second) b[i].second = b[i - 1].second;


    int k = sz(b) - 1;
    LL t, res = 0;
    REP(i,0,sz(a)) {
        while (k > 0 && a[i].first + b[k].first > m) k --;
        if (a[i].first + b[k].first <= m) {
            t = a[i].second + b[k].second;
            if (t > res) res = t;
        }
    }
    
    printf("%I64d\n", res);
}

void output() {
}

int main() {
    //freopen("dttui1.inp", "r", stdin);
    //freopen("dttui1.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
