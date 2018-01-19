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

const int MAXN = 1005;

int n, pos[MAXN], a[MAXN][MAXN], f[MAXN][MAXN];

void input() {
    scanf("%d", &n);
    int x;
    FOR(i,1,n) {
        scanf("%d", &x);
        pos[x] = i;
    }
}

void process() {
    FOR(i,1,n)
        FOR(k,1,n) a[i][k] = a[i - 1][k] + (pos[i] < k);
    
    int k;
    FOR(i,1,n) f[i][i] = pos[i];
    FOR(len,2,n) 
        FOR(i,1,n - len + 1) {
            k = i + len - 1;
            f[i][k] = min(f[i][k - 1] + (pos[k] - (a[k - 1][pos[k]] - a[i - 1][pos[k]])) * len,
                        f[i + 1][k] + (pos[i] - (a[k][pos[i]] - a[i][pos[i]])) * len);
        }
}

void output() {
    printf("%d\n", f[1][n]);
}

int main() {
    //freopen("lsortvn.inp", "r", stdin);
    //freopen("lsortvn.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
