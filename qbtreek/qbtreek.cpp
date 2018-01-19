#include <stdio.h>

using namespace std;

#define MOD 9901
int N,K;
int s[510][1010], f[510][1010];


void process() {
    //DP;
    f[1][1] = 1;
    for (int i=2; i<=K; i++) {
        for (int j=1; j<=N; j+=2)
            for (int k=1; k<=j-1-k; k+=2) {
                int c;
                if (k != j-1-k) c = 2; else c = 1;
                f[i][j] += c * (s[i-2][k] * f[i-1][j-1-k] + f[i-1][k] * s[i-2][j-1-k] + f[i-1][k] * f[i-1][j-1-k]);
                f[i][j] %= MOD;
            }
        
        for (int k=1; k<=N; k+=2) {
            s[i-1][k] += s[i-2][k] + f[i-1][k];
            s[i-1][k] %= MOD;
        }
    }        
            
    printf("%d", f[K][N]);
}

main() {
    //freopen("qbtreek.in", "r", stdin);
    //freopen("qbtreek.out", "w", stdout);
    
    scanf("%d %d", &N, &K);
    process();

    return 0;
}
