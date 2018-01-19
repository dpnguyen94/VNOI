#include <stdio.h>
#include <memory.h>

const int offx[] = {-1, 0, 1, 0};
const int offy[] = { 0, 1, 0,-1};

int m,n;
int a[1002][1002];
int fi, la, qx[1001*1001], qy[1001*1001];

void input() {
    int cnt = 0;
    //
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++) {
            scanf("%d", &a[i][j]);
            if (a[i][j] == 1 && a[i][j-1] == 0 && a[i-1][j] == 0) cnt++;
        }
    printf("%d", cnt);
}

void ffill_dfs(int x, int y) {
    a[x][y] = 0;
    //
    if (x-1 >= 1 && a[x-1][y] == 1) ffill_dfs(x-1,y);
    if (x+1 <= m && a[x+1][y] == 1) ffill_dfs(x+1,y);
    if (y-1 >= 1 && a[x][y-1] == 1) ffill_dfs(x,y-1);
    if (y+1 <= n && a[x][y+1] == 1) ffill_dfs(x,y+1);
}

void ffill_bfs(int x, int y) {
    int u, v;
    
    //
    fi = 0; la = 0;
    qx[0] = x; qy[0] = y;
    a[x][y] = 0;
    
    //
    while (fi<=la) {
        x = qx[fi]; y = qy[fi]; fi++;
        for (int i=0; i<4; i++) {
            u = x + offx[i];  v = y + offy[i];
            if (!(1<=u && u<=m && 1<=v && v<=n)) continue;
            if (a[u][v] == 0) continue;
            
            a[u][v] = 0;
            qx[++la] = u; qy[la] = v;
        }
    }
}

void process() {
    long cnt = 0;
    for (int i=1; i<=m; i++) 
        for (int j=1; j<=n; j++) {
            if (a[i][j] == 1) {
                cnt++;
                ffill_bfs(i,j);
            }
        }
    printf("%ld", cnt);
}

void process2() {
    int cnt = 0;
    for (int i=1; i<=m; i++) 
        for (int j=1; j<=n; j++)
            if (a[i][j]==1 && a[i-1][j]==0 && a[i][j-1]==0) cnt++;
    printf("%ld", cnt);
}    

main () {
    //freopen("demtau.in", "r", stdin);
    //freopen("demtau.out", "w", stdout);
        
    input();
    
    return 0;
}
