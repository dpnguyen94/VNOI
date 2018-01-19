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

const int MAXN = 5005;
const ULL INF = 18446744073709551615ULL;

int n, s[MAXN];
LL smax = 0, cmax, smin = INF, cmin;
vii p;
vvii a;

void input() {
    scanf("%d", &n);
    int x, y;
    REP(i,0,n) {
        scanf("%d %d", &x, &y);
        p.pb(mp(x,y));  
    }
    
    sort(all(p));
    int cnt = 1;
    REP(i,1,n) if (p[i].first > p[i - 1].first) cnt ++;
    a.resize(cnt);
    
    cnt = 0;
    a[0].pb(p[0]);
    REP(i,1,sz(p)) {
        if (p[i].first > p[i - 1].first) cnt ++;
        a[cnt].pb(p[i]);
    }
    REP(i,0,sz(a)) s[i] = sz(a[i]);
}

void process() {
    int le, ri;
    ULL t, y1, y2, area, res = 0, c;
    REP(i,0,sz(a) - 1)
        REP(k,i + 1,sz(a)) {
            le = ri = 0, y1 = INF, t = (LL)a[k][0].first - a[i][0].first, c = 0;
            while (le < s[i] && ri < s[k]) {
                if (a[i][le].second == a[k][ri].second) {
                    c ++;
                    if (y1 == INF) {
                        y1 = a[i][le].second;
                        y2 = y1;
                    }
                    else {
                        area = (a[i][le].second - y1) * t;
                        if (area > smax) {
                            smax = area;
                            cmax = 1;
                        } else if (area == smax) cmax ++;
                        
                        area = (a[i][le].second - y2) * t;
                        if (area < smin) {
                            smin = area;
                            cmin = 1;
                        } else if (area == smin) cmin ++;
                        
                        y2 = a[i][le].second;
                    }
                    le ++; 
                    ri ++;   
                }
                else {
                    if (a[i][le].second < a[k][ri].second) le ++;
                    else ri ++;
                }
            }
            
            res += c * (c - 1) / 2;
        }
        
    printf("%llu\n", res);
    if (res > 0) printf("%llu %llu\n%llu %llu\n", smax, cmax, smin, cmin);
}

void output() {
}

int main() {
    //freopen("castle.inp", "r", stdin);
    //freopen("castle.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
