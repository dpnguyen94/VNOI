#include <stdio.h>
#include <memory.h>
#include <iostream>

using namespace std;

int n;
bool a[800][800];
int cnt, v[800];

int pre[800];
bool dx[800];
bool b[800][800];


void input() {
    int m, x, y;
    
    scanf("%d%d", &n, &m);
    memset(a, false, sizeof(a));
    for (int i=0; i<m; i++) {
        scanf("%d %d", &x, &y);
        a[x-1][y-1] = true;
    }
}

int dfs(int x) {
    //
    if (v[x] != -1) return v[x];
    
    //
    v[x] = cnt++;
    for (int i=0; i<n; i++) if (dx[i] && a[x][i]) {
        v[x] = min(v[x], dfs(i));
    }
    return v[x];
}

void build_graph() {
    //
    memset(dx, false, sizeof(dx));
    for (int i=0; i<n; i++) dx[v[i]] = true;
    
    //
    memset(b, false, sizeof(b));
    for (int i=0; i<n; i++) for (int j=0; j<n; j++) if (v[i]!=v[j] && a[i][j])
        b[ v[i] ][ v[j] ] = true;
     
    /*  
    for (int i=0; i<n; i++) if (dx[i]) {
        for (int j=0; j<n; j++) if (dx[j]) printf("%d ", int(b[i][j]));
        printf("\n");   
    }
    */
}

void rcount() {
    //
    memset(pre, 0, sizeof(pre));
    for (int i=0; i<n; i++) if (dx[i]) 
        for (int j=0; j<n; j++) if (dx[j] && b[i][j]) pre[j]++;
        
    //
    int res = 0;
    for (int i=0; i<n; i++) if (dx[i] && pre[i]==0) res++;
    //
    printf("%d\n", res);
}

void process() {
    // strongly connected components
    cnt = 0;
    memset(v, -1, sizeof(v));
    memset(dx, true, sizeof (dx));
    for (int i=0; i<n; i++) if (v[i] == -1) 
    {
        dfs(i);
        for (int j=0; j<n; j++) if (v[j] != -1) dx[j] = false;
    }
    for (int i=0; i<n; i++) cout << v[i] << " "; cout << endl; 
    
    // build new graph
    build_graph();
    
    //
    rcount();
}

int main() {
    //
    freopen("message.in", "r", stdin);
    freopen("message.out", "w", stdout);
     
    //
    input();
    process();
    
    //
    return 0;
}
