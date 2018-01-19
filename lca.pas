const
  fi='LCA.inp';
  fo='LCA.out';
  maxN=1100;
  logn=trunc(ln(maxN)/ln(2));

var
   f1,f2:text;
   c:array[0..maxN,0..maxN] of boolean;
   m,n,s,t:longint;
   h:array[0..maxN] of longint;
   cha:array[0..maxN,0..logn] of longint;
   free:array[0..maxN] of boolean;


procedure  dfs(u,height:longint);
var
  d,i,v:longint;

begin
  free[u] := false ;
  h[u]:=height;

  for v:=1 to n do
    if c[u,v] and free[v] then
    begin
      cha[v,0]:=u;

      d:=1;

      for i:=1 to logn do
      begin
        d:=d*2;
        if d>h[u] then break;
        cha[v,i]:=cha[cha[v,i-1],i-1];
      end;

      dfs(v,height+1);
    end;


end;


procedure   xuly(u,v:longint);
var
  i,v1,u1:longint;

begin
  for i:=logn downto 0 do
  begin
    v1:=cha[v,i];
    if h[v1]>=h[u] then
    begin
      v:=v1;
    end;
  end;

  if u=v then
  begin
    writeln(f2,u);
    exit;
  end;

  for i:=logn downto 0 do
  begin
    v1:=cha[v,i];
    u1:=cha[u,i];
    if v1<>u1 then
    begin
      u:=u1;
      v:=v1;
    end;
  end;

  writeln(f2,cha[u,0]);
end;



procedure   read_f;
var
  i,a,b:longint;

begin

  assign(f1,fi); reset(f1);
  assign(f2,fo); rewrite(f2);
  readln(f1,n,m);
  fillchar(c, sizeof(c), false);
  for i:=1 to n-1 do
  begin
    readln(f1,a,b);
    c[a,b]:=true;
    c[b,a]:=true;
  end;

  fillchar(free,sizeof(free), true);
  dfs(1,1);

  for i:=1 to m do
  begin
    readln(f1,s,t);
    if h[s]<h[t] then xuly(s,t)
    else xuly(t,s);
  end;

  close(f1);
  close(f2);
end;






begin
  read_f;
end.
