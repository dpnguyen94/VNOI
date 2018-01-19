program movies;
uses crt;
var     fi,fo: text;
        n,m,cnt: int64;
        s: string;
        x,y,f,h: array[1..50] of longint;

procedure input;
var     i: longint;
begin
        readln(fi,n);
        readln(fi,m);

        readln(fi,s);
        cnt:= 0;
        while TRUE do begin
                readln(fi,s);
                if (s = '>>') then break;
                inc(cnt);
                val(s,x[cnt],i);
        end;

        cnt:= 0;
        readln(fi,s);
        while TRUE do begin
                readln(fi,s);
                if (s = '>>') then break;
                inc(cnt);
                val(s,y[cnt],i);
        end;
end;

procedure swap(var x,y: longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure process;
var     i,j,t: longint;
        res: int64;
begin
        //sort;
        for i:= 1 to cnt-1 do
         for j:= i+1 to cnt do
          if (x[i] > x[j]) or ((x[i] = x[j]) and (y[i] > y[j]))  then begin
                swap(x[i],x[j]);
                swap(y[i],y[j]);
          end;
        //
        t:= 1;
        f[t]:= 1;
        for i:= 2 to cnt do begin
                if (x[i] > x[i-1]) then begin
                        h[t]:= i-1;
                        inc(t);
                        f[t]:= i;
                end;
        end;
        h[t]:= cnt;

        //
        res:= n*(m-1);
        cnt:= 0;
        for i:= 1 to t do begin
                if (y[f[i]] > 1) and (y[f[i]] < m) then inc(cnt,2);
                if ( (y[f[i]] = 1) and (y[f[i]] < m) )
                 or ( (y[f[i]] = m) and (y[f[i]] > 1) ) then inc(cnt);

                for j:= f[i]+1 to h[i] do begin
                        if (y[j] - y[j-1] > 1) then begin
                                if (y[j] < m) then inc(cnt,2)
                                else inc(cnt);
                        end
                        else begin
                                if (y[j] < m) then inc(cnt);
                        end;
                end;
        end;
        //
        dec(res,cnt);
        writeln(fo,res);
end;


begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        while TRUE do begin
                readln(fi,s);
                if (s = '[END]') then break;
                input;
                process;
                readln(fi);
        end;
        //
        close(fi);
        close(fo);
end.
