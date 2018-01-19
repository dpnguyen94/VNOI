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

const int MAXN = 10005;

int n, num[2];
char a[2][MAXN];
string str[2];

void input() {
    scanf("%d\n", &n);
    FOR(i,0,1) {
        FOR(k,1,n) scanf("%c", &a[i][k]);
        scanf("\n");
    }
}

void process() {
    FOR(i,0,1) {
        a[i][0] = a[i][n + 1] = '0';
        num[i] = 0;
        FOR(k,1,n) if (a[i][k] == '1' && a[i][k + 1] == '0') num[i] ++;
    }

    int res = num[0] + num[1];
    FOR(k,1,n) {
        FOR(i,0,1) {
            str[i] = ""; 
            str[i] += a[i][k - 1]; 
            str[i] += a[i][k];
            str[i] += a[i][k + 1];
        }
        
        if ((str[0] == "010" || str[0] == "101") && (str[1] == "010" || str[1] == "101")) {
            res --;
            FOR(i,0,1) a[i][k] = (char)('0' + '1' - str[i][1]);
        }
    }
    
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("lights.inp", "r", stdin);
    //freopen("lights.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
