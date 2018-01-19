#include <iostream>

using namespace std;

int c, n, a[16];

void input() {
    scanf("%d%d", &c, &n);
    for (int i=0; i<n; i++) scanf("%d", &a[i]);
}

void process() {
    int tmp, res = 0;
    for (int mask=0; mask<(1<<n); mask++) {
        tmp = 0;
        for (int i=0; i<n; i++) if (((mask>>i)&1)==1) tmp += a[i];
        if (res<tmp && tmp<=c) res = tmp;
    }
    printf("%d\n", res);
}


int main() {
    //freopen("vcowflix.in", "r", stdin);
    //freopen("vcowflix.out", "w", stdout);
    input();
    process();
    return 0;
}
