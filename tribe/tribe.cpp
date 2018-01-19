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

int n, x, y, z, a[MAXN], b[MAXN], val[MAXN], f[LM][LM][LM], pre[LM][LM][LM];
string s[MAXN];

void input() {
    scanf("%d %d %d %d", &n, &x, &y, &z);
    z ++;
    
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
    int xx, yy, zz, tmp;
    memset(f,-1,sizeof(f));
    memset(pre,-1,sizeof(pre));
    f[0][0][0] = 0;
    FOR(i,0,x)
        FOR(k,0,y)
            FOR(t,1,z) if (f[i][k][t] == -1) {
                xx = max(0,i - 1);
                yy = max(0,k - 1);
                zz = max(0,t - 1);
                
                f[i][k][t] = f[xx][yy][zz];
                pre[i][k][t] = pre[xx][yy][zz];
                
                REP(j,0,n) {
                    xx = i - a[j];
                    yy = k - b[j];
                    zz = t - 1;
                    
                    if (xx < 0 || yy < 0) continue;
                    
                    tmp = f[xx][yy][zz] + val[j];
                    if (f[i][k][t] < tmp) {
                        f[i][k][t] = tmp;
                        pre[i][k][t] = j;
                    }
                }
            }
}

void output() {
    string str = "";
    int i;
    while (true) {
        if (z == 0) break;
        if (pre[x][y][z] == -1) {
                x = max(0,x - 1);
                y = max(0,y - 1);
                z = max(0,z - 1);
                continue;
        }
        
        i = pre[x][y][z];
        str += s[i] + " ";
        x -= a[i];
        y -= b[i];
        z --;
    }
    
    str.erase(str.end() - 1);
    cout << str;
}

int main() {
    //freopen("tribe.inp", "r", stdin);
    //freopen("tribe.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
