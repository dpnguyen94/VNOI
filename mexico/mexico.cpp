#include <stdio.h>
#include <memory.h>
#include <vector>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 		for (int i=(a),_b=(b);i>=_b;i--)
#define pb              push_back
#define sz(c)           int((c).size())

typedef vector<int> 	vi;

const int LM = 1005;

int n, m;
bool a[LM][LM];
int le[LM][LM], ri[LM][LM];
vi x;

void input() {
    scanf("%d %d", &n, &m);
    int u, v;
    REP(i,0,m) {
        scanf("%d %d", &u, &v);
        u --; v --;
        a[u][v] = a[v][u] = 1;
    }
}

inline int findleft(int u, int v);
inline int findright(int u, int v);

inline int findleft(int u, int v) {
    if (le[u][v] != -1) return le[u][v];
    if (u == v) return le[u][v] = 1;
    
    int v2 = (v + n - 1) % n;
    if ((a[v2][v] && findleft(u,v2)) || (a[u][v] && findright(v2,u))) return le[u][v] = 1;
    
    return le[u][v] = 0;
}

inline int findright(int u, int v) {
    if (ri[u][v] != -1) return ri[u][v];
    if (u == v) return ri[u][v] = 1;
    
    int v2 = (v + 1) % n;
    if ((a[v2][v] && findright(u,v2)) || (a[u][v] && findleft(v2,u))) return ri[u][v] = 1;
    
    return ri[u][v] = 0;
}

inline void traceright(int u, int v);
inline void traceleft(int u, int v);

inline void traceright(int u, int v) {
    x.pb(v);
    if (u == v) return;
    
    int v2 = (v + 1) % n;
    if (ri[u][v2] && a[v2][v]) traceright(u,v2);
    else traceleft(v2,u);
}

inline void traceleft(int u, int v) {
    x.pb(v);
    if (u == v) return;
    
    int v2 = (v + n - 1) % n;
    if (le[u][v2] && a[v2][v]) traceleft(u,v2);
    else traceright(v2,u);
}

void process() {
    memset(le,-1,sizeof(le));
    memset(ri,-1,sizeof(ri));

    REP(i,0,n - 1)
        REP(k,i + 1,n) if (findright(i,k) && findleft(i + 1,k)) {
            traceright(i,k);
            DOW(t,sz(x) - 1,0) printf("%d\n", x[t] + 1);
            x.clear();
            traceleft(i + 1,k);
            REP(t,1,sz(x)) printf("%d\n", x[t] + 1);
            return;
        }
    
    printf("-1\n");
}

void output() {
}

int main() {
    //freopen("mexico.inp", "r", stdin);
    //freopen("mexico.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
