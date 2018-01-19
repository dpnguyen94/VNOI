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

const int MAXN = 300005;
const int LM = 100005;

struct point {
    int x, y, a;
};

bool operator < (point p1, point p2) {
    return (p1.x < p2.x || (p1.x == p2.x && p1.y < p2.y));
}

int n, K, start, finish, f[MAXN], fx[LM], fy[LM];
vector<point> p;

void input() {
    scanf("%d %d", &n, &K);
    p.resize(n);
    REP(i,0,n) scanf("%d %d %d",&p[i].x, &p[i].y, &p[i].a);
    int X1 = p[0].x, Y1 = p[0].y, X2 = p[n - 1].x, Y2 = p[n - 1].y;
    
    sort(all(p));
    
    REP(i,0,n) {
        if (p[i].x == X1 && p[i].y == Y1) start = i;
        if (p[i].x == X2 && p[i].y == Y2) finish = i;
    }
}

void process() {
    memset(f,-1,sizeof(f));
    memset(fx,-1,sizeof(fx));
    memset(fy,-1,sizeof(fy));
    f[start] = fx[p[start].x] = fy[p[start].y] = p[start].a;
    int k;
    FOR(i,start + 1,finish) {
        k = p[i].a - K;
        if (fx[p[i].x] >= K) f[i] = max(f[i],fx[p[i].x] + k);
        if (fy[p[i].y] >= K) f[i] = max(f[i],fy[p[i].y] + k);
        
        if (f[i] >= 0) {
            fx[p[i].x] = max(fx[p[i].x],f[i]);
            fy[p[i].y] = max(fy[p[i].y],f[i]);
        }
    }
    
    printf("%d\n", f[finish]);
}

void output() {
}

int main() {
    freopen("baricavn.inp", "r", stdin);
    freopen("baricavn.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
