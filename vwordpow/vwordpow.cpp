#include <stdio.h>
#include <memory.h>
#include <ctype.h>

using namespace std;

char cow[1010][1010], s[110][35];
int n, m, good[1010];

void input() {
    scanf("%d %d", &n, &m);
    for (int i=0; i<n; i++) {
        scanf("%s", cow[i]);
        for (int j=0; j<strlen(cow[i]); j++) cow[i][j] = tolower(cow[i][j]);
    }
    for (int i=0; i<m; i++) {
        scanf("%s", s[i]);
        for (int j=0; j<strlen(s[i]); j++) s[i][j] = tolower(s[i][j]);
    }
}

bool in_str(char x[], char y[]) {
    int lenx = strlen(x), leny = strlen(y), i = 0, j = 0;
    while (i < lenx && j < leny)
        if (x[i] == y[j]) { 
            i++; j++; 
        }
        else j++; 
    if (i == lenx) return true;
    else return false;
}

void process() {
    memset(good,0,sizeof(good));
    for (int i=0; i<n; i++)
        for (int j=0; j<m; j++)
            if (in_str(s[j],cow[i])) good[i]++;
    //output;
    for (int i=0; i<n; i++) printf("%d\n", good[i]);
}

main() {
    //freopen("vwordpow.in", "r", stdin);
    //freopen("vwordpow.out", "w", stdout);
    
    input();
    process();
    
    return 0;
}
