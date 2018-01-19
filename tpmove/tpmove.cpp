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

const int LM = 205;

int m, n, bx, by, sx, sy, ex, ey, f[LM][LM], d[LM][LM][8];
int dx[] = {-1,0,1,0}, dy[] = {0,1,0,-1};
int offx[] = {-1,-1,-1,0,1,1,1,0}, offy[] = {-1,0,1,1,1,0,-1,-1};

void input() {
    scanf("%d %d %d %d %d %d %d %d", &m, &n, &bx, &by, &sx, &sy, &ex, &ey);
    
    queue<ii> q;
    f[bx][by] = 1;    
    q.push(mp(bx,by));
    int x, y, u, v;
    while (!q.empty()) {
        x = q.front().first, y = q.front().second;
        q.pop();
        
        REP(i,0,4) {
            u = x + dx[i], v = y + dy[i];
            
            if (u < 1 || u > m || v < 1 || v > n || f[u][v] != 0) continue;
            f[u][v] = f[x][y] + 1;
            q.push(mp(u,v));
        }        
    }
}

int calc(int r, int c, int pos) {
    memset(d,0,sizeof(d));
    queue<iii> q;
    d[r][c][pos] = 1;
    q.push(mp(mp(r,c),pos));
    
    int x, y, pos1, u, v, pos2;
    while (!q.empty()) {
        x = q.front().first.first, y = q.front().first.second, pos1 = q.front().second;
        q.pop();
        
        u = x + offx[pos1], v = y + offy[pos1];
        if (u < 1 || u > m || v < 1 || v > n) continue;
        
        if (x == ex && y == ey) return d[x][y][pos1] - 1;
        
        pos2 = (pos1 + 1) % 8;
        if (d[x][y][pos2] == 0) {
            d[x][y][pos2] = d[x][y][pos1] + 1;
            q.push(mp(mp(x,y),pos2));
        }
        pos2 = (pos1 + 7) % 8;
        if (d[x][y][pos2] == 0) {
            d[x][y][pos2] = d[x][y][pos1] + 1;
            q.push(mp(mp(x,y),pos2));
        }
                
        if (pos1 == 1) {
            u = x + dx[0], v = y + dy[0];
            if (d[u][v][5] == 0) {
                d[u][v][5] = d[x][y][1] + 1;
                q.push(mp(mp(u,v),5));
            }
        }
        
        if (pos1 == 3) {
            u = x + dx[1], v = y + dy[1];
            if (d[u][v][7] == 0) {
                d[u][v][7] = d[x][y][3] + 1;
                q.push(mp(mp(u,v),7));
            }
        }
        
        if (pos1 == 5) {
            u = x + dx[2], v = y + dy[2];
            if (d[u][v][1] == 0) {
                d[u][v][1] = d[x][y][5] + 1;
                q.push(mp(mp(u,v),1));
            }
        }
        
        if (pos1 == 7) {
            u = x + dx[3], v = y + dy[3];
            if (d[u][v][3] == 0) {
                d[u][v][3] = d[x][y][7] + 1;
                q.push(mp(mp(u,v),3));
            }
        }
    }
}

void process() {
    int x, y, tmp, res = INT_MAX;
    REP(i,0,4) {
        x = sx + dx[i], y = sy + dy[i];
        if (x < 1 || x > m || y < 1 || y > n) continue;
        
        tmp = calc(sx,sy,i * 2 + 1);
        res = min(res, f[x][y] - 1 + tmp);
    }
    
    if (sx == ex && sy == ey) printf("0\n");
    else printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("tpmove.inp", "r", stdin);
    //freopen("tpmove.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
