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

const int MAXN = 40005;
const int LM = 205;

int n, m, a[MAXN], b[MAXN], f[MAXN], g[LM];

void input() {
    scanf("%d %d", &n, &m);
    FOR(i,1,n) scanf("%d", &a[i]);
}

void process() {
    memset(b,-1,sizeof(b));
    memset(g,-1,sizeof(g));
    
    int n2 = (int)sqrt(n), k, pos;
    FOR(i,1,n) {
        pos = b[a[i]];
        if (pos == -1) {
            DOW(t,n2 - 1,1) g[t + 1] = g[t];
            g[1] = i;
        } else if (pos != i - 1) {
            for (k = 1; k <= n2; k ++) if (g[k] - 1 == pos) break;
            
            DOW(t,k - 1,1) g[t + 1] = g[t];
            g[1] = i;
        }
        
        f[i] = i;
        FOR(t,1,n2) if (g[t] != -1) f[i] = min(f[i],f[g[t] - 1] + t * t);
        b[a[i]] = i;
    }
    
    printf("%d\n", f[n]);
}

void output() {
}

int main() {
    //freopen("ctncln.inp", "r", stdin);
    //freopen("ctncln.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
