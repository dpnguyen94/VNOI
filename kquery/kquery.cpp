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

const int MAXN = 30005;
const int MAXM = 200005;

int n, m, a[MAXN], b[MAXN], val[MAXN], f[MAXN], len[MAXM];
vvii q;
vvi ans;

inline int search(int num) {
    int le = 0, ri = n - 1, mid, id = -1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        if (a[mid] <= num) {
            id = mid;
            le = mid + 1;
        } else ri = mid - 1;
    }
    
    if (id == -1) return -1;
    return val[id];
}

void input() {
    scanf("%d", &n);
    REP(i,0,n) {
        scanf("%d", &a[i]);
        b[i] = a[i];
    }
    
    sort(a,a + n);
    val[0] = 1;
    REP(i,1,n) if (a[i] == a[i - 1]) val[i] = val[i - 1];
    else val[i] = val[i - 1] + 1;
    
    int x, y, num, value;
    scanf("%d", &m);
    q.resize(n);    
    ans.resize(m);
    REP(i,0,m) {
        scanf("%d %d %d", &x, &y, &num);
        len[i] = y - x + 1;
        value = search(num);
        x -= 2; y --;
        q[y].pb(mp(value,i));
        if (x >= 0) q[x].pb(mp(value,i));
        else ans[i].pb(0);
    }
}

inline void update(int num) {
    if (num == -1) return;
    while (num <= n) {
        f[num] ++;
        num += (num & -num);
    }
}

inline int get(int num) {
    int t = 0;
    while (num > 0) {
        t += f[num];
        num -= (num & -num);
    }
    return t;
}

void process() {
    int num, id;
    REP(i,0,n) {
        num = search(b[i]);
        update(num);
        REP(k,0,sz(q[i])) {
            num = q[i][k].first;
            id = q[i][k].second;
            
            ans[id].pb(get(num));
        }
    }
    
    REP(i,0,m) printf("%d\n", len[i] - (ans[i][1] - ans[i][0]));
}

void output() {
}

int main() {
    //freopen("kquery.inp", "r", stdin);
    //freopen("kquery.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
