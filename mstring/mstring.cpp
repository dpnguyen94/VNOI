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

const int LM = 1005;

char a[LM], b[LM];
int n, m, f[LM][LM], last[LM][26];

void input() {
    scanf("%s\n", a);
    scanf("%s\n", b);
}

void process() {
    n = strlen(a), m = strlen(b);
    
    REP(c,0,26) last[m][c] = -1;
    DOW(i,m - 1,0)
        FOR(c,'a','z') if (b[i] == c) last[i][c - 'a'] = i;
        else last[i][c - 'a'] = last[i + 1][c - 'a'];
    
    REP(i,0,n) f[i][m] = 1;
    FOR(i,0,m) f[n][i] = LM;
    
    int t;
    DOW(i,n - 1,0)
        DOW(k,m - 1,0) {
            f[i][k] = f[i + 1][k];
            
            t = last[k][a[i] - 'a'];
            if (t != -1) f[i][k] = min(f[i][k],f[i + 1][t + 1] + 1);
            else f[i][k] = 1;
        }
}

void output() {
    printf("%d\n", f[0][0]);
}

int main() {
    //freopen("mstring.inp", "r", stdin);
    //freopen("mstring.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
