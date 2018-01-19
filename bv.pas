uses math;
const
  LM = 205;
//type
var
  m,n,cnt: longint;
  s: array[0..LM,0..LM] of char;
  c: array[0..LM,0..LM] of longint;
  a: array[0..105,0..105] of boolean;
  mark: array[0..105] of boolean;
  q,d: array[0..105] of longint;

  dx: array[1..4] of longint = (0,0,-1,1);
  dy: array[1..4] of longint = (-1,1,0,0);


procedure openfile;
begin
  assign(input,'bv.inp'); reset(input);
  assign(output,'bv.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,k: longint;
begin
  readln(m,n);
  for i:= 1 to m do
  begin
    for k:= 1 to n do read(s[i][k]);
    readln;
  end;
end;

procedure dfs(i,k: longint);
var
  t,u,v: longint;
begin
  c[i,k]:= cnt;
  for t:= 1 to 4 do
  begin
    u:= i + dx[t];
    v:= k + dy[t];

    if (u < 1) or (u > m) or (v < 1) or (v > n)
      or (c[u,v] <> 0) or (s[u,v] <> s[i,k]) then continue;
    dfs(u,v);
  end;
end;

procedure process;
var
  i,k,t,u,v,cap,dq,cq,dmin,res: longint;
begin
  for i:= 1 to m do
    for k:= 1 to n do if (c[i,k] = 0) then
    begin
      inc(cnt);
      dfs(i,k);
    end;

  //
  for i:= 1 to m do
    for k:= 1 to n do
    begin
      if (s[i,k] = 'A') then cap:= c[i,k];

      for t:= 1 to 4 do
      begin
        u:= i + dx[t];
        v:= k + dy[t];

        if (u < 1) or (u > m) or (v < 1) or (v > n) then
        begin
          mark[c[i,k]]:= true;
          continue;
        end;

        a[c[i,k],c[u,v]]:= true;
        a[c[u,v],c[i,k]]:= true;
      end;
    end;

    for i:= 1 to m do
    begin
      for k:= 1 to n do write(c[i,k]);
      writeln;
    end;

    //
    dq:= 1; cq:= 0;
    for i:= 1 to cnt do if mark[i] then
    begin
      inc(cq);
      q[cq]:= i;
      d[i]:= 1;
    end;

    while (dq <= cq) do
    begin
      i:= q[dq];
      inc(dq);

      if a[i,cap] then
      begin
        res:= d[i];
        break;
      end;

      for k:= 1 to cnt do if a[i,k] and (d[k] = 0) then
      begin
        inc(cq);
        q[cq]:= k;

        d[k]:= d[i] + 1;
      end;
    end;

    for i:= 1 to cnt do if a[i,cap] then inc(res);
    writeln(res - 1);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
