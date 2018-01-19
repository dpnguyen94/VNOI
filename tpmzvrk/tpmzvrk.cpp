#include <string>
#include <iostream>
using namespace std;

const int MOD=15111992;
string a,b;
int resa,resb,num,i;
int main() {
    cin >> a;
    cin >> b;
    num = 0;for(i=0;i<a.length();i++){resa=(resa*2+num)%MOD;num=(num*2)%MOD;if(a[i]=='1')resa=(resa+1)%MOD,num=(num+1)%MOD;}
    num = 0;for(i=0;i<b.length();i++){resb=(resb*2+num)%MOD;num=(num*2)%MOD;if(b[i]=='1')resb=(resb+1)%MOD,num=(num+1)%MOD;}
    cout << (resb-resa+MOD)%MOD;
    return 0;
}
