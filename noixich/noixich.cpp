#include <stdio.h>

int n;
int a[20010];

void input() {
    scanf("%d", &n);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}

void sort(int fi, int la) {
    if (fi >= la) return;
    
    int i, j , t, z;
    i = fi; j = la;
    t = a[(fi+la)/2];
    
    while (i <= j) {
        while (a[i] < t) i++;
        while (a[j] > t) j--;
    
        if (i <= j) {
            if (i < j) {
                z = a[i]; a[i] = a[j]; a[j] = z;
            }
            i++; j--;
        }
    }
    
    sort(fi,j);
    sort(i,la);
}

void process() {
    sort(1,n);
    long res = 0, t;
    //
    for (int i=1; i<=n; i++)
        if (res+a[i] < n-i) res += a[i];
        else {
            t = i;
            break;
        }
    res = n-t;
    
    printf("%ld", res);
}

main() {
    //freopen("noixich.in", "r", stdin);
    //freopen("noixich.out", "w", stdout);
    
    input();
    process();

    return 0;
}
