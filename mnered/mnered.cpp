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

int n, m, s[MAXN][MAXN];
bool a[MAXN][MAXN];

void input() {
    scanf("%d %d", &n, &m);
    int x, y;
    FOR(i,1,m) {
        scanf("%d %d", &x, &y);        
        a[x][y] = 1;
    }
    
    FOR(i,1,n) 
        FOR(k,1,n) s[i][k] = s[i - 1][k] + s[i][k - 1] - s[i - 1][k - 1] + a[i][k];
}

int gets(int t, int i, int z, int k) {
    return (s[z][k] - s[t - 1][k] - s[z][i - 1] + s[t - 1][i - 1]);
}

void process() {
    int p, z, res = INT_MAX;
    FOR(i,1,n) 
        FOR(k,i,n) if (m % (k - i + 1) == 0) {
            p = m / (k - i + 1);
            FOR(t,1,n - p + 1) {
                z = t + p - 1;
                res = min(res,m - gets(t,i,z,k));
            }
        }
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("mnered.inp", "r", stdin);
    //freopen("mnered.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
