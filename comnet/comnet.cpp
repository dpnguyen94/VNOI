#include <stdio.h>
#include <stdio.h>
#include <memory.h>

#define MAX_N 5010

using namespace std;
int n, a[400010], b[400010], f[MAX_N], q[MAX_N];
long m;
bool vs[MAX_N];
int cnt, fst[MAX_N];

void input() {
    int u, v;
    memset(f,0,sizeof(f));
    scanf("%d %ld", &n, &m);
    for (int i=1; i<=m; i++) {
        scanf("%d %d", &u, &v);
        a[i] = u; b[i] = v;
        a[i+m] = v; b[i+m] = u;;
        f[u]++; f[v]++;
    }
    
    for (int i=2; i<= n; i++) f[i]+= f[i-1];
}

void qsort(long fi, long la) {
    long i, j , z, t;
    if (fi >= la) return;
    i = fi; j = la;
    t = a[(fi+la)/2];
    //
    do {    
        while (a[i] < t) i++;
        while (a[j] > t) j--;
        
        if (i <= j) {
            if (i < j) {
                z = a[i]; a[i] = a[j]; a[j] = z;
                z = b[i]; b[i] = b[j]; b[j] = z;
            }
            i++; j--;
        }
    } while (i <= j);
    //
    qsort(fi,j);
    qsort(i,la);
}

void bfs(int i) {
    int fi = 1, la = 0, s;
    la++; q[la] = i;
    
    while (fi <= la) {
        s = q[fi]; fi++;
        for (int j=f[s-1]+1; j<= f[s]; j++) {
                if (!vs[b[j]]) {
                vs[b[j]] = 1;
                la++;
                q[la] = b[j];
            }
        }        
    }
}


void process() {
    memset(vs,false,sizeof(vs));
    
    for (int i=1; i<= n; i++) {
        if (!vs[i]) {
            cnt++;   
            fst[cnt] = i;
            bfs(i);
        }
    }
    //
    printf("%d\n", cnt-1);
    for (int i=2; i<=cnt; i++) printf("%d %d\n", fst[1], fst[i]);
}

main () {
    freopen("comnet.inp", "r", stdin);
    freopen("comnet.out", "w", stdout);
    //
    input();
    qsort(1,m+m);
    process();
    
    return 0;
}
