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

const int MAXN = 1505;

struct point {
    int x, y;
} p[MAXN];

int n, f[MAXN][MAXN];

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d %d", &p[i].x, &p[i].y);
}

inline LL angle(point p0, point p1, point p2) {
    LL x1 = p1.x - p0.x, y1 = p1.y - p0.y, x2 = p2.x - p0.x, y2 = p2.y - p0.y;    
    return (x1 * y2 - x2 * y1);
}

void process() {
    LL res = 0;
    int k, t;
    REP(i,0,n) {
        f[i][(i + 1) % n] = i;
        f[i][(i + n - 1) % n] = i;
                
        FOR(kk,i + 2,i + n - 2) {
            t = f[i][(kk - 1) % n];
            k = kk % n;
            while (t < kk && abs(angle(p[i],p[k],p[(t + 1) % n])) > abs(angle(p[i],p[k],p[t % n]))) t ++;
            f[i][k] = t;
        }
    }

    LL s;
    REP(i,0,n)
        FOR(kk,i + 2,i + n - 2) {
            k = kk % n;
            s = abs(angle(p[i],p[k],p[f[i][k] % n])) + abs(angle(p[i],p[k],p[f[k][i] % n]));
            
            if (s > res) res = s;
        }
        
    printf("%.1f\n", (DB)res / 2);
}

void output() {
}

int main() {
    //freopen("qbcake.inp", "r", stdin);
    //freopen("qbcake.out", "w", stdout);
    
    input();
    process();
    output();

    return 0;
}
