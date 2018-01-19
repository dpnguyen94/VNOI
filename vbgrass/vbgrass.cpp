#include <stdio.h>
#include <memory.h>

#define MAX 101

char a[MAX][MAX];
int v[MAX][MAX];
int m,n;

void input() {
    scanf("%d%d\n", &m, &n);
    for (int i=1; i<=m; i++) {
        for (int j=1; j<=n; j++) scanf("%c", &a[i][j]);
        scanf("\n");
    }
}

void ffill(int x, int y, char c) {
    if (v[x][y] != 0 || a[x][y] != c) return;
    v[x][y] = 1;
    if (x-1 >= 1) ffill(x-1,y,c);
    if (x+1 <= m) ffill(x+1,y,c);
    if (y-1 >= 1) ffill(x,y-1,c);
    if (y+1 <=n) ffill(x,y+1,c);
}

void process() {
    memset(v,0,sizeof(v));
    //
    int cnt = 0;
    for (int i=1; i<=m; i++) 
        for (int j=1; j<=n; j++) {
            if (v[i][j] == 0 && a[i][j] == '#') {
                cnt++;
                ffill(i,j,a[i][j]);
            }
        }
    printf("%d\n", cnt);   
}

main() {
    //freopen("grass.in", "r", stdin);
    //freopen("grass.out", "w", stdout);
    
    input();
    process();
    
    return 0;
}
