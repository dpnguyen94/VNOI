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

const int MAXN = 100005;

int n, f[2][16][16], val[16][4];
char a[MAXN];

void input() {
    scanf("%d", &n);
    scanf("%s", a);
    
    int k1, k2;
    REP(i,0,16) {
        k1 = i / 4;
        k2 = i % 4;
        
        if (k1 == 0 || k2 == 0) {
            if (k1 == 0 && k2 == 0) REP(k,1,4) val[i][k] = 1;
            else if (k1 == 0) {
                REP(k,1,4) if (k == k2) val[i][k] = 1;
                else val[i][k] = 2;
            } 
            else {
                REP(k,1,4) if (k == k1) val[i][k] = 1;
                else val[i][k] = 2;
            }
            continue;
        }
        
        if (k1 == k2) {
            REP(k,1,4) if (k == k1) val[i][k] = 1;
            else val[i][k] = 2;
        }
        else {
            REP(k,1,4) if (k == k1 || k == k2) val[i][k] = 2;
            else val[i][k] = 3;
        }
    }
}

void process() {
    memset(f,-1,sizeof(f));
    f[0][0][0] = 0;
    int now, next, k1, t1, j;
    REP(i,0,n) {
        now = i % 2;
        next = 1 - now;
        memset(f[next],-1,sizeof(f[next]));
        
        if (a[i] == 'M') j = 1;
        if (a[i] == 'F') j = 2;
        if (a[i] == 'B') j = 3;
        
        REP(k,0,16)
            REP(t,0,16) if (f[now][k][t] != -1) {
                k1 = (k % 4) * 4 + j;       
                f[next][k1][t] = max(f[next][k1][t],f[now][k][t] + val[k][j]);
                t1 = (t % 4) * 4 + j;
                f[next][k][t1] = max(f[next][k][t1],f[now][k][t] + val[t][j]);
            }
    }
    
    int res = 0;
    REP(i,0,16) 
        REP(k,0,16) res = max(res,f[next][i][k]);
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("nkminers.inp", "r", stdin);
    //freopen("nkminers.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
