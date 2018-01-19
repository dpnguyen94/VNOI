#include <stdio.h>
#include <memory.h>
#include <limits.h>
#include <stdlib.h>

#define maxN 10010
#define LM 256

using namespace std;
int n, a[8][maxN];
bool valid[LM], match[LM][LM];
int val[maxN][LM];
long long f[maxN][LM];

void input() {
    scanf("%d", &n);
    int res = INT_MIN;
    
    for (int i=0; i<8; i++)
        for (int j=1; j<=n; j++) {
            scanf("%d", &a[i][j]);
            if (a[i][j] > res) res = a[i][j];
        }
        
    if (res <= 0) {
        printf("%d\n", res);
        exit(0);
    }
}

int getbit(int i, int j) {
    return (i >> j) & 1;
}

void init() {
    for (int i=0; i<LM; i++) {
        valid[i] = 1;        
        for (int j=1; j<8; j++)
            if (getbit(i,j) == 1 &&  getbit(i,j-1) == 1) {
                valid[i] = 0;
                break;
            }
    }
        
    for (int i=0; i<LM; i++)
        for (int j=0; j<LM; j++) 
            if (valid[i] && valid[j])
            {
                match[i][j] = 1;
                for (int k=0; k<8; k++)
                    if (getbit(i,k) == 1 && getbit(j,k) == 1) {
                        match[i][j] = 0;
                        break;                        
                    }
            }
            
    for (int i=1; i<=n; i++)
        for (int j=0; j<LM; j++)
            if (valid[j]) for (int k=0; k<8; k++)
                    val[i][j] += getbit(j,k) * a[k][i];
}

void process() {
    for (int i=0; i<LM; i++) if (valid[i]) 
        f[1][i] = (long long)val[1][i];
        
    for (int i=2; i<=n; i++) {
        for (int j=0; j<LM; j++)
            if (valid[j]) {
                long long t = LLONG_MIN;
                
                for (int k=0; k<LM; k++)
                    if (valid[k]) 
                        if (match[j][k]) 
                            if (f[i-1][k] > t) t = f[i-1][k];
                
                f[i][j] = t + (long long)val[i][j];
            }
    }
}

void output() {
    long long res = LLONG_MIN;
    
    for (int i=0; i<LM; i++)
        if (valid[i])
            if (f[n][i] > res) res = f[n][i];
        
    printf("%lld\n", res);
}

main() {
    //freopen("qbgame.in", "r", stdin);
    //freopen("qbgame.out", "w", stdout);
    //
    input();
    init();
    process();
    output();
    //
    return 0;    
}

