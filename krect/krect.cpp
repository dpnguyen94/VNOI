#include <stdio.h>
#include <memory.h>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)

const int LM = 105;

int m, n, K, x[LM][LM][26], y[26];
char a[LM][LM];

void input() {
    scanf("%d %d %d\n", &m, &n, &K);
    FOR(i,1,m) {
        FOR(k,1,n) {
            scanf("%c", &a[i][k]);
            REP(c,0,26) x[i][k][c] = x[i][k - 1][c];
            x[i][k][a[i][k] - 'A'] ++;
        }
        scanf("\n");
    }
}

bool check(int num) {
    int cnt = 0;
    REP(c,0,26) if (y[c] > 0) cnt ++;
    
    return (cnt > num);
}

int calc(int num) {
    int t, z, res = 0;
    FOR(i,1,n) 
        FOR(k,i,n) {
            z = 1;
            memset(y,0,sizeof(y));
            FOR(t,1,m) {
                REP(c,0,26) y[c] += (x[t][k][c] - x[t][i - 1][c]);
                
                while (z <= t && check(num)) {
                    REP(c,0,26) y[c] -= (x[z][k][c] - x[z][i - 1][c]);
                    z ++;
                }
                res += (t - z + 1);
            }
        }
            
    return res;
}

void process() {
    printf("%d\n", calc(K) - calc(K - 1));
}

void output() {
}

int main() {
    //freopen("krect.inp", "r", stdin);
    //freopen("krect.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
