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

const int MAXN = 10005;

struct node {
    int le, ri, mid;
} IT[4 * MAXN];

int n, m, num;

void input() {
    scanf("%d %d", &n, &m);
}

void update(int nd, int x, int y, int u, int v) {
    if (x == u && y == v) {
        if (num == 1) IT[nd].le = IT[nd].ri = IT[nd].mid = y - x + 1;
        else IT[nd].le = IT[nd].ri = IT[nd].mid = 0;
        return;
    }
    
    int mid = (x + y) / 2;
    if (IT[nd].le == IT[nd].ri && IT[nd].ri == IT[nd].mid && (IT[nd].le == y - x + 1 || IT[nd].le == 0)) 
        if (IT[nd].le == y - x + 1) {
            IT[2 * nd].le = IT[2 * nd].ri = IT[2 * nd].mid = mid - x + 1;
            IT[2 * nd + 1].le = IT[2 * nd + 1].ri = IT[2 * nd + 1].mid = y - mid;
        }
        else {
            IT[2 * nd].le = IT[2 * nd].ri = IT[2 * nd].mid = 0;
            IT[2 * nd + 1].le = IT[2 * nd + 1].ri = IT[2 * nd + 1].mid = 0;
        }
    
    if (u <= mid) update(2 * nd,x,mid,u,min(v,mid));
    if (v >= mid + 1) update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
    
    IT[nd].le = IT[2 * nd].le;
    if (IT[nd].le == mid - x + 1) IT[nd].le += IT[2 * nd + 1].le;
    IT[nd].ri = IT[2 * nd + 1].ri;
    if (IT[nd].ri == y - mid) IT[nd].ri += IT[2 * nd].ri;
    IT[nd].mid = max(max(IT[2 * nd].mid,IT[2 * nd + 1].mid),IT[2 * nd].ri + IT[2 * nd + 1].le);
}

void process() {
    num = 1;
    update(1,1,n,1,n);
    int L, R;
    REP(i,0,m) {
        scanf("%d", &num);
        if (num == 1 || num == 2) {
            scanf("%d %d", &L, &R);
            update(1,1,n,L,R);
        }
        else printf("%d\n", max(max(IT[1].le,IT[1].ri),IT[1].mid));
    }    
}

void output() {
}

int main() {
    //freopen("lem4.inp", "r", stdin);
    //freopen("lem4.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
