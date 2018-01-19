#include <stdio.h>
#include <string>
using namespace std;
char good[100][1000], name[1000][1002];
int n, m;
int main() {
	//freopen("wordpow.in", "rt", stdin);
	//freopen("wordpow.out", "wt", stdout);
	
    scanf("%d%d",&n,&m);
	for (int i = 0; i < n; ++i) {
		scanf("%s",name[i]);
		for (int j = 0; name[i][j]; ++j) {
			name[i][j]=tolower(name[i][j]);			
		}
	}
	for (int i = 0; i < m; ++i) {
		scanf("%s",good[i]);
		for (int j = 0; good[i][j]; ++j) {
			good[i][j]=tolower(good[i][j]);			
		}

	}
	int y,x,c;
	for (int i = 0; i < n; ++i) {
		c=0;
		for (int j = 0; j < m; ++j) {
			x=0;
			for(y=0;name[i][y];y++)
			{
				if(name[i][y]==good[j][x])
					x++;
				if(!good[j][x]){
					c++;break;
				}
			}
		}
		printf("%d\n",c);
	}
	return 0;
}
