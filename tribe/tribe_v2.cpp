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
const int LM = 55;

int n, x, y, z, a[MAXN], b[MAXN], val[MAXN], f[LM][LM][LM];
string s[MAXN];

void input() {
    scanf("%d %d %d %d", &n, &x, &y, &z);
    REP(i,0,n) {
        cin >> s[i];
        scanf("%d", &val[i]);
    }
    
    REP(i,0,n - 1)
        REP(k,i + 1,n) if (s[i] > s[k]) {
            swap(s[i],s[k]);
            swap(val[i],val[k]);
        }
    
    REP(i,0,n) 
        REP(k,0,sz(s[i])) if (s[i][k] == 'a') a[i] ++;
        else b[i] ++;
}

void process() {
    memset(f,0,sizeof(f));
    FOR(i,0,x)
        FOR(k,0,y)
            FOR(t,0,z)
                REP(j,0,n) if (i >= a[j] && k >= b[j]) {
                    f[i][k][t] = max(f[i][k][t],val[j]);
                    if (t > 0) f[i][k][t] = max(f[i][k][t], f[i - a[j]][k - b[j]][t - 1] + val[j]);
                }
}

void output() {
    if (f[x][y][z] == 0) return;
    while (true) {
        REP(i,0,n) if (a[i] <= x && b[i] <= y) {
            if (f[x][y][z] == val[i]) {
                cout << s[i];
                return;
            }
            
            if (z > 0 && f[x][y][z] == f[x - a[i]][y - b[i]][z - 1] + val[i]) {
                cout << s[i] << " ";
                x -= a[i];
                y -= b[i];
                z --;
                break;
            }
        }
    }
}

int main() {
    //freopen("tribe.inp", "r", stdin);
    //freopen("tribe.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
