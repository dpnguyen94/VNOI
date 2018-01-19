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

struct bottle {
    int b[4];
};

int nTest, n;
int a[4], c[4], d[50][50][50][50];

void input() {
    scanf("%d", &n);
    memset(a,0,sizeof(a));
    memset(c,0,sizeof(c));
    REP(i,0,n) scanf("%d", &a[i]);
    REP(i,0,n) scanf("%d", &c[i]);
}

void process() {
    memset(d,0,sizeof(d));
    queue<bottle> q;
    
    bottle now, next;
    REP(i,0,4) now.b[i] = a[i];
    d[now.b[0]][now.b[1]][now.b[2]][now.b[3]] = 1;
    q.push(now);
    int t;
    while (!q.empty()) {
        now = q.front();
        q.pop();   
        
        if (now.b[0] == c[0] && now.b[1] == c[1] && now.b[2] == c[2] && now.b[3] == c[3]) {
            printf("%d\n", d[c[0]][c[1]][c[2]][c[3]] - 1);
            return;
        }

        REP(i,0,n) {
            next = now;
            next.b[i] = 0;
                 
            if (!d[next.b[0]][next.b[1]][next.b[2]][next.b[3]]) {
                d[next.b[0]][next.b[1]][next.b[2]][next.b[3]] = d[now.b[0]][now.b[1]][now.b[2]][now.b[3]] + 1;
                q.push(next);
            }                        
        }
        
        REP(i,0,n)
            REP(k,0,n) if (k != i) {
                next = now;
                t = a[k] - now.b[k];
                if (t >= now.b[i]) {
                    next.b[k] += next.b[i];
                    next.b[i] = 0;
                }
                else {
                    next.b[k] = a[k];
                    next.b[i] -= t;
                }
                
                if (!d[next.b[0]][next.b[1]][next.b[2]][next.b[3]]) {
                    d[next.b[0]][next.b[1]][next.b[2]][next.b[3]] = d[now.b[0]][now.b[1]][now.b[2]][now.b[3]] + 1;
                    q.push(next);
                }
            }
    }
    
    printf("NO\n");    
}

void output() {
}

int main() {
    //freopen("ctain.inp", "r", stdin);
    //freopen("ctain.out", "w", stdout);
    
    scanf("%d", &nTest);
    REP(i,0,nTest) {
        input();
        process();
        output();
    }

    return 0;
}
