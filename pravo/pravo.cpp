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

const int MAXN = 1505;

struct point {
    int id, a, b;
};

bool operator < (point p1, point p2) {
    return (p1.id < p2.id || (p1.id == p2.id && p1.a < p2.a) || (p1.id == p2.id && p1.a == p2.a && p1.b < p2.b));
}

int n, x[MAXN], y[MAXN];
map<point,int> p;

int gcd(int a, int b) {
    int r;
    while (b > 0) {
        r = a % b;        
        a = b;
        b = r;
    }
    
    return a;
}

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d %d", &x[i], &y[i]);
}

void process() {
    point pp;
    int aa, bb, t;
    REP(i,0,n - 1) 
        REP(k,i + 1,n) {
            pp.id = i;
            aa = x[k] - x[i], bb = y[k] - y[i];
            t = gcd(abs(aa), abs(bb));
            pp.a = aa / t, pp.b = bb / t;
            p[pp] ++;

            pp.id = k;
            pp.a = -pp.a, pp.b = -pp.b;
            p[pp] ++;
        }

    LL res = 0, cnt;
    point po;
    TR(p,it) {
        pp = it->first;
        po.id = pp.id;
        cnt = it -> second;
        
        po.a = pp.b, po.b = -pp.a;
        if (p.find(po) != p.end()) res += cnt * p[po];
        
        po.a = -pp.b, po.b = pp.a;
        if (p.find(po) != p.end()) res += cnt * p[po];
    }
    
    printf("%d\n", res / 2);
}

void output() {
}

int main() {
    freopen("pravokutni.in.10", "r", stdin);
    freopen("pravo.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
