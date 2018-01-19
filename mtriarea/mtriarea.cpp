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

const int MAXN = 50005;
const int MAXM = 5005;

struct point {
    int x, y;
} p[MAXN];

bool operator < (point p1, point p2) {
    int x1 = p1.x - p[0].x, y1 = p1.y - p[0].y, x2 = p2.x - p[0].x, y2 = p2.y - p[0].y;
    return (x1 * y2 > x2 * y1);
}

int n, m, f[MAXM][MAXM];

void input() {
    REP(i,0,n) scanf("%d %d", &p[i].x, &p[i].y);
    REP(i,1,n) if (p[i].y < p[0].y || (p[i].y == p[0].y && p[i].x < p[0].x)) swap(p[i],p[0]);
    
    sort(p + 1,p + n);
}

int angle(point p0, point p1, point p2) {
    int x1 = p1.x - p0.x, y1 = p1.y - p0.y, x2 = p2.x - p0.x, y2 = p2.y - p0.y;   
    return (x1 * y2 - x2 * y1);
}

void process() {
    m = 1;
    REP(i,2,n) {
        while (angle(p[m - 1],p[m],p[i]) < 0) m --;
        p[++ m] = p[i];
    }
    m ++;
    
    if (m == 3) {
        printf("%.2f\n", (DB)angle(p[0],p[1],p[2]) / 2);
        return;
    }
    
    int t, res = 0;
    REP(i,0,m) {
        f[i][(i + 1) % m] = i;
        f[i][(i + m - 1) % m] = i;
                
        FOR(k,i + 2,i + m - 2) {
            t = f[i][(k - 1) % m];
            while (abs(angle(p[i],p[k % m],p[(t + 1) % m])) > abs(angle(p[i],p[k % m],p[t % m]))) t ++;
            f[i][k % m] = t;
            
            res = max(res, abs(angle(p[i],p[k % m],p[t % m])));
        }
    }
    
    printf("%.2f\n", (DB)res / 2);
}

void output() {
}

int main() {
    freopen("triangle.in", "r", stdin);
    freopen("mtriarea.out", "w", stdout);
    
    while (true) {
        scanf("%d", &n);
        if (n == -1) break;
        
        input();
        process();
        output();
    }

    return 0;
}
