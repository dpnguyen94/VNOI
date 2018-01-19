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

const int LM = 35;

int m, n, cnt, a[LM][LM], g[26][26], res[26];
bool appear[26], visit[26];
vvi row, col;

void input() {
    scanf("%d %d\n", &m, &n);
    memset(a,-1,sizeof(a));
    row.resize(26);
    col.resize(26);
    char ch;
    REP(i,0,m) {
        REP(k,0,n) {
            scanf("%c", &ch);
            if (ch != '.') {
                a[i][k] = ch - 'A';
                appear[a[i][k]] = 1;
                row[a[i][k]].pb(i);
                col[a[i][k]].pb(k);
            }
        }
        scanf("\n");
    }
}

void attempt(int i) {
    if (i == cnt) {
        REP(k,0,cnt) printf("%c", res[k] + 'A');
        printf("\n");
        
        return;
    }

    bool ok;
    REP(k,0,26) if (appear[k] && !visit[k]) {
        ok = 1;
        REP(t,0,26) if (appear[t] && !visit[t] && g[k][t]) {
            ok = 0;
            break;
        }
        if (!ok) continue;
        
        res[i] = k;
        visit[k] = 1;
        attempt(i + 1);
        visit[k] = 0;
    }
}

void process() {
    int u, v, x, y;
    REP(i,0,26) if (appear[i]) {
        cnt ++;
        u = *min_element(all(row[i]));
        v = *min_element(all(col[i]));
        x = *max_element(all(row[i]));
        y = *max_element(all(col[i]));
        
        FOR(k,u,x) {
            if (a[k][v] != i) g[a[k][v]][i] = 1;
            if (a[k][y] != i) g[a[k][y]][i] = 1;
        }
        FOR(k,v,y) {
            if (a[u][k] != i) g[a[u][k]][i] = 1;
            if (a[x][k] != i) g[a[x][k]][i] = 1;
        }
    }
    
    attempt(0);
}

void output() {
}

int main() {
    //freopen("ntframe.inp", "r", stdin);
    //freopen("ntframe.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
