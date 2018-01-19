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

const int MAXN = 505;
const int INF = MAXN * MAXN;

struct point {
    int x, y;
} a1, a2, b1, b2;

int nTest, n, d[MAXN][MAXN];
int offx[] = {0,0,-1,1}, offy[] = {-1,1,0,0};

void input() {
    scanf("%d", &n);
    scanf("%d %d %d %d", &a1.x, &a2.x, &b1.x, &b2.x);
    scanf("%d %d %d %d", &a1.y, &a2.y, &b1.y, &b2.y);
    
    if (a1.x > a2.x) swap(a1,a2);
    if (b1.x > b2.x) swap(b1,b2);
}

int bfs(point p3, point p4) {
    if (d[p3.x][p3.y] == 0 || d[p4.x][p4.y] == 0) return INF;
    
    queue<point> q;
    d[p3.x][p3.y] = 0;
    q.push(p3);
    
    point p;
    int x, y, u, v;
    while (!q.empty()) {
        x = q.front().x, y = q.front().y;
        q.pop();
        
        REP(t,0,4) {
            u = x + offx[t];
            v = y + offy[t];
            
            if (u < 0 || u >= n || v < 0 || v >= n || d[u][v] != -1) continue;
            
            d[u][v] = d[x][y] + 1;
            p.x = u, p.y = v;
            q.push(p);
        }
    }
    
    if (d[p4.x][p4.y] == -1) return INF;
    else return d[p4.x][p4.y];
}

int calc(point p1, point p2, point p3, point p4) {
    int sum1, sum2;
    if (p1.y < p2.y) {
        memset(d,-1,sizeof(d));                
        FOR(x,p1.x,p2.x) d[x][p1.y] = 0;
        FOR(y,p1.y,p2.y) d[p2.x][y] = 0;
        
        sum1 = (p2.x - p1.x) + (p2.y - p1.y) + bfs(p3,p4);
        
        memset(d,-1,sizeof(d));
        FOR(x,p1.x,p2.x) d[x][p2.y] = 0;
        FOR(y,p1.y,p2.y) d[p1.x][y] = 0;
        sum2 = (p2.x - p1.x) + (p2.y - p1.y) + bfs(p3,p4);
    }
    else {
        memset(d,-1,sizeof(d));
        FOR(x,p1.x,p2.x) d[x][p1.y] = 0;
        FOR(y,p2.y,p1.y) d[p2.x][y] = 0;
        sum1 = (p2.x - p1.x) + (p1.y - p2.y) + bfs(p3,p4);
                
        memset(d,-1,sizeof(d));
        FOR(x,p1.x,p2.x) d[x][p2.y] = 0;
        FOR(y,p2.y,p1.y) d[p1.x][y] = 0;
        sum1 = (p2.x - p1.x) + (p1.y - p2.y) + bfs(p3,p4);
    }
    
    return min(sum1,sum2);
}

void process() {
    if (a1.x == a2.x && a2.x == b1.x && b1.x == b2.x && a1.y == a2.y && a2.y == b1.y && b1.y == b2.y) {
        printf("-1\n");
        return;
    }
    
    int res = min(calc(a1,a2,b1,b2),calc(b1,b2,a1,a2));
    if (res >= INF) {
        if (a1.x == a2.x && a2.x == b1.x && b1.x == b2.x && a1.x != 0 && a1.x != n - 1) 
            res = abs(a1.y - a2.y) + abs(b1.y - b2.y) + 4;
        else if (a1.y == a2.y && a2.y == b1.y && b1.y == b2.y && a1.y != 0 && a1.y != n - 1) 
            res = abs(a1.x - a2.x) + abs(b1.x - b2.x) + 4;
    }
    
    if (res >= INF) printf("-1\n");
    else printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("qbwire.inp", "r", stdin);
    //freopen("qbwire.out", "w", stdout);

    scanf("%d", &nTest);
    REP(i,0,nTest) {
        input();
        process();
        output();
    }

    return 0;
}
