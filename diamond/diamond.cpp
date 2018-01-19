#include <stdio.h>
#include <math.h>
#include <memory.h>
#include <algorithm>

using namespace std;

#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 		for (int i=(a),_b=(b);i>=_b;i--)

const int LM = 505;

int m, n, h[LM], f1[LM][LM], f2[LM][LM], f3[LM][LM], f4[LM][LM];
char a[LM][LM];

void input() {
    scanf("%d %d\n", &m, &n);
    FOR(i,1,m) {
        FOR(k,1,n) scanf("%c", &a[i][k]);
        scanf("\n");
    }
}

void calc(char ch) {
    memset(h,0,sizeof(h));
    FOR(i,1,m) {
        FOR(k,1,n) if (a[i][k] == ch) h[k] ++;
        else h[k] = 0;
        
        FOR(k,1,n) if (h[k] > f1[i][k - 1]) f1[i][k] = f1[i][k - 1] + 1;
        else f1[i][k] = min(h[k],f1[i][k - 1]);
        
        DOW(k,n,1) if (h[k] > f2[i][k + 1]) f2[i][k] = f2[i][k + 1] + 1;
        else f2[i][k] = min(h[k],f2[i][k + 1]);
    }
    
    memset(h,0,sizeof(h));
    DOW(i,m,1) {
        FOR(k,1,n) if (a[i][k] == ch) h[k] ++;
        else h[k] = 0;
        
        FOR(k,1,n) if (h[k] > f3[i][k - 1]) f3[i][k] = f3[i][k - 1] + 1;
        else f3[i][k] = min(h[k],f3[i][k - 1]);
        
        DOW(k,n,1) if (h[k] > f4[i][k + 1]) f4[i][k] = f4[i][k + 1] + 1;
        else f4[i][k] = min(h[k],f4[i][k + 1]);
    }
}

void process() {
    int r, c, res = -1, fmin;
    for (char ch = 'A'; ch <= 'Z'; ch ++) {
        calc(ch);
        FOR(i,1,m) 
            FOR(k,1,n) {
                fmin = min(min(f1[i][k],f2[i][k]),min(f3[i][k],f4[i][k])) - 1;
                if (fmin > res) {
                    res = fmin;
                    r = i, c = k;
                }
            }
    }
    printf("%d %d %d\n", r, c, res);
}

void output() {
}

int main() {
    freopen("diamond.in1", "r", stdin);
    freopen("diamond.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
