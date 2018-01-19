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

const int MAXN = 205;
const int MOD = 100000;

int n;
LL f[MAXN][MAXN];
char s[MAXN];

void input() {
    scanf("%d\n", &n);
    FOR(i,1,n) scanf("%c", &s[i]);
}

LL valid(char a, char b) {
    if (a == '?' && b == '?') return 3;
    if ((a == '(' && b == ')') || (a == '[' && b == ']') || (a == '{' && b == '}')) return 1;
    if (a == '?' && (b == ')' || b == ']' || b == '}')) return 1;
    if ((a == '(' || a == '[' || a == '{') && b == '?') return 1;
    return 0;
}

void process() {
    int k;
    FOR(i,1,n - 1) f[i][i + 1] = valid(s[i],s[i + 1]);
    
    bool overflow = 0;
    for(int leng = 4; leng <= n; leng += 2) {
        FOR(i,1,n - leng + 1) {
            k = i + leng - 1;
            
            f[i][k] = f[i + 1][k - 1] * valid(s[i],s[k]);
            if (f[i][k] >= MOD) {
                overflow = 1;
                f[i][k] %= MOD;
            }
            
            f[i][k] = f[i][k] + f[i + 2][k] * valid(s[i],s[i + 1]);
            if (f[i][k] >= MOD) {
                overflow = 1;
                f[i][k] %= MOD;
            }
            
            FOR(t,i + 2,k - 1) f[i][k] = f[i][k] + f[i + 1][t - 1] * f[t + 1][k] * valid(s[i],s[t]);
            if (f[i][k] >= MOD) {
                overflow = 1;
                f[i][k] %= MOD;
            }
        }
    }
    
    if (overflow) printf("%05lld", f[1][n]);
    else printf("%lld", f[1][n]);
}

void output() {
}

int main() {
    //freopen("mreplbrc.inp", "r", stdin);
    //freopen("mreplbrc.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
