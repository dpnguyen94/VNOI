#include <stdio.h>
#include <memory.h>

int n, m;
unsigned long long a[510], c[1010][510];

void input() {
    scanf("%d%d", &n, &m);
    for (int i=1; i<= m; i++) scanf("%llu", &a[i]);
}

void process() {
    memset(c,0,sizeof(c));
    for (int i=0; i<=n; i++) c[i][0] = 1;
    c[a[1]][1] = 1;
    
    for (int j=1; j<= m; j++)
        for (int i=1; i<= n; i++) 
            if (i > a[j]) c[i][j] = c[i-a[j]-1][j-1]+c[i-1][j];
    
    printf("%llu\n", c[n][m]);
}

main() {
    input();
    process();

    return 0;
}
