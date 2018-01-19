program vmunch;
uses crt;
const   fi = '';
        fo = '';
        MAX = 100;
var     a: array[0..MAX+1,0..MAX+1] of 0..1;
        qx,qy: array[1..MAX*MAX] of integer;
        prex,prey: array[1..MAX,1..MAX] of integer;
        offx: array[1..4] of integer = (0,0,-1,1);
        offy: array[1..4] of integer = (-1,1,0,0);
        xb,yb,r,c,xe,ye: integer;
        f: text;

procedure enter;
var     i,j: integer;
        ch: char;
begin
        fillchar(a,sizeof(a),1);
        //
        assign(f,fi); reset(f);
        readln(f,r,c);
        for i:= 1 to r do begin
                for j:= 1 to c do begin
                        read(f,ch);
                        if (ch = '.') then a[i,j]:= 0;
                        if (ch = '*') then a[i,j]:= 1;
                        if (ch = 'C') then begin xb:= i; yb:= j; end;
                        if (ch = 'B') then begin
                                xe:= i; ye:= j;
                                a[i,j]:= 0;
                        end;
                end;
                readln(f);
        end;
        close(f);
end;

procedure BFS;
var     i,j,t,fi,la: longint;
begin
        //
        fi:= 1; la:= 0;
        inc(la);
        qx[la]:= xb; qy[la]:= yb;
        prex[xb,yb]:= 0; prey[xb,yb]:= 0;
        a[xb,yb]:= 1;
        //
        while (fi <= la) do begin
                i:= qx[fi]; j:= qy[fi]; inc(fi);
                //
                for t:= 1 to 4 do
                 if (a[i+offx[t],j+offy[t]] = 0) then begin
                        inc(la);
                        qx[la]:= i+offx[t]; qy[la]:= j+offy[t];
                        prex[qx[la],qy[la]]:= i; prey[qx[la],qy[la]]:= j;
                        a[qx[la],qy[la]]:= 1;
                        //
                        if (a[xe,ye] = 1) then exit;
                 end;
        end;
end;

procedure trace;
var     i,j,cnt,ti,tj: longint;
begin
        cnt:= 0;
        i:= xe; j:= ye;
        while (i > 0) and (j > 0) do begin
                inc(cnt);
                ti:= i; tj:= j;
                i:= prex[ti,tj]; j:= prey[ti,tj];
        end;
        //
        assign(f,fo); rewrite(f);
        writeln(f,cnt-1);
        close(f);
end;

begin
        enter;
        BFS;
        trace;
end.
