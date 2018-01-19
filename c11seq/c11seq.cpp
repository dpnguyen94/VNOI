#include <stdio.h>
#include <math.h>
#include <limits.h>
#include <memory.h>
#include <algorithm>
#include <numeric>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <queue>
#include <stack>
#include <map>
#include <set>

using namespace std;

#define REP(i,a,b) 		for (int i=(a),_b=(b);i<_b;i++)
#define FOR(i,a,b) 		for (int i=(a),_b=(b);i<=_b;i++)
#define DOW(i,a,b) 		for (int i=(a),_b=(b);i>=_b;i--)
#define TR(c,it) 		for (typeof((c).begin()) it=(c).begin(); it!=(c).end(); it++)
#define pb 				push_back
#define mp 				make_pair
#define sz(c) 			int((c).size())
#define all(c) 			(c).begin(), (c).end()

typedef long long 		LL;
typedef unsigned long long 	ULL;
typedef pair<int, int> 	ii;
typedef pair<ii, int> 	iii;
typedef vector<int> 	vi;
typedef vector<vi> 		vvi;
typedef vector<string> 	vs;
typedef vector<ii> 	    vii;
typedef vector<vii> 	vvii;

const int MAXN = 100005;

int n, l, r, a[MAXN], val[MAXN], f[MAXN];
LL s[MAXN];

void input() {
    scanf("%d %d %d", &n, &l, &r);
    s[0] = 0;
    FOR(i,1,n) {
        scanf("%d", &a[i]);
        s[i] = s[i - 1] + a[i];
    }
    
    sort(s,s + n + 1);
    val[0] = 1;
    FOR(i,1,n) if (s[i] == s[i - 1]) val[i] = val[i - 1];
    else val[i] = val[i - 1] + 1;
}

int search(LL num) {
    int le = 0, ri = n, mid, id = -1;
    while (le <= ri) {
        mid = (le + ri) / 2;
        if (s[mid] <= num) {
            id = mid;
            le = mid + 1;
        }
        else ri = mid - 1;
    }
    
    if (id == -1) return -1;
    return val[id];
}

void update(int pos) {
    while (pos <= MAXN) {
        f[pos] ++;
        pos += (pos & -pos);
    }
}

int get(int pos) {
    int t = 0;
    while (pos > 0) {
        t += f[pos];
        pos -= (pos & -pos);
    }
    
    return t;
}

void process() {
    LL sum = 0, res = 0;
    update(search(0));
    FOR(i,1,n) {
        sum += a[i];
        
        res += get(search(sum - l)) - get(search(sum - r - 1));
        update(search(sum));
    }
    
    printf("%lld\n", res);
}

void output() {
}

int main() {
    //freopen("c11seq.inp", "r", stdin);
    //freopen("c11seq.out", "w", stdout);

    input();
    process();
    output();

    return 0;
}
