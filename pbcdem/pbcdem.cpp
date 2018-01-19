#include <stdio.h>
#include <algorithm>

using namespace std;


const int LM = 1000000000;
typedef int bigint[10];

int n;
bigint f[4000];

void add(bigint x, bigint y) {
    x[0] = max(x[0],y[0]);

    int carry = 0;    
    for (int i=1; i<= x[0]; i++) {
        x[i] += y[i] + carry;
        if (x[i] >= LM) {
            x[i] -= LM;
            carry = 1;
        } else carry = 0;
    }
    
    if (carry > 0) x[++x[0]] = 1;
}


bool cmp(bigint x) {
    if (x[0] == 0) return true;
    
    return false;
}

void setbn(bigint x) {
    x[0] = 1;
    x[1] = 1;
}

void output(bigint x) {
    printf("%d", x[x[0]--]);
       
    for (int i=x[0]; i>=1; i--) printf("%09d", x[i]);
    printf("\n");
}

main() {
    freopen("pbcdem.out", "w", stdout);
    
    scanf("%d", &n);
    setbn(f[0]);
    
    for (int i=1; i<n; i++)
        for (int j=n-i; j>=0; j--)
            {
                if (cmp(f[j])) continue;
                add(f[j+i],f[j]);
            }
    //
    output(f[n]);
    return 0;
}
