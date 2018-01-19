#include <cstdio>
#include <vector>
#include <string>
using namespace std;
 
typedef long long ll;
typedef vector<ll> VLL;
const ll BASE=1000000000;
const VLL ZERO=VLL(0);
const VLL ONE=VLL(1,1);
 
VLL operator*(VLL a,int x) {
	ll c=0;
	for(int i=0;c!=0||i<a.size();++i) {
		if(i<a.size()) c+=a[i]*x;
		if(i<a.size()) a[i]=c%BASE; else a.push_back(c%BASE); c/=BASE;
	}
	return a;
}
VLL operator+(VLL a,const VLL &b) {
	ll c=0;
	for(int i=0;c!=0||i<b.size();++i) {
		if(i<a.size()) c+=a[i];
		if(i<b.size()) c+=b[i];
		if(i<a.size()) a[i]=c%BASE; else a.push_back(c%BASE); c/=BASE;
	}
	return a;
}
VLL operator-(VLL a,const VLL &b) {
	ll c=0;
	for(int i=0;c!=0||i<b.size();++i) {
		if(i<a.size()) c+=a[i];
		if(i<b.size()) c-=b[i];
		assert(i<a.size());
		if(c<0) a[i]=c+BASE,c=-1; else a[i]=c,c=0;
	}
	while(a.size()>0&&a.back()==0) a.pop_back();
	return a;
}
bool lowerequal(const VLL &a,const VLL &b) {
	if(a.size()!=b.size()) return a.size()<b.size();
	for(int i=((int)a.size())-1;i>=0;--i) if(a[i]!=b[i]) return a[i]<b[i];
	return true;
}
 
void print(const VLL &a) {
	if(a.size()==0) { printf("0"); return; }
	printf("%lld",a[a.size()-1]); for(int i=((int)a.size())-2;i>=0;--i) printf("%09lld",a[i]);
}
 
int n;
char s[99];
 
int val(char c) { return isdigit(c)?c-'0':10+c-'A'; }
 
void inc(string &s) {
	for(int i=s.size()-1;i>=0;--i) {
		s[i]=s[i]=='9'?'A':s[i]=='F'?'0':s[i]+1;
		if(s[i]!='0') return;
	}
	s=string("1")+s;
}
 
bool test(string cur,int offset) {
	while(offset<n) {
		for(int i=0;offset<n&&i<cur.size();++i) {
			if(offset>=0&&s[offset]!=cur[i]) return false;
			++offset;
		}
		inc(cur);
	}
	return true;
}
 
VLL get(const string &s) {
	VLL ret=ZERO;
	{
		VLL base=ONE*15;
		for(int len=1;len<s.size();++len) {
			ret=ret+base*len;
			base=base*16;
		}
	}
	{
		VLL base=ONE;
		for(int i=s.size()-1;i>=0;--i) {
			ret=ret+base*(val(s[i])-(i==0?1:0))*s.size();
			base=base*16;
		}
	}
	return ret;	
}
 
vector<VLL> sols;
 
bool sol(string cur,int offset) {
	VLL now=get(cur)+VLL(1,offset);
	if(sols.size()==0) { sols.push_back(now); return true; }
	if(now==sols[0]) return true;
	if(lowerequal(now,sols[0])) {
		swap(now,sols[0]);
	}
	if(!lowerequal(sols[0]+VLL(1,n),now)) return true;
	if(sols.size()==1) {
		sols.push_back(now);
		return true;
	}
	if(now==sols[1]) return true;
	if(lowerequal(now,sols[1])) {
		sols[1]=now;
		return true;
	}
	return false;
}
 
int main() {
	scanf("%s",s); n=strlen(s);
	sols.clear();
	for(int len=1;sols.size()<2;++len) {
		for(int offset=0;offset<len;++offset) {
			{
				string pattern(len,'?');
				for(int i=len-1;i>=0;--i) pattern[i] = i-offset>=0&&i-offset<n ? s[i-offset] : len+i-offset<n ? s[len+i-offset] : '?';
				string cur=pattern; for(int i=len-1;i>=0;--i) if(pattern[i]=='?') cur[i]=i==0?'1':'0';
				while(cur[0]!='0') {
					if(test(cur,-offset)&&!sol(cur,offset)) break;
					bool found=false;
					for(int i=len-1;i>=0;--i) if(pattern[i]=='?') {
						cur[i]=cur[i]=='9'?'A':cur[i]=='F'?'0':cur[i]+1;
						if(cur[i]!='0') { found=true; break; }
					}
					if(!found) break;
				}
			}
			{
				string cur(len,'F');
				if(test(cur,-offset)) sol(cur,offset);
			}
		}
	}
	VLL ret=sols[1]-(sols[0]+VLL(1,n));
	print(ret); puts("");
}