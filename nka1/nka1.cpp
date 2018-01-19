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

const int LM  = 100005;

int m, n, a[LM], res[LM];

void input() {
    scanf("%d %d", &m ,&n);
    REP(i,0,n) {
        scanf("%d", &a[i]);
        a[i] --;
    }
}

void process() {
    int cnt = 1, best = INT_MAX;
    REP(i,1,n) if (a[i] - a[i - 1] < m) {
        res[(a[i - 1] + 1) % m] ++;   
        res[(a[i] + 1) % m] --;
        if (a[i - 1] / m != a[i] / m) cnt ++;
    } else cnt ++;
    
    res[0] = cnt;
    REP(i,1,m) res[i] += res[i - 1];
    REP(i,0,m) if (res[i] < best) best = res[i];
    
    printf("%d\n", best);
    REP(i,0,m) if (res[i] == best) printf("%d ", i + 1);
}

void output() {
}

int main() {
    //freopen("nka1.inp", "r", stdin);
    //freopen("nka1.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
