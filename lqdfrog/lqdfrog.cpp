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

const int LM = 100005;

struct rock_a {
    int x, y;
};

bool operator < (rock_a r1, rock_a r2) {
    return ((r1.x - r1.y < r2.x - r2.y) || (r1.x - r1.y == r2.x - r2.y && r1.x < r2.x));
}

struct rock_b {
    int x, y;
};

bool operator < (rock_b r1, rock_b r2) {
    return ((r1.x + r1.y < r2.x + r2.y) || (r1.x + r1.y == r2.x + r2.y && r1.x < r2.x));
}

int n, K;
char s[LM];

set<rock_a> a;
set<rock_b> b;

void input() {
    scanf("%d %d\n", &n, &K);
    REP(i,0,K) scanf("%c", &s[i]);
}

void process() {
    int xx, yy, X, Y;
    rock_a r_a;
    rock_b r_b;
    REP(i,0,n) {
        scanf("%d %d", &xx, &yy);
        r_a.x = xx, r_a.y = yy;
        a.insert(r_a);
        r_b.x = xx, r_b.y = yy;
        b.insert(r_b);
        
        if (i == 0) X = xx, Y = yy;        
    }

    typeof(a.begin()) it_a;
    typeof(b.begin()) it_b;
    
    bool need = 1;
    REP(i,0,K) {
        if (need) {
            r_a.x = X, r_a.y = Y;
            it_a = a.find(r_a);
            r_b.x = X, r_b.y = Y;
            it_b = b.find(r_b);
        }
        
        need = 1;
        if (s[i] == 'A') {
            it_a ++;
            if (it_a == a.end()) {
                it_a --;
                need = 0;
                continue;
            }
            
            r_a = *it_a;
            if (r_a.x - r_a.y == X - Y) {
                X = r_a.x, Y = r_a.y;
                a.erase(--it_a);
                b.erase(it_b);
            } else {
                it_a --;
                need = 0;
            }
        }
        
        if (s[i] == 'D') {
            if (it_a == a.begin()) {
                need = 0;
                continue;
            }
            
            it_a --;
            r_a = *it_a;
            if (r_a.x - r_a.y == X - Y) {
                X = r_a.x, Y = r_a.y;
                a.erase(++it_a);
                b.erase(it_b);
            } else {
                it_a ++;
                need = 0;
            }
        }
        
        if (s[i] == 'B') {
            it_b ++;
            if (it_b == b.end()) {
                it_b --;
                need = 0;
                continue;
            }
            
            r_b = *it_b;
            if (r_b.x + r_b.y == X + Y) {
                X = r_b.x, Y = r_b.y;
                b.erase(--it_b);
                a.erase(it_a);
            } else {
                it_b --;
                need = 0;
            }
        }
        
        if (s[i] == 'C') {
            if (it_b == b.begin()) {
                need = 0;
                continue;
            }
            
            it_b --;
            r_b = *it_b;
            if (r_b.x + r_b.y == X + Y) {
                X = r_b.x, Y = r_b.y;
                b.erase(++it_b);
                a.erase(it_a);
            } else {
                it_b ++;
                need = 0;
            }
        }
    }
    
    printf("%d %d\n", X, Y);
}

void output() {
}

int main() {
    //freopen("lqdfrog.inp", "r", stdin);
    //freopen("lqdfrog.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
