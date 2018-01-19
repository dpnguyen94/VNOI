#include <iostream>
#include <stdio.h>
#include <sstream>
#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <numeric>
#include <map>
#include <set>
#include <math.h>
#include <limits.h>
#include <memory.h>

using namespace std;

#define REPF(i,a,b) 	for (int i=(a);i<(b);i++)
#define REPB(i,a,b) 	for (int i=(a);i>(b);i--)
#define FORU(i,a,b) 	for (int i=(a);i<=(b);i++)
#define FORD(i,a,b) 	for (int i=(a);i>=(b);i--)
#define pb 				push_back
#define mp 				make_pair
#define sz(a) 			int((a).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long ULL;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef pair<int, int> 	pii;
typedef pair<pii, int> 	piii;

const int MAXN = 25;

int n;
int sum = 0, res = INT_MAX;
int a[MAXN];
bool vs[MAXN];

void input() {
    scanf("%d", &n);
    REPF(i,0,n) {
        scanf("%d", &a[i]);
        sum += a[i];
    }
}

void attempt(int cnt, int sum) {
    if (cnt >= res) return;
    if (sum == 0) {
        res = min(res, cnt);
        return;
    }
    
    REPF(i,0,n)
        if (!vs[i]) {
            vs[i] = 1;
            int t = sum - a[i];
            int next = (i + 1) % n, prev = (i + n - 1) % n;            
            bool vsnext = vs[next], vsprev = vs[prev];
            if (!vsnext) t -= a[next];
            if (!vsprev) t -= a[prev];
            vs[next] = vs[prev] = 1;
            attempt(cnt + t, t);
            vs[i] = 0;
            vs[next] = vsnext;
            vs[prev] = vsprev;
        }
}

void process() {
    attempt(0, sum);
    printf("%d\n", res);
}

void output() {
}

int main() {
    //freopen("kspree.inp", "r", stdin);
    //freopen("kspree.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
