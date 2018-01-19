#include <stdio.h>

#define MAX 100

int a[MAX+2][MAX+2], qx[MAX*MAX], qy[MAX*MAX], prex[MAX+1][MAX+1], prey[MAX+1][MAX+1];
int offx[] = {0,0,-1,1}, offy[] = {1,-1,0,0};
int r, c, xb, yb;

void init() {
    int i,j;
    char ch;
        
    scanf("%d%d\n", &r, &c);
    for (i=1; i<=r; i++) {
        for (j=1; j<=c; j++) {
            scanf("%c", &ch);
            if (ch == '.') a[i][j] = 0;
            if (ch == '*') a[i][j] = 1;
            if (ch == 'C') { xb = i; yb = j; a[i][j] = 1; }
            a[1][1] = 0;
        }
        scanf("\n");
    
    for (i=0; i<= c+1; i++) { a[0][i] = 1; a[r+1][i] = 1; }
    for (i=0; i<= r+1; i++) { a[i][0] = 1; a[i][c+1] = 1; }
}

void BFS() {
    long fi = 1, la = 0;
    int i, j, t;
    la++; 
    qx[la] = xb; qy[la] = yb;
    prex[xb][yb] = 0; prey[xb][yb] = 0;
    //
    while (fi <= la) {
        i = qx[fi]; j = qy[fi]; 
        fi++;
        //
        for (t=0; t<4; t++) {
            if (a[i+offx[t]][j+offy[t]] == 0) {
                la++;
                qx[la] = i+offx[t]; qy[la] = j+offy[t];
                prex[qx[la]][qy[la]] = i; prey[qx[la]][qy[la]] = j;
                a[qx[la]][qy[la]] = 1;
                //
                if (a[1][1] == 1) return;
            }
        }
    }
}

void trace() {  
    long cnt = 0;
    int i = 1, j = 1, ti, tj;
    //
    while (i > 0 && j > 0) {
        cnt++;
        ti = i; tj = j;
        i = prex[ti][tj]; j = prey[ti][tj];
    }
    //
    printf("%ld\n", cnt-1);
}

main() {
    //freopen("vmunch.in", "r", stdin);
    //freopen("vmunch.out", "w", stdout);
    
    init();
    BFS(); 
    trace();
    
    return 0;
}
