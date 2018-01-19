#include <stdio.h>
#include <memory.h>
#include <limits.h>

#include <iostream>
#include <algorithm>


using namespace std;


int n, q, le, ri;
int a[50000];
int tmin[50000][16], tmax[50000][16];

void input() {
    scanf("%d%d", &n, &q);
    for (int i=0; i<n; i++) scanf("%d", &a[i]);
}


void build_tree() {
    //
    for (int i=0; i<n; i++) tmin[i][0] = tmax[i][0] = a[i];
    
    //
    for (int k=1; k<=15; k++) for (int i=0; (i + (1<<k) - 1) < n; i++) {
        tmin[i][k] = min(tmin[i][k-1], tmin[i + (1<<(k-1))][k-1]);
        tmax[i][k] = max(tmax[i][k-1], tmax[i + (1<<(k-1))][k-1]);
    }
}


void process() {
    int vmin, vmax;
    int k, len;

    for (int i=0; i<q; i++) {
        //
        scanf("%d%d", &le, &ri);
        le--; ri--;     // 0-based index
        
        //
        len = (ri-le+1);
        for (k=1; (1<<k) < len; k++);
        k--;
        
        // 
        vmin = min(tmin[le][k], tmin[ri-(1<<k)+1][k]);
        vmax = max(tmax[le][k], tmax[ri-(1<<k)+1][k]);
        printf("%d\n", vmax - vmin);
    }
}

int main() {
    input();
    build_tree();
    process();
    return 0;
}
