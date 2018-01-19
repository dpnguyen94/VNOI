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

int n;
bool a[MAXN][MAXN], f[MAXN][MAXN];
vi res;

void input() {
    scanf("%d\n", &n);
    REP(i,0,n)
        REP(k,0,n) scanf("%d", &a[i][k]);
}

void process() {
    int j, k, k2, i2;
    REP(i,0,n) f[i][(i + 1) % n] = 1;
    FOR(t,2,n)
        REP(i,0,n) {
            j = i + t;
            FOR(k,i + 1,j - 1) {
                k2 = k % n;
                i2 = j % n;
                if (f[i][k2] && f[k2][i2] && (a[i][k2] || a[i2][k2])) {
                    f[i][i2] = 1;
                    break;
                }
            }
        }
    
    REP(i,0,n) if (f[i][i]) res.pb(i);
    printf("%d\n", sz(res));
    REP(i,0,sz(res)) printf("%d\n", res[i] + 1);
}

void output() {
}

int main() {
    //freopen("lsfight.inp", "r", stdin);
    //freopen("lsfight.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
