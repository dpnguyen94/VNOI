#include <stdio.h>

const int MAXN = 5005;

int n, m;
int x[MAXN], y[MAXN], xx[MAXN], yy[MAXN];

void input() {
    scanf("%d", &n);
    for (int i = 0; i < n; i ++) scanf("%d %d", &x[i], &y[i]);
    x[n] = x[0];
    y[n] = y[0];
    
    for (int i = 0; i < n; i ++) {
        xx[i] = x[i + 1] - x[i];
        yy[i] = y[i + 1] - y[i];
    }
}

void process() {
    scanf("%d", &m);
    
    int a, b;
    long long x2, y2;
    bool ok;
    for (int i = 0; i < m; i ++) {
        scanf("%d %d", &a, &b);
        
        ok = 1;
        for (int k = 0; k < n; k ++) {
            x2 = a - x[k];
            y2 = b - y[k];
            
            if ((long long)xx[k] * y2 <= x2 * (long long)yy[k]) {
                ok = 0;
                break;
            }
        }
        
        if (ok) printf("YES\n");
        else printf("NO\n");
    }
}

void output() {
}

int main() {
    //freopen("nkrain.inp", "r", stdin);
    //freopen("nkrain.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
