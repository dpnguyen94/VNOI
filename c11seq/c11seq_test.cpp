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

const int MAXN = 100005;
const int LM = 1000000000;

int n, a[MAXN];
LL l, r, s[MAXN];

void input() {
    n = 100000;
    l = (rand() % LM) - (rand() % LM);
    r = l + (rand() % LM);
    printf("%d %d %d\n", n, l, r);
    FOR(i,1,n) {
        a[i] = (rand() % LM) - (rand() % LM);
        printf("%d ", a[i]);
        
        s[i] = s[i - 1] + a[i];
    }
    
    printf("\n");
}

void process() {
    int sum, res = 0;
    FOR(i,1,n) 
        DOW(k,i - 1,0) {
            sum = s[i] - s[k];            
            if (sum >= l && sum <= r) res ++;
        }
        
    printf("%d\n", res);
}

void output() {
}

int main() {
    freopen("c11seq.in1", "w", stdout);

    input();
    //process();
    output();

    return 0;
}
