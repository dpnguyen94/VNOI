#include <stdio.h>

int n;
long s[10007];
int a[10007], b[10007], c[10007];

void init() {
    scanf("%d", &n);    
    for (int i=1; i<= n; i++) { 
            scanf("%d%d\n", &a[i], &b[i]); 
            c[i] = b[i]-a[i]; 
    }
}

void qsort(int fi, int la) {
    int i, j, z, t1, t2;
    //
    if (fi >= la) return;
    i = fi; j = la;
    t1 = a[(fi+la)/2];
    t2 = b[(fi+la)/2];
    //
    do {
        while (a[i] < t1 || (a[i] == t1 && b[i] < t2)) i++;
        while (a[j] > t1 || (a[j] == t1 && b[j] > t2)) j--;
        
        if (i <= j) {
            if (i < j) {
                z = a[i]; a[i] = a[j]; a[j] = z;
                z = b[i]; b[i] = b[j]; b[j] = z;
                z = c[i]; c[i] = c[j]; c[j] = z;
            }
            i++; j--;
        }
    
    } while (i < j);
    //
    qsort(fi,j);
    qsort(i,la);    
}

void optimize() {
    long t, max1, max2;
    s[1] = c[1];
    
    max2 = s[1];
    for (int i=2; i<=n; i++) {
        s[i] = c[i];
        max1 = 0;
        for (int j=1; j<=i-1; j++) 
            if (a[i] >= b[j] && s[j] > max1) max1 = s[j];
        s[i] += max1;
        if (s[i] > max2) max2 = s[i];
    }
    //
    printf("%ld\n", max2);
}

main() {
    //freopen("nkrez.in", "r", stdin);
    //freopen("nkrez.out", "w", stdout);
    
    init();
    qsort(1,n);
    optimize();
    
    return 0;
}
