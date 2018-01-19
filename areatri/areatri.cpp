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
typedef double          DB;
typedef pair<int, int> 	ii;
typedef pair<ii, int> 	iii;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef vector<ii> 	    vii;
typedef vector<vii> 	vvii;

const int MAXN = 1005;

struct point {
    int x, y;
} p[MAXN], p0;

bool operator < (point p1, point p2) {
    LL x1 = p1.x - p0.x, y1 = p1.y - p0.y, x2 = p2.x - p0.x, y2 = p2.y - p0.y;
    return (x1 * y2 > x2 * y1);
}

int n;
vector<point> pp;

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d %d", &p[i].x, &p[i].y);
}

double dist(point p1, point p2) {
    LL x = p1.x - p2.x, y = p1.y - p2.y;
    return sqrt(x * x + y * y);
}

void process() {
    double res = 0.0, d, h;
    LL a, b, c, sumx, sumy, cnt;
    REP(i,0,n) {
        p0 = p[i];
        pp.clear();
        REP(k,0,n) if (p[k].y > p0.y || (p[k].y == p0.y && p[k].x > p0.x)) pp.pb(p[k]);
        sort(all(pp));

        sumx = sumy = cnt = 0;
        REP(k,0,sz(pp)) {
            d = dist(pp[k],p0);
            
            a = pp[k].y - p0.y, b = p0.x - pp[k].x, c = -(a * p0.x + b * p0.y);
            h = (DB)(a * sumx + b * sumy + cnt * c) / sqrt(a * a + b * b);
            
            res += d * h / 2;
            
            sumx += pp[k].x;
            sumy += pp[k].y;
            cnt ++;
        }
    }
    
    printf("%.1f\n", res);
}

void output() {
}

int main() {
    //freopen("areatri.inp", "r", stdin);
    //freopen("areatri.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
