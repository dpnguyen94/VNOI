program nkpalin;
uses crt;
var     s: ansistring;
        f: array[0..2000,0..2000] of integer;
        c: array[0..2000,0..2000] of -1..1;
        fi,fo: text;

procedure process;
var     n,i,j,x,y: integer;
        ch: char;
        st: array[1..2000] of integer;
begin
        n:= length(s);
        fillchar(f,sizeof(f),0);
        for i:= 1 to n do begin
                f[i,i]:= 1;
                c[i,i]:= 0;
        end;

        for j:= 2 to n do
         for i:= j-1 downto 1 do
          if (s[j] = s[i]) then begin
                f[i,j]:= f[i+1,j-1] + 2;
                c[i,j]:= 0;
          end
          else
           if (f[i+1,j] > f[i,j-1]) then begin
                f[i,j]:= f[i+1,j];
                c[i,j]:= 1;
           end
           else begin
                f[i,j]:= f[i,j-1];
                c[i,j]:= -1;
           end;
        //

        //trace;
        x:= 1; y:= f[1,n];
        i:= 1; j:= n;
        while (i <= j) do begin
                if (c[i,j] = 0) then begin
                        st[x]:= ord(s[i]); st[y]:= ord(s[j]);
                        inc(x); dec(y);
                        inc(i); dec(j);
                        continue;
                end;
                //
                if (c[i,j] = 1) then begin inc(i); continue; end;
                if (c[i,j] = -1) then begin dec(j); continue; end;
        end;

        for i:= 1 to f[1,n] do write(fo,char(st[i]));
        writeln(fo);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,s);
        process;
        //
        close(fi);
        close(fo);

end.
