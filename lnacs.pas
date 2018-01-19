program lnacs;
uses math;
const   fi = '';
        fo = '';
var     a,b: array[1..1000] of integer;
        s: array[-1..1000,-1..1000] of integer;
        m,n: integer;
        f: text;

procedure nhap;
var     i: integer;
begin
        assign(f,fi); reset(f);
        readln(f,m,n);
        for i:= 1 to m do readln(f,a[i]);
        for i:= 1 to n do readln(f,b[i]);
        close(f);
end;

procedure xuli;
var     i,j: integer;
begin
		//
        for i:= 1 to m do
         	for j:= 1 to n do
          		if(a[i] = b[j]) then s[i,j]:= s[i-2,j-2]+1
          		else s[i,j]:= max(s[i-1,j],s[i,j-1]);

        //
        assign(f,fo); rewrite(f);
        writeln(f,s[m,n]);
        close(f);
end;


begin
        nhap;
        xuli;
end.
