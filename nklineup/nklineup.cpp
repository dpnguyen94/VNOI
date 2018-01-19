#include <stdio.h>

#define MAX_COW 50001
long long cc[MAX_COW];
int a[MAX_COW][MAX_COW], b[MAX_COW][MAX_COW];
unsigned int n, c, d;
long long q;

void enter() {
    unsigned int i;
    //
    scanf("%u%ld", &n, &q);
    for (i=1; i<=n; i++) scanf("%ld", &cc[i]);
}

long long max(long long x, long long y) {
    if (x > y) return x;
    return y;
}

long long min(long long x, long long y) {
    if (x < y) return x;
    return y;
}

void find() {
    unsigned int i,j;
    for (i=1; i<=n; i++) 
        a[i][i] = b[i][i] = cc[i];
    //
    for (i=1; i<=n-1; i++) 
        for (j = i+1; j<=n; j++) {
            a[i][j] = max(a[i][j-1],cc[j]);
            b[i][j] = min(b[i][j-1],cc[j]);
        }
    //
    printf("%u", a[c][d]-b[c][d]);
}

main() {
    enter();
    long long i;    
    
    for (i=1; i<=q; i++) {
        scanf("%u%u", &c, &d);
        find();
    }
    //
    return 0;
}
