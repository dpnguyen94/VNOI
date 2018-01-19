{
ID: ndchiph1
PROG: calfflac
LANG: PASCAL
}
uses math;
var     fi,fo: text;
        s,st: ansistring;
        c: array[0..20001] of char;
        id: array[0..20001] of integer;
        nl: array[1..20000] of boolean;
        cnt,len,longest: longint;


procedure input;
var     i: longint;
begin
        s:= '';
        cnt:= 0;
        fillchar(nl,sizeof(nl),false);
        while not eof(fi) do begin
                inc(cnt);
                readln(fi,st);
                //line[len]:= length(st);
                s:= s+st;
                nl[length(s)]:= true;
        end;

        c[0]:= '/'; c[20001]:= '\';
        len:= 0;
        for i:= 1 to length(s) do
         if ((s[i] >= 'A') and (s[i] <= 'Z'))
          or ((s[i] >= 'a') and (s[i] <= 'z')) then begin
                inc(len);
                c[len]:= char( ord(s[i]) or 32);
                id[len]:= i;
          end;

        {
        for i:=0 to cnt do begin
                if (line[i] > i1) begin
                        i1:=i1-line[i];
                        j1:=j1-line[i];
                        continue;
                end;

                if (line[i] > j1) begin
                        writeln(copy(s,i1,line[i]-i1+1));
                        i1:=0;
                        j1:=j1-line[i];
                end else begin
                        writeln(copy(s,i1,j1-i1+1));
                        break;
                end;
        end;
        }
end;


procedure process;
var     i,j,t,i1,j1,max,i2,j2: longint;
begin
        longest:= 0;
        i1:= maxlongint;
        j1:= maxlongint;
        for t:= 1 to len do begin
                max:= 1;
                i:= t-1; j:= t+1;
                while (c[i] = c[j]) do begin
                        dec(i);
                        inc(j);
                        inc(max,2);
                        if (i=0) or (j=len+1) then break;
                end;
                if (max > longest) then begin
                        longest:= max;
                        i1:= id[i+1];
                        j1:= id[j-1];
                end;

                j:= t;
                i:= t-1;
                max:= 0;
                while (c[i] = c[j]) do begin
                        dec(i);
                        inc(j);
                        inc(max,2);
                        if (i=0) or (j=len+1) then break;
                end;
                if (max > longest) then begin
                        longest:= max;
                        i1:= id[i+1];
                        j1:= id[j-1];
                end;
        end;

        //
        writeln(fo,longest);
        for i:= i1 to j1 do begin
                write(fo, s[i]);
                if (nl[i]) then writeln(fo);
        end;
        if (not nl[j1]) then writeln(fo);
end;


begin
        assign(fi,'calfflac.in'); reset(fi);
        assign(fo,'calfflac.out');; rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
