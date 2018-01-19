#include <stdio.h>

#define MAX_N 1001
#define MAX_K 1001

int n, k;
long long a[MAX_N]; 
int f[MAX_N][MAX_K-1];

void input() {
    scanf("%d%d\n", &n, &k);
    for (int i=1; i<=n; i++) scanf("%ld", &a[i]);
}

int sub(int x, long long y) {
    int t;
    //
    t = (x-y) % k;
    if (t >= 0) return t;
    return t+k;
}

void process() {
    int j;
    //
    f[0][0] = 0;
    for (int i=1; i<k; i++) f[0][i] = MAX_K;
    for (int i=1; i<=n; i++)
        for (int j=0; j<k; j++) {
            if (f[i-1][j] < f[i-1][sub(j,a[i])]+1) f[i][j] = f[i-1][j];
            else f[i][j] = f[i-1][sub(j,a[i])]+1;
        }
    //
    long long sum = 0;
    for (int i=1; i<=n; i++) sum+= a[i];
    //
    printf("%d\n", n - f[n][sum%k]);
}

main () {
    input();
    process();
    
    return 0;
}
