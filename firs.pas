program firs;
uses crt;
const   MAX_N = 100000;
var     a,sh: array[0..MAX_N+1] of longint;
        fi,fo: text;
        n: longint;

procedure input;
var     i: longint;
begin
        readln(fi,n);
        for i:= 1 to n do begin
                read(fi,a[i]);
                sh[i]:= i;
        end;
end;

procedure qsort(l,r: longint);
var     i,j,z,t: longint;
begin
        if l>=r then exit;
        i:= l; j:=r;
        t:= a[(l+r) div 2];
        repeat
                while (a[i] < t) do inc(i);
                while (a[j] > t) do dec(j);

                if i <= j then
				begin
					if i < j then
                         if (a[i] > a[j]) or (sh[i] > sh[j]) then begin
                                z:= a[i]; a[i]:= a[j]; a[j]:= z;
                                z:= sh[i]; sh[i]:= sh[j]; sh[j]:= z;
                         end;
                	inc(i); dec(j);
                end;
        until i >= j;

        qsort(l,j);
        qsort(i,r);
end;

procedure process;
var     i,cnt: longint;
        j: -1..1;
begin
        qsort(1,n);

        cnt:= 0;
        for i:= 1 to n do
         if a[sh[i]] > 0 then begin
                for j:= -1 to 1 do a[sh[i]+j]:= 0;
                inc(cnt);
         end;

        writeln(fo,cnt);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        process;
        //
        close(fi);
        close(fo);
end.
