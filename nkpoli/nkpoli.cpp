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

struct point {
    int x, y;
} p[MAXN];

bool operator < (point a, point b) {
    return (a.y * b.x < b.y * a.x);
}

int n, f[MAXN][MAXN];

void input() {
    scanf("%d", &n);
    p[0].x = 0, p[0].y = 0;
    FOR(i,1,n) scanf("%d %d", &p[i].x, &p[i].y);
    sort(p + 1,p + n + 1);
}

bool check(point a, point b, point c) {
    int x1 = b.x - a.x, y1 = b.y - a.y, x2 = c.x - a.x, y2 = c.y - a.y;
    return (x1 * y2 > x2 * y1);
}

void process() {
    FOR(i,1,n) f[0][i] = 1;
    int k, t;
    FOR(i,1,n)
        FOR(j,i + 1,n + 1) {
           if (j == n + 1) k = 0;
           else k = j;
            FOR(t,0,i - 1) if (check(p[t],p[i],p[k])) f[i][k] = max(f[i][k],f[t][i] + 1);
        }

    int res = 0;
    FOR(i,1,n) res = max(res,f[i][0]);
    
    printf("%d\n", res);    
}

void output() {
}

int main() {
    //freopen("nkpoli.inp", "r", stdin);
    //freopen("nkpoli.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
