#include <stdio.h>

int n, k, cleft;
int a[10000001];
long long sleft, sright, res;

void input() {
    scanf("%d\n", &k);

    n = 10000000;
    int num;
    for (int i = 1; i <= k ; i++) {
        scanf("%d\n", &num);    
        
        if (num == 1) {
            cleft++;
            a[1]++;
            continue;
        }
        
        if (num > 5000000) {
            cleft++;
            sleft += (n + 1 - num);
        }
        else 
            sright += (num - 1);
            
        a[num]++;
    }
}

void process() {
    res = sleft + sright;
    
    int j;
    for (int i = 2; i <= n; i++) {
        j = i + 4999999;
        if (j > n) j -= n;
    
        sleft += cleft - a[j] * 5000001;
        sright += a[j] * 4999999 - (k - cleft);
        cleft += a[i] - a[j];
            
        if (sleft + sright < res)
            res = sleft + sright;
    }
    
   printf("%lld\n", res);
}

int main() {
//    freopen("msafe.in1", "r", stdin);
//    freopen("msafe.out", "w", stdout);
    
    input();
    process();    
    
    return 0;
}
