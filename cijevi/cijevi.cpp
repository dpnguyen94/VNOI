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

const int LM = 30;

int r, c, x[2], y[2];
int offx[] = {0,0,-1,1}, offy[] = {-1,1,0,0};
char s[] = {'|','-','+','1','2','3','4'};
char a[LM][LM];
bool visit[LM][LM];


void input() {
    scanf("%d %d\n", &r, &c);
    FOR(i,1,r) {
        FOR(k,1,c) {
            scanf("%c", &a[i][k]);
            if (a[i][k] == 'M') {
                x[0] = i;
                y[0] = k;
            }
            if (a[i][k] == 'Z') {
                x[1] = i;
                y[1] = k;
            }
        }
        scanf("\n");
    }
    
    FOR(i,0,r + 1) 
        FOR(k,0,c + 1) if (i == 0 || i == r + 1 || k == 0 || k == c + 1) a[i][k] = '.';
}

bool bfs() {
    memset(visit,0,sizeof(visit));
    queue<ii> q;
    visit[x[0]][y[0]] = 1;
    q.push(mp(x[0],y[0]));

    int i, k, u, v;
    while (!q.empty()) {
        i = q.front().first, k = q.front().second;
        q.pop();

        if (a[i][k] == '.') return 0;
                
        if (a[i][k] == 'M') {
            REP(t,0,4) {
                u = i + offx[t], v = k + offy[t];
                if (a[u][v] != '.') {
                    visit[u][v] = 1;
                    q.push(mp(u,v));
                }
            }
        }
                
        if (a[i][k] == '|') {
            u = i - 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i + 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }
        
        if (a[i][k] == '-') {
            u = i, v = k - 1;
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i, v = k + 1;                        
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }

        if (a[i][k] == '+')
            REP(t,0,4) {
                u = i + offx[t], v = k + offy[t];
                if (t == 0 && !(a[u][v] == '-' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
                if (t == 1 && !(a[u][v] == '-' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
                if (t == 2 && !(a[u][v] == '|' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
                if (t == 3 && !(a[u][v] == '|' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
                if (!visit[u][v]) {
                    if (t == 0 && (a[u][v] == '-' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z')) {
                        visit[u][v] = 1;
                        q.push(mp(u,v));
                    }
                    if (t == 1 && (a[u][v] == '-' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z')) {
                        visit[u][v] = 1;
                        q.push(mp(u,v));
                    }
                    if (t == 2 && (a[u][v] == '|' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z')) {
                        visit[u][v] = 1;
                        q.push(mp(u,v));
                    }
                    if (t == 3 && (a[u][v] == '|' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '+' || a[u][v] == '.' || a[u][v] == 'Z')) {
                        visit[u][v] = 1;
                        q.push(mp(u,v));
                    }
                }
            }
        
        if (a[i][k] == '1') {
            u = i + 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i, v = k + 1;
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }

        if (a[i][k] == '2') {
            u = i - 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i, v = k + 1;            
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '3' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }

        if (a[i][k] == '3') {
            u = i - 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '4' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i, v = k - 1;            
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }

        if (a[i][k] == '4') {
            u = i + 1, v = k;
            if (!(a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '|' || a[u][v] == '+' || a[u][v] == '2' || a[u][v] == '3' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
            u = i, v = k - 1;
            if (!(a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z' || a[u][v] == 'M')) return 0;
            if (!visit[u][v] && (a[u][v] == '-' || a[u][v] == '+' || a[u][v] == '1' || a[u][v] == '2' || a[u][v] == '.' || a[u][v] == 'Z')) {
                visit[u][v] = 1;
                q.push(mp(u,v));
            }
        }
    }
    
    FOR(i,1,r) 
        FOR(k,1,c) if (a[i][k] != '.' && !visit[i][k]) return 0;
    
    return visit[x[1]][y[1]];
}

void process() {
    FOR(i,1,r)
        FOR(k,1,c) if (a[i][k] == '.') {
            REP(t,0,7) {
                a[i][k] = s[t];
                if (bfs()) {
                    printf("%d %d %c\n", i, k, s[t]);
                    return;
                }
            }
            a[i][k] = '.';
        }
}

void output() {
}

int main() {
    //freopen("cijevi.inp", "r", stdin);
    //freopen("cijevi.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
