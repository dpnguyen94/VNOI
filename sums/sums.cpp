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
#define FOR(i,a,b) 	    for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 	    for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c, it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef pair<int, int> 	pii;
typedef pair<pii, int> 	piii;

const int MAXN = 5005;
const int LM = 1000000005;

int n, m, base;
int a[MAXN];
int f[50005];
set<pii> q;
//priority_queue< pii, vector<pii>, greater<pii> > q;

void input() {
    scanf("%d", &n);
    REP(i,0,n) scanf("%d", &a[i]);
    base = a[0];
}

void process() {
    q.insert(mp(f[0] = 0,0));
    REP(i,1,base) f[i] = LM;
    int u, v;
    while (!q.empty()) {
        u = q.begin() -> second;
        q.erase(q.begin());
        REP(i,1,n) {
            v = (u + a[i]) % base;
            if (f[v] > f[u] + a[i]) {
                if (f[v] < LM) q.erase(q.find(mp(f[v],v)));
                q.insert(mp(f[v] = f[u] + a[i],v));
            }
        }
    }
}

/*
void process() {
    q.push(mp(f[0] = 0,0));
    REP(i,1,base) f[i] = LM;
    
    pii x;
    int u, v, d;
    while (!q.empty()) {
        x = q.top();
        u = x.second, d = x.first;
        q.pop();

        if (d <= f[u]) {
            REP(i,1,n) {
                v = (u + a[i]) % base;
                if (f[v] > f[u] + a[i]) q.push(mp(f[v] = f[u] + a[i],v));
            }
        }
    }
}
*/

void output() {
    scanf("%d", &m);
    int num;
    REP(i,0,m) {
        scanf("%d", &num);
        if (num >= f[num % base]) printf("TAK\n");
        else printf("NIE\n");
    }
}

int main() {
    //freopen("sums.inp", "r", stdin);
    //freopen("sums.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
