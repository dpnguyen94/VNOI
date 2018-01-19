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

int n, a[MAXN], b[MAXN][MAXN], f[MAXN][MAXN];

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d", &a[i]);
}

int calc(int x, int y) {
    if (f[x][y] != -1) return f[x][y];
    
    if (x == y) return (f[x][y] = a[x] % 2);
    
    int xx = (x + 1) % n, yy = (y + n - 1) % n;
    f[x][y] = max((a[x] % 2) + (b[xx][y] - calc(xx,y)),(a[y] % 2) + (b[x][yy] - calc(x,yy)));
    
    return f[x][y];
}

void process() {
    REP(i,0,n) {
        b[i][i] = a[i] % 2;
        FOR(k,i + 1,i + n - 1) b[i][k % n] = b[i][(k - 1) % n] + (a[k % n] % 2);
    }

    memset(f,-1,sizeof(f));
    int x, y, tmp, res = 0;
    REP(i,0,n) {
        x = (i + 1) % n;
        y = (i + n - 1) % n;
        
        tmp = calc(x,y);
        
        if ((a[i] % 2) + (b[x][y] - tmp) > tmp) res ++;
    }
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("ivana.inp", "r", stdin);
    //freopen("ivana.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
