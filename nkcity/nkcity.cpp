#include <stdio.h>
#include <memory.h>
#include <limits.h>

int a[20010], b[20010], c[20010], f[1001], cnt, m, n;
bool vs[1001];

void input() {
    int u, v, val;
    
    memset(f,0,sizeof(f));
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++) {
        scanf("%d%d%d", &u, &v, &val);
        a[i] = u; b[i] = v; c[i] = val;
        a[i+m] = v; b[i+m] = u; c[i+m] = val;
        f[u]++; f[v]++;
    }
    
    for (int i=2; i<= n; i++) f[i]+= f[i-1];
}

void qsort(int fi, int la) {
    int i, j , z, t;
    
    if (fi >= la) return;
    i = fi; j = la;
    t = a[(fi+la)/2];
    
    do {    
        while (a[i] < t) i++;
        while (a[j] > t) j--;
        
        if (i <= j) {
            if (i < j) {
                z = a[i]; a[i] = a[j]; a[j] = z;
                z = b[i]; b[i] = b[j]; b[j] = z;
                z = c[i]; c[i] = c[j]; c[j] = z;
            }
            i++; j--;
        }
    } while (i <= j);
        
    qsort(fi,j);
    qsort(i,la);
}

void DFS(int x, int mid) {
    vs[x] = true; 
    cnt++;
    
    for (int i=f[x-1]+1; i<= f[x]; i++) 
        if (!vs[b[i]] && c[i] <= mid) DFS(b[i], mid);    
}

bool lienthong(int mid) {
    cnt = 0;
    memset(vs,false,sizeof(vs));
    
    DFS(1,mid);
    return (cnt == n);    
}

void process() {
    int fi = 0, la = INT_MAX, mid, res;
    
    while (fi <= la) {
        mid = (fi+la)/2;
        if (lienthong(mid)) { la = mid - 1; res = mid; }
        else fi = mid+1;
    }
    
    printf("%d\n", res);
}

main () {
    //freopen("nkcity.in", "r", stdin);
    //freopen("nkcity.out", "w", stdout);
    
    input();
    qsort(1,m+m);
    process();
    
    return 0;
    
}
