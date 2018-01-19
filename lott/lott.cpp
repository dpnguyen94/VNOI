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
int n;
LL c[505][6];

int main() {
    //freopen("lott.inp", "r", stdin);
    //freopen("lott.out", "w", stdout);

    FOR(i,0,505) c[i][0] = 1;
    FOR(i,1,505) 
        FOR(k,1,5) c[i][k] = c[i - 1][k] + c[i - 1][k - 1];    
    
    while (true) {
        cin >> s;
        if (s == "[END]") break;
        
        scanf("%d\n\n", &n);                
        printf("%.6f\n", (double)(n * (c[5][3] * c[5 * n - 5][2] + c[5][4] * c[5 * n - 5][1] + c[5][5] * c[5 * n - 5][0])) / c[5 * n][5]);
    }

    return 0;
}
