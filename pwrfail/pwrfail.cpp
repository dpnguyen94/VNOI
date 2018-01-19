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

const int MAXN = 1005;
const double LM = 1000000000.0;

int n, w;
bool a[MAXN][MAXN], visit[MAXN];
double m, d[MAXN];
vii p;

void input() {
    scanf("%d %d\n", &n, &w);
    cin >> m;
        
    int x, y;
    REP(i,0,n) {
        scanf("%d %d\n", &x, &y);
        p.pb(mp(x,y));        
    }
    REP(i,0,w) {
        scanf("%d %d\n", &x, &y);
        x --; y --;
        a[x][y] = a[y][x] = 1;
    }
}

double dist(int i, int k) {
    LL x1 = p[i].first, y1 = p[i].second, x2 = p[k].first, y2 = p[k].second;
    return sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
}

void process() {
    d[0] = 0;
    REP(i,1,n) d[i] = LM;
    
    double dmin, t;
    int imin;
    while (true) {
        dmin = LM;
        imin = -1;
        
        REP(i,0,n) if (!visit[i] && d[i] < dmin) {
            dmin = d[i];
            imin = i;
        }
        
        if (imin == -1) break;
        if (imin == n - 1) {
            printf("%d\n", (int)(d[n - 1] * 1000));            
            return;
        }
        
        visit[imin] = 1;
        REP(i,0,n) {
            if (a[imin][i]) t = 0;
            else t = dist(imin,i);
            
            if (t > m) continue;
            if (!visit[i] && d[i] > d[imin] + t) d[i] = d[imin] + t;
        }
    }
    printf("-1\n");
}

void output() {
}

int main() {
    //freopen("pwrfail.inp", "r", stdin);
    //freopen("pwrfail.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
