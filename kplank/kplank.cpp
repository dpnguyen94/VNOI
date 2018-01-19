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

const int MAXN = 1000005;

int n, a[MAXN], le[MAXN], ri[MAXN];

void input() {
    scanf("%d", &n);
    FOR(i,1,n) scanf("%d", &a[i]);
}

void process() {
    int k;
    FOR(i,1,n) {
        k = i - 1;
        while (k >= 1 && a[k] >= a[i]) k = le[k];
        le[i] = k;        
    }
    
    DOW(i,n,1) {
        k = i + 1;
        while (k <= n && a[k] >= a[i]) k = ri[k];
        ri[i] = k;
    }
    
    //FOR(i,1,n) printf("%d %d\n", le[i], ri[i]);

    int res = 0;    
    FOR(i,1,n) {
        k = ri[i] - le[i] - 1;
        if (a[i] > k) continue;
        
        res = max(res,a[i]);
    }
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("kplank.inp", "r", stdin);
    //freopen("kplank.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
