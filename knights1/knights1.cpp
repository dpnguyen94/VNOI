#include <stdio.h>
#include <iostream>

#define maxN  3000 + 10
#define maxM  100000 + 10
#define maxC  1000000000

using namespace std;

int n,m,q,s,t;
int x[maxM], y[maxM], l[maxM];
int h[maxN];
int a[2 * maxM], len[2 * maxM];
int d[maxN];
int nheap;
int heap[maxN], pos[maxN];


void input() {
    scanf("%d%d\n", &n, &m);
    for (int i = 1; i <= m; i++) {
        scanf("%d%d%d\n", &x[i], &y[i], &l[i]);
        h[x[i]]++;
        h[y[i]]++;
    }
    
    for (int i = 2; i <= n+1; i++)
        h[i] += h[i-1];
        
    int u, v;
    for (int i = 1; i <= m; i++) {
        u = x[i];
        v = y[i];
        
        a[h[u]] = v;
        a[h[v]] = u;
        len[h[u]--] = l[i];
        len[h[v]--] = l[i];
    }
    
    scanf("%d\n", &q);
}

void init() {
    d[s] = 0;
    heap[1] = s;
    pos[s] = 1;
    nheap = 1;    
    
    for (int i = 1; i <= n; i++)
        if (i != s) {
            d[i] = maxC;
            heap[++nheap] = i;
            pos[i] = nheap;
        }
}

int pop() {
    int tmp = heap[1];
    
    int i, p, c;
    i = heap[nheap--];
    
    p = 1;
    while (true) {
        c = p * 2;
        if (c < nheap && d[heap[c]] > d[heap[c+1]]) c++;
        if (c > nheap || d[i] <= d[heap[c]]) break;
        
        heap[p] = heap[c];
        pos[heap[p]] = p;
        p = c;
    }
    
    heap[p] = i;
    pos[i] = p;
    
    return tmp;
}

void update(int ps) {
    int i, c, p;
    
    i = heap[ps];
    
    c = ps;
    while (true) {
        p = c / 2;
        if (p == 0 || d[i] >= d[heap[p]]) break;
        
        heap[c] = heap[p];
        pos[heap[c]] = c;
        c = p;
    }    
    
    heap[c] = i;
    pos[i] = c;
}

void process() {
    int u, v, tmp;
    while (true) {
        u = pop();
        if (u == t || nheap == 0) break;

        for (int i = h[u] + 1; i <= h[u + 1]; i++) {
            v = a[i];
            
            tmp = max(d[u],len[i]);
            if (d[v] > tmp) { d[v] = tmp; update(pos[v]); }
        }        
    }
    
    printf("%d\n", d[t]);
}

int main() {
    freopen("knights1.in", "r", stdin);
    freopen("knights1.out", "w", stdout);
    
    input();
    for (int i = 1; i <= q; i++) {
        scanf("%d%d\n", &s, &t);
        init();
        process();
    }
    
    return 0;
}
