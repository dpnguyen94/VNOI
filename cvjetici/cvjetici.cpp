#include <stdio.h>
#include <algorithm>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)

const int MAXN = 100005;

int n, IT[4 * MAXN];

void input() {
    scanf("%d", &n);
}

int get(int nd, int x, int y, int u) {
    if (x == y) return IT[nd];
    
    int mid = (x + y) / 2;
    if (u <= mid) return IT[nd] + get(2 * nd,x,mid,u);
    else return IT[nd] + get(2 * nd + 1,mid + 1,y,u);
}

void update(int nd, int x, int y, int u, int v) {
    if (u > v) return;
    if (x == u && y == v) {
        IT[nd] ++;
        return;
    }
    
    int mid = (x + y) / 2;    
    if (u <= mid) update(2 * nd,x,mid,u,min(v,mid));
    if (v >= mid + 1) update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
}

void set_zero(int nd, int x, int y, int u, int k) {
    if (x == y) {
        IT[nd] -= k;
        return;
    }
    
    int mid = (x + y) / 2;
    if (u <= mid) set_zero(2 * nd,x,mid,u,k);
    else set_zero(2 * nd + 1,mid + 1,y,u,k);    
}

void process() {
    int L, R, le, ri;
    REP(i,0,n) {
        scanf("%d %d", &L, &R);
        le = get(1,1,MAXN,L);
        ri = get(1,1,MAXN,R);
        
        printf("%d\n", le + ri);        
        
        set_zero(1,1,MAXN,L,le);
        set_zero(1,1,MAXN,R,ri);
        update(1,1,MAXN,L + 1,R - 1);
    }
}

void output() {
}

int main() {
    //freopen("cvjetici.inp", "r", stdin);
    //freopen("cvjetici.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
