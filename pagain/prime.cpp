bool is_prime(int x) {  //x > 0
    //
    if (x==1) return false;
    if (x==2 || x==3)  return true;
    if (x%2 == 0) return false;
    if (x%3 == 0) return false;
    
    int i = 5, j = 2, x2 = 1+(int)sqrt(x);
    
    while (i<=x2) {
        if (x%i==0) return false;
        i = i + j; j = 6-j;
    }
    
    return true;
}

#define MAX 1000001
void create_p(bool p[MAX]) {
    for (int i=0; i<MAX; i++) p[i] = true;
    p[0] = p[1] = false;
    
    int j;
    for (int i=2; i<MAX; i++) if (p[i]) {
        j = i;
        while (j+i <MAX) {
            j += i;
            p[j] = false;
        }
    }
}
