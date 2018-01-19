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
typedef double          DB;
typedef unsigned long long 	ULL;
typedef pair<int, int> 	ii;
typedef pair<ii, int> 	iii;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef vector<ii> 	    vii;
typedef vector<vii> 	vvii;

const int MAXN = 1505;
const int INF = 1000000000;

struct point {
    int x, y, num;
    double a;
};

int n, x[MAXN], y[MAXN], c[2];
vector<point> p;

bool operator < (point p1, point p2) {
    return (p1.x < p2.x || (p1.x == p2.x && p1.y < p2.y)
            || (p1.x == p2.x && p1.y == p2.y && p1.a < p2.a));
}

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d %d", &x[i], &y[i]);    

    point pp;
    REP(i,0,n - 1) 
        REP(k,i + 1,n) {
            pp.x = x[i] + x[k], pp.y = y[i] + y[k];
            
            if (y[k] == y[i]) pp.a = INF * 1.0;
            else pp.a = (DB)(x[k] - x[i]) / (y[k] - y[i]);
            pp.num = 0;
            p.pb(pp);
            
            if (x[k] == x[i]) pp.a = INF * 1.0;
            else pp.a = (DB)(y[i] - y[k]) / (x[k] - x[i]);
            pp.num = 1;
            p.pb(pp);
        }
        
    sort(all(p));
}

void process() {
    point pp;
    pp.x = pp.y = INF, pp.a = 0.0, pp.num = 0;
    p.pb(pp);
    
    LL res = 0;
    c[0] = c[1] = 0;
    c[p[0].num] ++;
    REP(i,1,sz(p))
        if (p[i].x == p[i - 1].x && p[i].y == p[i - 1].y && p[i].a == p[i - 1].a) c[p[i].num] ++;
        else {
            res += (LL)c[0] * c[1];
            c[0] = c[1] = 0;
            c[p[i].num] ++;
        }
    
    printf("%lld\n", res / 2);
}

void output() {
}

int main() {
    //freopen("hinhthoi.inp", "r", stdin);
    //freopen("hinhthoi.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
