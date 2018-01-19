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

const int MAXN = 515;
const int INF = MAXN * MAXN;

int n, f[MAXN][MAXN][10], s[MAXN][MAXN][2], res[MAXN][MAXN], pre[MAXN][MAXN][10][2];
char a[MAXN][MAXN];
int pow2[] = {1,2,4,8,16,32,64,128,256,512};
int dx[] = {0,0,1,1}, dy[] = {0,1,0,1};

void input() {
    scanf("%d\n", &n);
    FOR(i,1,n) {
        FOR(k,1,n) {
            FOR(t,0,1) s[i][k][t] = s[i][k - 1][t] + s[i - 1][k][t] - s[i - 1][k - 1][t];
            scanf("%c", &a[i][k]);
            s[i][k][a[i][k] - '0'] ++;
        }
        scanf("\n");
    }
}

int diff(int i, int k, int c, int num) {
    int u = i + pow2[c] - 1, v = k + pow2[c] - 1;
    int tmp = pow2[c] * pow2[c];
    tmp -= (s[u][v][num] - s[i - 1][v][num] - s[u][k - 1][num] + s[i - 1][k - 1][num]);
    return tmp;
}

int calc(int i, int k, int c) {
    if (f[i][k][c] != -1) return f[i][k][c];
    if (c == 0) return f[i][k][c] = 0;
    
    int i1, k1, sum1, i2, k2, sum2, i3, k3, sum3, sum, best = INF, len = pow2[c - 1];
    REP(t1,0,4) {
        i1 = i + dx[t1] * len;
        k1 = k + dy[t1] * len;
        sum1 = diff(i1,k1,c - 1,0);
                        
        REP(t2,0,4) if (t2 != t1) {
            i2 = i + dx[t2] * len;
            k2 = k + dy[t2] * len;
            sum2 = diff(i2,k2,c - 1,1);
            
            sum3 = 0;
            REP(t,0,4) if (t != t1 && t != t2) {
                i3 = i + dx[t] * len;
                k3 = k + dy[t] * len;
                sum3 += calc(i3,k3,c - 1);
            }
            
            sum = sum1 + sum2 + sum3;
            if (sum < best) {
                best = sum;
                pre[i][k][c][0] = t1;
                pre[i][k][c][1] = t2;
            }
        }
    }
        
    return f[i][k][c] = best;
}

void paint(int i, int k, int c, int num) {
    int u = i + pow2[c] - 1, v = k + pow2[c] - 1;
    FOR(i1,i,u)
        FOR(k1,k,v) res[i1][k1] = num;
}

void trace(int i, int k, int c) {
    int t1, i1, k1, t2, i2, k2, i3, k3, len = pow2[c - 1];
    if (c == 0) res[i][k] = a[i][k] - '0';
    else {
        t1 = pre[i][k][c][0];
        t2 = pre[i][k][c][1];
        
        i1 = i + dx[t1] * len;
        k1 = k + dy[t1] * len;
        paint(i1,k1,c - 1,0);
                        
        i2 = i + dx[t2] * len;
        k2 = k + dy[t2] * len;
        paint(i2,k2,c - 1,1);
        
        REP(t,0,4) if (t != t1 && t != t2) {
            i3 = i + dx[t] * len;
            k3 = k + dy[t] * len;
            trace(i3,k3,c - 1);
        }
    }
}

void process() {
    memset(f,-1,sizeof(f));
    REP(c,0,10) if (pow2[c] == n) {
        printf("%d\n", calc(1,1,c));
        trace(1,1,c);
        break;
    }
    
    FOR(i,1,n) {
        FOR(k,1,n) printf("%d", res[i][k]);
        printf("\n");
    }
}

void output() {
}

int main() {
    //freopen("slikar.inp", "r", stdin);
    //freopen("slikar.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
