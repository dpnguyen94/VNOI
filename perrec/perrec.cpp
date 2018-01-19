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

const int MAXN = 2005;
int n, m, x, y, a, b, c, d;

bool f[MAXN][MAXN];
bool mark[MAXN];
int g[MAXN], s[MAXN], fi[MAXN], le[MAXN], ri[MAXN];

void input() {
    scanf("%d %d %d %d %d %d %d %d", &n, &m, &x, &a, &b, &y, &c, &d);
    
    f[x % n + 1][y % n + 1] = 1;
    REP(i,1,m) {
        x = (x * a + b) % n;
        y = (y * c + d) % n;
        f[x + 1][y + 1] = 1;
    }
}

void process() {
    int t, left, right, res = 0;
    FOR(i,1,n) {
        FOR(k,1,n) if (!f[i][k]) g[k] ++;
        else g[k] = 0;
        
        FOR(k,1,n) if (i < n && !f[i + 1][k]) s[k] = s[k - 1] + 1;
        else s[k] = s[k - 1];
        
        FOR(k,1,n) {
            le[k] = k - 1;
            t = k - 1;
            
            while (t >= 1 && g[t] >= g[k]) t = le[t];
            le[k] = t;
        }
        
        DOW(k,n,1) {
            ri[k] = k + 1;
            t = k + 1;
            
            while (t <= n && g[t] >= g[k]) t = ri[t];
            ri[k] = t;
        }
        
        memset(mark,0,sizeof(mark));
        FOR(k,1,n) {
            fi[k] = k - 1;
            t = k - 1;
            
            while (t >= 1 && g[t] > g[k]) t = fi[t];
            fi[k] = t;
            
            if (g[t] == g[k]) mark[k] = 1;
        }
        
        FOR(k,1,n) if (!mark[k]) {
            left = le[k] + 1;
            right = ri[k] - 1;
            if (s[right] - s[left - 1] < right - left + 1) res ++;
        }        
    }    
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("perrec.inp", "r", stdin);
    //freopen("perrec.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
