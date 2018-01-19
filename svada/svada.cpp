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

const int LM = 105;

int n, m, T, a[LM], b[LM], c[LM], d[LM];

void input() {
    scanf("%d", &T);
    scanf("%d", &n);
    REP(i,0,n) scanf("%d %d", &a[i], &b[i]);
    scanf("%d", &m);
    REP(i,0,m) scanf("%d %d", &c[i], &d[i]);
}

LL pick(int num) {
    LL t = 0;    
    REP(i,0,n) if (a[i] <= num) t += (LL)(num - a[i]) / b[i] + 1;
    
    return t;
}

LL open(int num) {
    LL t = 0;
    REP(i,0,m) if (c[i] <= num) t += (LL)(num - c[i]) / d[i] + 1;
    
    return t;
}

void process() {
    int le = 1, ri = T, mid, res;
    LL p, o;
    while (le <= ri) {
        mid = (le + ri) / 2;
        p = pick(mid);
        o = open(T - mid);
        
        if (p <= o) {
            res = mid;
            le = mid + 1;
        } else ri = mid - 1;
    }
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("svada.inp", "r", stdin);
    //freopen("svada.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
