#include <stdio.h>

using namespace std;

int m, n;
char a[1001][301];

void input() {
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m; i++) 
        for (int j=1; j<=n; j++) scanf("%d", &a[i][j]);
}

void process() {
    int i, j, k, cnt;
    long long res = 0;
    
    for (i=1; i<n; i++) 
        for (j=i+1; j<=n; j++) {
            cnt = 0;
            //for (k=0; k<m; k++) cnt += a[k][i] & a[k][j];
            for (k=1; k<=m; k++) cnt += a[k][i] & a[k][j];
            res += cnt*(cnt-1)/2;
        }
    printf("%lld\n", res);
}

int main() {
    //freopen("lqdrect.inp", "r", stdin);
    //freopen("lqdrect.out", "w", stdout);
    
    input();
    process();
    return 0;
}
