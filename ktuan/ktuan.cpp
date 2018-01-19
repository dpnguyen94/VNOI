#include <stdio.h>

#define C 1000000000

using namespace std;

long long p[100010];
long a[1000], sign[1000];
long n;

void init() {
    long i, j = 1;
    for (i=1; ; i++) {
        if (i%2 == 1) {
            a[i] = j*(3*j-1) / 2;
            j = -j;
        } 
        else {
            a[i] = j*(3*j-1) / 2;
               j = (-j) + 1;        
        }
        if (a[i] > n) break;
    }    
    
    for (j=1; j<=i; j++) {
        if (j%4 == 1 || j%4 == 2) sign[j] = 1;
        else sign[j] = -1;
    }
}

void process() {
    p[0] = 1;
    //
    for (long i=1; i<= n; i++) {
        long j = 1;
        p[i] = 0;
        while (i-a[j] >= 0) {
            p[i] += p[i-a[j]]*sign[j];
            j++;            
        }
        p[i] = p[i]%C;
        while (p[i] < 0) p[i] += C;
    }
}

main() {
    scanf("%ld", &n);
    init();
    process();
    
    p[0] = 0;
    printf("%lld\n", p[n]);
    
    return 0;
}
