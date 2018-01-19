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

const int MAXN = 55;
const LL INF = 1000000000000000000LL;

int nTest, n, m;
LL f[MAXN];

void input() {
    scanf("%d %d", &n, &m);
}

void process() {
    memset(f,0,sizeof(f));
    int a, b, num;
    LL t, res = 0;
    REP(i,0,m) {
        scanf("%d %d", &a, &b);
        
        t = INF;
        REP(k,0,n) if (f[k] < a) {
            t = INF;
            num = k;
            break;
        } else if (f[k] < t) {
            t = f[k];
            num = k;
        }
        
        if (t == INF) {
            res += b;
            f[num] = a + b + 4;
        }
        else {
            res += t - a + 1 + b;
            f[num] = t + b + 5;
        }
    }
    
    printf("%lld\n", res + 5 * m);
}

void output() {
}

int main() {
    //freopen("eq.inp", "r", stdin);
    //freopen("eq.out", "w", stdout);

    scanf("%d", &nTest);
    REP(i,0,nTest) {
        input();
        process();
        output();
    }

    return 0;
}
