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

const int MAXN = 1100000;

int L, U, n, a[MAXN], b[MAXN];
vii v;

void input() {
    scanf("%d %d %d\n", &n, &L, &U);
    int x;
    REP(i,0,n) {
        scanf("%d", &x);
        v.pb(mp(x,i));
    }
    
    sort(all(v));
    int cnt = 0;
    a[v[0].second] = 0;
    REP(i,1,n) if (v[i].first == v[i - 1].first) a[v[i].second] = cnt;
    else a[v[i].second] = ++ cnt;
}

LL calc(int num) {
    memset(b,0,sizeof(b));
    int k = 0, cnt = 0;
    LL res = 0;
    REP(i,0,n) {
        b[a[i]] ++;
        if (b[a[i]] == 1) cnt ++;
        
        while (k <= i && cnt > num) {
            b[a[k]] --;
            if (b[a[k]] == 0) cnt --;
            
            k ++;
        }
        res += (LL)(i - k + 1);
    }
    
    return res;
}

void process() {
    printf("%lld\n", calc(U) - calc(L - 1));
}

void output() {
}

int main() {
    //freopen("sopenp.inp", "r", stdin);
    //freopen("sopenp.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
