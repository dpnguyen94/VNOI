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

int n, K;
int dx[] = {-2,-1,1,2,2,1,-1,-2}, dy[] = {1,2,2,1,-1,-2,-2,-1};

void input() {
    scanf("%d %d\n", &n, &K);
    char c;
    int k, maxX = INT_MIN, maxY = INT_MIN, minX = INT_MAX, minY = INT_MAX, X = 0, Y = 0;
    REP(i,0,K) {
        scanf("%c", &c);
        k = c - '1';
        
        X += dx[k];
        Y += dy[k];
        
        maxX = max(maxX,X);
        maxY = max(maxY,Y);
        minX = min(minX,X);
        minY = min(minY,Y);
    }
    
    int x, y, res = 0;
    FOR(i,1,n) 
        FOR(k,1,n) {
            x = i + X;
            y = k + Y;
            if (x < 1 || x > n || y < 1 || y > n) continue;
            
            x = i + minX;
            if (x < 1 || x > n) continue;
            
            x = i + maxX;
            if (x < 1 || x > n) continue;
            
            y = k + minY;
            if (y < 1 || y > n) continue;
            
            y = k + maxY;
            if (y < 1 || y > n) continue;
            
            res ++;
        }
        
    printf("%d\n", res);
}

void process() {
}

void output() {
}

int main() {
    //freopen("lknight.inp", "r", stdin);
    //freopen("lknight.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
