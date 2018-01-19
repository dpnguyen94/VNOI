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

string s;
int r;
vi y;

void input() {
    scanf("%d\n\n", &r);
}

int calc(int x, int y) {
    int cnt = 0;
    while (x > 0 && y > 0)
        if (x > y) {
            cnt += x / y;
            x %= y;
        }
        else {
            cnt += y / x;
            y %= x;
        }
        
    if (x + y != 1) return INT_MAX;
    
    return cnt - 1;
}

string str(int x, int y) {
    string s = "";

    while (x > 0 && y > 0) 
        if (x > y) {
            FOR(i,1,x / y) s += 'X';
            x %= y;
        }
        else {
            FOR(i,1,y / x) s += 'Y';     
            y %= x;
        }
        
    if (x + y != 1) return "Z";
    
    s.resize(sz(s) - 1);
    reverse(all(s));
    return s;
}

void process() {
    y.clear();
    int best = INT_MAX, t;
    REP(i,1,r) {
        t = calc(r,i);
        if (t < best) {
            y.clear();
            best = t;
        }
        if (t == best) y.pb(i);
    }
    
    string res = "Z", s;
    REP(i,0,sz(y)) {
        s = str(r,y[i]);
        if (s < res) res = s;
    }
    
    if (r == 1) res = "";
    cout << res << "\n";
}

void output() {
}

int main() {
    //freopen("tworeg.inp", "r", stdin);
    //freopen("tworeg.out", "w", stdout);

    while (true) {
        cin >> s;
        if (s == "[END]") break;
        
        input();
        process();
        output();
    }

    return 0;
}
