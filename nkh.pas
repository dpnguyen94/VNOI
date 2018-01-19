program nkh;
uses crt;
const   fi = '';
        fo = '';
var     s1,s2,s: string;
        b: array[1..200] of 1..2;
        f: text;

procedure nhap;
begin
        assign(f,fi); reset(f);
        readln(f,s1);
        readln(f,s2);
        readln(f,s);
        close(f);
end;

procedure print;
var     i: integer;
begin
        assign(f,fo); rewrite(f);
        for i:= 1 to length(s) do write(f,b[i]);
        close(f);
        halt;
end;

procedure attempt(k,i,j: integer);
begin
        if (k > length(s)) then print;
        //
        if (s[k] = s1[i]) then begin
                b[k]:= 1;
                attempt(k+1,i+1,j);
        end;
        //
        if (s[k] = s2[j]) then begin
                b[k]:= 2;
                attempt(k+1,i,j+1);
        end;
end;

begin
        nhap;
        attempt(1,1,1);
end.
