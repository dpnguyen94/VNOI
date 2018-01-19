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

#define REP(i,a,b)     	for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b)     	for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b)     	for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c,it)     	for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb         		push_back
#define mp         		make_pair
#define sz(c)       	int((c).size())
#define all(c)       	(c).begin(), (c).end()

typedef long long     		LL;
typedef unsigned long long  ULL;
typedef pair<int, int>   	ii;
typedef pair<ii, int>   	iii;
typedef vector<int>   		vi;
typedef vector<vi>     		vvi;
typedef vector<string>   	vs;
typedef vector<ii>       	vii;
typedef vector<vii>   		vvii;

const int MAXN = 2005;

int m, n, a[MAXN][MAXN], h[MAXN], le[MAXN], ri[MAXN];
LL s[MAXN][MAXN];

void input() {
    scanf("%d %d", &m , &n);
    FOR(i,1,n) 
        FOR(k,1,n) {
            scanf("%d", &a[i][k]);
            if (m <= a[i][k] && a[i][k] <= 2 * m) {
                printf("%d %d %d %d\n", k, i, k, i);
                exit(0);
            }
            s[i][k] = s[i - 1][k] + s[i][k - 1] - s[i - 1][k - 1] + a[i][k];                        
        }
}

LL getsum(int u, int v, int x, int y) {
    return (s[x][y] - s[u - 1][y] - s[x][v - 1] + s[u - 1][v - 1]);
}

void check(int u, int v, int x, int y) {
    LL sum = getsum(u,v,x,y);
    if (sum < m) return;
    if (m <= sum && sum <= 2 * m) {
        printf("%d %d %d %d\n", v, u, y, x);
        exit(0);
    }

    FOR(i,u,x) {
        sum = getsum(i,v,i,y);
        if (m <= sum && sum <= 2 * m) {
            printf("%d %d %d %d\n", v, i, y, i);
            exit(0);
        }
    }

    FOR(i,u,x) if (getsum(i,v,i,y) > 2 * m) {
        sum = 0;
        FOR(k,v,y) {
            sum += a[i][k];
            if (m <= sum && sum <= 2 * m) {
                printf("%d %d %d %d\n", v, i, k, i);
                exit(0);
            }
        }
    }

    sum = 0;
    FOR(i,u,x) {
        sum += getsum(i,v,i,y);
        if (m <= sum && sum <= 2 * m) {
            printf("%d %d %d %d\n", v, u, y, i);
            exit(0);
        }
    }
}

void process() {
    h[0] = h[n + 1] = INT_MIN;
    FOR(i,1,n) {
        FOR(k,1,n) if (a[i][k] > 2 * m) h[k] = 0;
        else h[k] ++;
        
        int t;
        FOR(k,1,n) {
            t = le[k] = k - 1;
            while (h[t] >= h[k]) t = le[t];
            le[k] = t;
        }
        
        DOW(k,n,1) {
            t = ri[k] = k + 1;
            while (h[t] >= h[k]) t = ri[t];
            ri[k] = t;
        }
        
        int u, v, x, y;
        FOR(k,1,n) if (h[k] != 0 && (i == n || a[i + 1][k] > 2 * m)) {
            u = i - h[k] + 1;
            v = le[k] + 1;
            x = i;
            y = ri[k] - 1;
            
            check(u,v,x,y);
        }
    }
    
    printf("NIE\n");
}

void output() {
}

int main() {
	//freopen("landk.inp", "r", stdin);
    //freopen("landk.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
