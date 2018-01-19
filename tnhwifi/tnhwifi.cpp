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

const int MAXK = 1005;
const int MAXM = 30005;

struct wifi {
    int x, y, R, B;
} a[MAXK];

int m, n, K, b[MAXM];

void input() {
    scanf("%d %d %d", &m, &n, &K);
    REP(i,0,K) scanf("%d %d %d %d", &a[i].x, &a[i].y, &a[i].R, &a[i].B);
}

void process() {
    int res = 0, cnt, d, t, lo, hi;
    FOR(i,1,n) {
        memset(b,0,sizeof(b));
        REP(k,0,K) {
            d = abs(a[k].x - i);
            t = a[k].R * a[k].R - d * d;
            
            if (t < 0) continue;
            
            lo = max(1,a[k].y - (int)sqrt(t));
            hi = min(m,a[k].y + (int)sqrt(t));
            b[lo] += a[k].B;
            b[hi + 1] -= a[k].B;
        }
        
        FOR(k,1,m) {
            b[k] += b[k - 1];
            if (b[k] > res) {
                res = b[k];
                cnt = 1;
            } else if (b[k] == res) cnt ++;
        }
    }

    printf("%d\n", res);
    printf("%d\n", cnt);    
}

void output() {
}

int main() {
    //freopen("tnhwifi.inp", "r", stdin);
    //freopen("tnhwifi.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
