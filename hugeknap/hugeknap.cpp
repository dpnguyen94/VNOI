#include <stdio.h>
#include <memory.h>
#include <conio.h>

using namespace std;
int w[10010], v[10010], n, m;
long f[10010][1010];

void input() {
    scanf("%d %d", &n, &m);
    for (int i=1; i<= n; i++) scanf("%d", &w[i]);
    for (int i=1; i<= n; i++) scanf("%d", &v[i]);
}

void process() {
    memset(f[0],0,sizeof(f[0]));
    long carry;
    for (int i=1; i<= n; i++) 
        for (int j=0; j<= m; j++) {
            f[i][j] = f[i-1][j];
            if (j >= w[i]) {
                carry = f[i-1][j-w[i]] + v[i];
                if (carry > f[i][j]) f[i][j] = carry;
            }
        }
    //output;
    printf("%ld ", f[n][m]);
    int cnt = 0;
    while (n > 0) {
        if (f[n][m] != f[n-1][m]) {
            v[++cnt] = n;
            m -= w[n];
        }
        n--;
    }
    printf("%d\n", cnt);
    for (int i=cnt; i>= 1; i--) printf("%d ", v[i]);
}

main() {
    //freopen("hugeknap.in", "r", stdin);
    //freopen("hugeknap.out", "w", stdout);
    
    int num_Test;
        
    scanf("%d", &num_Test);
    for (int t=1; t<= num_Test; t++) {
        input();
        process();
    }
    return 0;
    
    getch();
}
