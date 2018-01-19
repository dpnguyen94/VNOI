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

int n, m;
vii px, py;
vvii x, y;

void input() {
    scanf("%d", &n);
    int xx, yy;
    REP(i,0,n) {
        scanf("%d %d", &xx, &yy);
        px.pb(mp(xx,yy));
        py.pb(mp(yy,xx));
    }
    sort(all(px));
    sort(all(py));
    
    int cnt = 1;
    REP(i,1,n) if (px[i].first > px[i - 1].first) cnt ++;
    x.resize(cnt);
    cnt = 0;
    x[0].pb(px[0]);
    REP(i,1,n) {
        if (px[i].first > px[i - 1].first) cnt ++;
        x[cnt].pb(px[i]);
    }
    
    cnt = 1;
    REP(i,1,n) if (py[i].first > py[i - 1].first) cnt ++;
    y.resize(cnt);
    cnt = 0;
    y[0].pb(py[0]);
    REP(i,1,n) {
        if (py[i].first > py[i - 1].first) cnt ++;
        y[cnt].pb(py[i]);
    }
}

int countx(int xx, int y1, int y2) {
    int le = 0, ri = sz(x) - 1, mid, id = -1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int x1 = x[mid][0].first;
        if (x1 == xx) {
            id = mid;
            break;
        }
        if (x1 < xx) le = mid + 1;
        if (x1 > xx) ri = mid - 1;
    }
    
    if (id == -1) return 0;
    
    int id1 = -1;
    le = 0, ri = sz(x[id]) - 1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int yy = x[id][mid].second;
        if (yy >= y1) {
            id1 = mid;
            ri = mid - 1;
        }
        else le = mid + 1;
    }
    
    int id2 = -1;
    le = 0, ri = sz(x[id]) - 1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int yy = x[id][mid].second;
        if (yy <= y2) {
            id2 = mid;
            le = mid + 1;
        }
        else ri = mid - 1;
    }
    
    if (id1 == -1 || id2 == -1) return 0;
    
    return (id2 - id1 + 1);
}

int county(int yy, int x1, int x2) {
    int le = 0, ri = sz(y) - 1, mid, id = -1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int y1 = y[mid][0].first;
        if (y1 == yy) {
            id = mid;
            break;
        }
        if (y1 < yy) le = mid + 1;
        if (y1 > yy) ri = mid - 1;
    }
    
    if (id == -1) return 0;
    
    int id1 = -1;
    le = 0, ri = sz(y[id]) - 1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int xx = y[id][mid].second;
        if (xx > x1) {
            id1 = mid;
            ri = mid - 1;
        }
        else le = mid + 1;
    }
    
    int id2 = -1;
    le = 0, ri = sz(y[id]) - 1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        int xx = y[id][mid].second;
        if (xx < x2) {
            id2 = mid;
            le = mid + 1;
        }
        else ri = mid - 1;
    }
    
    if (id1 == -1 || id2 == -1) return 0;
    
    return (id2 - id1 + 1);
}

void process() {
    int x1, y1, x2, y2, res;
    scanf("%d", &m);
    REP(i,0,m) {
        res = 0;
        scanf("%d %d %d %d", &x1, &y1, &x2, &y2);
        
        res = countx(x1,y1,y2) + countx(x2,y1,y2)
                + county(y1,x1,x2) + county(y2,x1,x2);
                
        printf("%d\n", res);
    }
}

void output() {
}

int main() {
    //freopen("mrect1.inp", "r", stdin);
    //freopen("mrect1.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
