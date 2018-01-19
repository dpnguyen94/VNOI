program demtau;
var     a: array[0..1001,0..1001] of 0..1;
        fi,fo: text;
        cnt: longint;
        i,j,m,n: integer;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        fillchar(a,sizeof(a),0);
        cnt:= 0;
        //
        readln(fi,m,n);
        for i:= 1 to m do
         for j:= 1 to n do begin
                read(fi,a[i,j]);
                if (a[i,j] = 1) and (a[i-1,j] = 0) and (a[i,j-1] = 0) then inc(cnt);
         end;
        writeln(fo,cnt);
        //
        close(fi);
        close(fo);


end.