program ctf;
uses crt;
var     fi,fo: text;
        num_test,t: integer;
        f9: array[0..5] of longint = (1,9,99,999,9999,99999);
        f10: array[0..5] of longint = (1,10,100,1000,10000,100000);
        s: string;
        x,y: int64;

function gcd(a,b: int64): int64;
begin
        if (a = 0) or (b = 0) then exit(a+b);
        if (a > b) then gcd:= gcd(a mod b,b)
        else gcd:= gcd(a, b mod a);
end;


procedure sum(a,b,c,d: int64);
var     tt: int64;
begin
        x:= a*d+b*c;
        y:= b*d;
        tt:= gcd(x,y);
        x:= x div tt;
        y:= y div tt;
end;

procedure process;
var     len,i,j,k,code: integer;
        a,b,c,d: int64;
begin
        len:= length(s);
        for i:= 1 to len do
         if (s[i] = '.') then begin
                j:= i;
                break;
         end;
        for i:= j+1 to len do
         if (s[i] = '(') then begin
                k:= i;
                break;
         end;

        //find(a,b);
        if (s[k-1]  = '.') then begin
                b:= 1;
                val(copy(s,1,j-1),a,code);
        end
        else begin
                b:= f10[k-j-1];
                val(copy(s,1,j-1)+copy(s,j+1,k-j-1),a,code);
        end;

        //find(c,d);
        val(copy(s,k+1,len-k-1),c,code);
        d:= f9[len-k-1]*f10[k-j-1];

        sum(a,b,c,d);
        writeln(fo,x,'/',y);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,num_test);
        for t:= 1 to num_test do begin
                readln(fi,s);
                process;
        end;
        //
        close(fi);
        close(fo);
end.
