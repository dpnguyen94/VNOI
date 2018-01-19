program qa1;
uses crt;
var     fi,fo: text;
        m,k,cnt: longint;
        a: array[1..100] of longint;
        vs: array[1..9] of boolean;
        res: int64;

procedure print;
var     i: longint;
begin
        for i:= 1 to m do write(fo,a[i]);
        writeln(fo);
end;

procedure attempt(i: longint);
var     j,cnt1: longint;
        save: boolean;
begin
        if (i > m) then begin
                inc(res);
                exit;
        end;
        //
        for j:= 1 to 9 do begin
                a[i]:= j;
                save:= vs[j];
                cnt1:= cnt;
                if not vs[j] then inc(cnt);
                vs[j]:= true;
                if (cnt <= k) then attempt(i+1);
                vs[j]:= save;
                cnt:= cnt1;
        end;
end;



begin
        assign(fi,'qa1.inp'); reset(fi);
        assign(fo,'qa2.out'); rewrite(fo);
        //
        readln(fi,m,k);
        fillchar(vs,sizeof(vs),false);
        cnt:= 0;
        res:= 0;
        attempt(1);
        writeln(fo,res);
        //
        close(fi);
        close(fo);

end.
