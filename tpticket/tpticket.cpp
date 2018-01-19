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

const int MAXN = 100005;

int n, K, m, IT[4 * MAXN], c[4 * MAXN];

void input() {
    scanf("%d %d %d", &n, &K, &m);
}

void update(int nd, int x, int y, int u, int v) {
    if (x == u && y == v) {
        c[nd] ++;
        return;
    }
    
    int mid = (x + y) / 2;
    if (u <= mid) update(2 * nd,x,mid,u,min(v,mid));
    if (v >= mid + 1) update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
    
    IT[nd] = max(IT[2 * nd] + c[2 * nd],IT[2 * nd + 1] + c[2 * nd + 1]);
}

int getmax(int nd, int x, int y, int u, int v) {
    if (x == u && y == v) return (IT[nd] + c[nd]);
    
    int max1 = INT_MIN, max2 = INT_MIN;
    int mid = (x + y) / 2;
    if (u <= mid) max1 = getmax(2 * nd,x,mid,u,min(v,mid));
    if (v >= mid + 1) max2 = getmax(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
    
    return (max(max1,max2) + c[nd]);
}

void process() {
    int X, Y, num;
    REP(i,0,m) {
        scanf("%d %d", &X, &Y);
        X ++; Y ++;
        
        num = getmax(1,1,n,X,Y - 1);
        if (num < K) {
            printf("1\n");
            update(1,1,n,X,Y - 1);
        } else printf("0\n");
    }
}

void output() {
}

int main() {
    //freopen("tpticket.inp", "r", stdin);
    //freopen("tpticket.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
