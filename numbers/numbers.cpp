#include <stdio.h>
#include <math.h>
#include <algorithm>

#define maxN 50010
#define maxV 1000010

using namespace std;
int n, a[maxN], h[maxN], f[maxV], fn[maxN];
bool inseq[maxV];

void input() {
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++) {
        scanf("%d", &a[i]);
        inseq[a[i]] = 1;
    }
}

void qsort1(int le, int ri) {
    if (le >= ri) return;
    int i = le ,j = ri, t = a[(le + ri)/2];
    
    do {
        while (a[i] < t) i++;
        while (a[j] > t) j--;
        
        if (i <= j) {
            swap(a[i],a[j]);
            i++; j--;
        }
    } while (i <= j);
    
    qsort1(le,j);
    qsort1(i,ri);
}

void process() {
    qsort1(1,n);
    
    for (int i=1; i<= n; i++)
        f[a[i]] = 1;
    
    for (int i=1; i<= n; i++) {
        if (a[i] == a[i-1]) {
            h[i] = ++f[a[i]];
            continue;
        }
        
        int j1;
        for (int j=1; j <= sqrt(a[i]); j++)
            if (a[i]%j == 0) {
                if (j != a[i] && inseq[j])
                    f[a[i]] = max(f[j] + 1, f[a[i]]);

                j1 = a[i] / j;
                if (j1 != a[i] && inseq[j1])
                    f[a[i]] = max(f[j1] + 1, f[a[i]]);
            }
        
        h[i] = f[a[i]];
    }
}

void qsort2(int le, int ri) {
    if (le >= ri) return;
    int i = le ,j = ri, t = h[(le + ri)/2];
    
    do {
        while (h[i] < t) i++;
        while (h[j] > t) j--;
        
        if (i <= j) {
            swap(h[i],h[j]);
            swap(a[i],a[j]);
            i++; j--;
        }
    } while (i <= j);
    
    qsort2(le,j);
    qsort2(i,ri);
}


void output() {
    int res = 0;
    for (int i=1; i<= n; i++)
        res = max(res, h[i]);
    printf("%d\n", res);

    qsort2(1,n);
    
    int cnt = 1;
    for (int i=2; i<= n; i++) {
        if (h[i] != h[i-1])
            fn[cnt++] = i-1;
    }    
    fn[cnt] = n;
    
    for (int i=1; i<= cnt; i++) {
        printf("%d ", fn[i] - fn[i-1]);
        for (int j=fn[i-1]+1; j<= fn[i]; j++)
            printf("%d ", a[j]);
        printf("\n");
    }
}

main() {
    //freopen("numbers.in", "r", stdin);
    //freopen("numbers.out", "w", stdout);
    //    
    input();
    process();    
    output();
    //
    return 0;
}
