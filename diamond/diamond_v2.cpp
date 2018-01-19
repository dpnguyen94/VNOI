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

const int LM = 505;

int m, n, h[LM], f1[LM][LM], f2[LM][LM], f3[LM][LM], f4[LM][LM];
char a[LM][LM];

void input() {
    scanf("%d %d\n", &m, &n);
    FOR(i,1,m) {
        FOR(k,1,n) scanf("%c", &a[i][k]);
        scanf("\n");
    }
}

void process() {
    memset(h,0,sizeof(h));
    FOR(i,1,m) {
        FOR(k,1,n) if (a[i][k] != a[i - 1][k]) h[k] = 1;
        else h[k] ++;
        
        FOR(k,1,n) if (a[i][k] != a[i][k - 1]) f1[i][k] = 1;
        else if (h[k] > f1[i][k - 1]) f1[i][k] = f1[i][k - 1] + 1;
        else f1[i][k] = min(h[k],f1[i][k - 1]);
        
        DOW(k,n,1) if (a[i][k] != a[i][k + 1]) f2[i][k] = 1;
        else if (h[k] > f2[i][k + 1]) f2[i][k] = f2[i][k + 1] + 1;
        else f2[i][k] = min(h[k],f2[i][k + 1]);
    }

    memset(h,0,sizeof(h));        
    DOW(i,m,1) {
        FOR(k,1,n) if (a[i][k] != a[i + 1][k]) h[k] = 1;
        else h[k] ++;
        
        FOR(k,1,n) if (a[i][k] != a[i][k - 1]) f3[i][k] = 1;
        else if (h[k] > f3[i][k - 1]) f3[i][k] = f3[i][k - 1] + 1;
        else f3[i][k] = min(h[k],f3[i][k - 1]);
        
        DOW(k,n,1) if (a[i][k] != a[i][k + 1]) f4[i][k] = 1;
        else if (h[k] > f4[i][k + 1]) f4[i][k] = f4[i][k + 1] + 1;
        else f4[i][k] = min(h[k],f4[i][k + 1]);
    }
}

void output() {
    int r, c, res = -1,fmin;
    FOR(i,1,m) 
        FOR(k,1,n) {
            fmin = min(min(f1[i][k],f2[i][k]),min(f3[i][k],f4[i][k])) - 1;
            if (fmin > res) {
                res = fmin;
                r = i;
                c = k;
            }
        }
    
    printf("%d %d %d\n", r, c, res);
}

int main() {
    //freopen("diamond.inp", "r", stdin);
    //freopen("diamond.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
