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

const int MAXR = 2005;
const int MAXC = 205;

int r, c;
int a[MAXR][MAXC], s[MAXR][MAXC], d[MAXR][2][MAXR][2];
int offx[] = {1,-1};
set< pair<int,ii> > q;

void input() {
    scanf("%d %d", &r, &c);
    FOR(i,1,r)
        FOR(k,1,c) {
            scanf("%d", &a[i][k]);
            s[i][k] = s[i][k - 1] + a[i][k];
        }
}

void init() {
    FOR(i,1,r)
        FOR(k,0,1) {
            FOR(t,1,r)
                FOR(z,0,1) d[i][k][t][z] = INT_MAX;

            q.clear();
            
            if (k == 0) d[i][k][i][k] = a[i][1];
            else d[i][k][i][k] = a[i][c];
            q.insert(mp(d[i][k][i][k],mp(i,k)));
            
            ii p;            
            int x, y, u, val;
            while(!q.empty()) {
                p = q.begin()->second;
                q.erase(q.begin());
                x = p.first;
                y = p.second;
                
                REP(j,0,2) {
                    u = x + offx[j];
                    if (u < 1 || u > r) continue;
                    
                    if (y == 0) val = a[u][1];
                    else val = a[u][c];
                    
                    if (d[i][k][u][y] > d[i][k][x][y] + val) {
                        if (d[i][k][u][y] < INT_MAX) q.erase(q.find(mp(d[i][k][u][y],mp(u,y))));
                        q.insert(mp(d[i][k][u][y] = d[i][k][x][y] + val,mp(u,y)));
                    }
                }
                                    
                if (y == 0) {
                    val = s[x][c] - a[x][1];
                    if (d[i][k][x][1] > d[i][k][x][0] + val) {
                        if (d[i][k][x][1] < INT_MAX) q.erase(q.find(mp(d[i][k][x][1],mp(x,1))));
                        q.insert(mp(d[i][k][x][1] = d[i][k][x][0] + val,mp(x,1)));
                    }
                }
                else {
                    val = s[x][c] - a[x][c];
                    if (d[i][k][x][0] > d[i][k][x][1] + val) {
                        if (d[i][k][x][0] < INT_MAX) q.erase(q.find(mp(d[i][k][x][0],mp(x,0))));
                        q.insert(mp(d[i][k][x][0] = d[i][k][x][1] + val,mp(x,0)));
                    } 
                }
            }
        }
}

void process() {
    int m;
    scanf("%d", &m);
    int x = 1, y = 1, u, v, t1, t2, sum = 0;
    LL res = 0;
    FOR(i,1,m) {
        scanf("%d %d", &u, &v);    
        if (i < m) sum += a[u][v];
        
        if (x == u) {
            if (y <= v) res += min(s[x][y] - a[x][1] + d[x][0][x][1] + s[x][c - 1] - s[x][v - 1],
                                    s[x][v] - s[x][y - 1]);
            else res += min(s[x][c - 1] - s[x][y - 1] + d[x][1][x][0] + s[x][v] - a[x][1],
                                s[x][y] - s[x][v - 1]);
        }
        else {
            t1 = min(d[x][0][u][0] + s[x][y] - a[x][1],d[x][1][u][0] + s[x][c - 1] - s[x][y - 1]) + s[u][v] - a[u][1];
            t2 = min(d[x][0][u][1] + s[x][y] - a[x][1],d[x][1][u][1] + s[x][c - 1] - s[x][y - 1]) + s[u][c - 1] - s[u][v - 1];

            res += min(t1,t2);
        }
        
        x = u, y = v;
    }
    
    printf("%I64d\n", res - sum);
}

void output() {
}

int main() {
    freopen("mdostava.inp", "r", stdin);
    freopen("mdostava.out", "w", stdout);

    input();
    init();
    process();
    output();

    return 0;
}
