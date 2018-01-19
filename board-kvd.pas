uses math;

const
        fin= 'board.in0';
        fout='board.ou0';
        max=500 + 10;
        inf=1000000000;

        dx:array[1..2] of longint=(1,0);
        dy:array[1..2] of longint=(0,1);

var
        fi,fo:text;
        m,n:longint;
        k:int64;
        s:array[0..max]of ansistring;

        dp:array[0..max,0..max]of int64;

        res:ansistring;

procedure readfile;
var
        i:longint;
begin
        assign(fi,fin);reset(fi);
        assign(fo,fout);rewrite(fo);

        readln(fi,m,n,k);

        for i:=1 to m do
         readln(fi,s[i]);
end;

function  cal(i,j:longint):int64;
var
        p:int64;
        ik,u,v:longint;
begin
        if dp[i,j] <> -1 then exit(dp[i,j]);

        if s[i,j] = '#' then
         begin
                dp[i,j]:=0;
                exit(0);
         end;

        if(i = m)and(j = n)then
         begin
                dp[i,j]:=1;
                exit(1);
         end;

        p:=0;

        for ik:=1 to 2 do
         begin
                u:=i + dx[ik];
                v:=j + dy[ik];

                if(u <= m)and(v <= n)then
                 p:=p + cal(u,v);
         end;

        p:=math.min(p,inf);

        dp[i,j]:=p;
        exit(p);
end;

procedure trace(i,j:longint);
var
        ik,u,v:longint;
begin
        for ik:=1 to 2 do
         begin
                u:=i + dx[ik];
                v:=j + dy[ik];

                if(u <= m) and (v <= n)then
                 if ik = 1 then
                  begin
                        if dp[u,v] < k then
                         dec(k,dp[u,v])
                        else
                         begin
                                res:=res + 'D';
                                trace(u,v);
                                exit;
                         end;
                  end
                 else
                  begin
                        res:=res + 'R';
                        trace(u,v);
                        exit;
                  end;
         end;
end;

procedure solve;
begin
        fillchar(dp,sizeof(dp),$ff);
        //writeln(fo,cal(1,1));
        if k > cal(1,1) then
         begin
                writeln(fo,'impossible');
                exit;
         end;

        res:='';
        trace(1,1);
        writeln(fo,res);
end;

procedure closefile;
begin
        close(fi);
        close(fo);
end;

BEGIN
        readfile;
        solve;
        closefile;
END.
