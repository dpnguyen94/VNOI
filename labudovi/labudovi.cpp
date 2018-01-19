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

const int LM = 1505;

int r, c, a[LM][LM], amax;
int offx[] = {0,0,-1,1}, offy[] = {-1,1,0,0};
bool b[LM][LM];
vii p;

void input() {
    scanf("%d %d\n", &r, &c);
    queue<ii> q;
    char s;
    REP(i,0,r) {
        REP(k,0,c) {
            scanf("%c", &s);
            if (s == 'L') p.pb(mp(i,k));
            
            if (s == '.' || s == 'L') {
                a[i][k] = 1;
                q.push(mp(i,k));
            }
        }
        scanf("\n");
    }
    
    amax = 0;
    int x, y, u, v;
    while (!q.empty()) {
        x = q.front().first, y = q.front().second;
        q.pop();
        
        amax = max(amax,a[x][y]);
        
        REP(t,0,4) {
            u = x + offx[t], v = y + offy[t];
            if (u < 0 || u >= r || v < 0 || v >= c || a[u][v] > 0) continue;
            
            a[u][v] = a[x][y] + 1;
            q.push(mp(u,v));
        }
    }
}

inline bool check(int mid) {
    queue<ii> q;
    memset(b,0,sizeof(b));
    b[p[0].first][p[0].second] = 1;
    q.push(p[0]);
    
    int x, y, u, v;
    while (!q.empty()) {
        x = q.front().first, y = q.front().second;
        q.pop();
        
        REP(t,0,4) {
            u = x + offx[t], v = y + offy[t];
            if (u < 0 || u >= r || v < 0 || v >= c
                || a[u][v] > mid || b[u][v]) continue;
            
            b[u][v] = 1;
            q.push(mp(u,v));
        }
        
        if (b[p[1].first][p[1].second]) return 1;
    }
    
    return 0;
}

void process() {
    int le = 1, ri = amax, mid, res;
    while (le <= ri) {
        mid = (le + ri) / 2;
        if (check(mid)) {
            res = mid;
            ri = mid - 1;
        } else le = mid + 1;
    }
    
    printf("%d\n", res - 1);
}

void output() {
}

int main() {
    //freopen("labudovi.inp", "r", stdin);
    //freopen("labudovi.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
