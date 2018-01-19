program mcityhal;
uses crt;
const   fi = '';
        fo = '';
var     a: array[0..201,0..201] of 0..1;
        s: array[1..200] of word;
        m,n: 1..200;
        f: text;

procedure nhap;
var     i,j: 1..200;
        c: char;
begin
        assign(f,fi); reset(f);
        readln(f,m,n);
        for i:= 1 to m do begin
                for j:= 1 to n do begin
                        read(f,c);
                        val(c,a[i,j]);
                end;
                readln(f);
        end;
        close(f);
end;

procedure xuli;
var     i,j,t,l: 0..200;
begin
        for i:= 1 to n do begin
                a[0,i]:= 1;
                a[m+1,i]:= 1;
        end;
        fillchar(s,sizeof(s),0);
        //
        for j:= 1 to n do
         for i:= 0 to m do begin
                if (a[i,j] = 1) and (a[i+1,j] = 0) then begin
                        t:= i+1; l:= 0;
                        while (a[t,j] = 0) do begin
                                inc(l);
                                inc(t);
                        end;
                        inc(s[l]);
                end;
         end;
         //
         assign(f,fo); rewrite(f);
         for i:= 1 to m do if s[i] <> 0 then writeln(f,i,' ',s[i]);
         close(f);
end;

begin
        nhap;
        xuli;
end.