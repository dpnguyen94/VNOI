uses math;
const
  inputfile = 'knot.inp';
  outputfile = 'knot.out';
  maxN = 500 + 10;
type
  arr = array[0..maxN] of longint;
var
  fi,fo: text;
  n,cnt: longint;
  x,y,h: array[1..maxN] of longint;
  a: array[1..2 * maxN] of longint;
  vs: array[1..maxN] of boolean;
  ds,b,f: array[0..maxN] of longint;


procedure openfile;
begin
  assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
  close(fi);
  close(fo);
end;

procedure input;
var
  i,u,v: longint;
begin
  fillchar(h,sizeof(h),0);

  for i:= 1 to n do
  begin
    readln(fi,x[i],y[i]);
    inc(h[x[i]]);
    inc(h[y[i]]);
  end;

  for i:= 2 to n+1 do
    h[i]:= h[i-1] + h[i];

  for i:= 1 to n do
  begin
    u:= x[i];
    v:= y[i];

    a[h[u]]:= v;
    a[h[v]]:= u;

    dec(h[u]);
    dec(h[v]);
  end;

  fillchar(vs,sizeof(vs),false);
end;

procedure dfs(u: longint);
var
  i,v: longint;
begin
  inc(cnt);
  ds[cnt]:= u;
  vs[u]:= true;

  for i:= h[u] + 1 to h[u+1] do
  begin
    v:= a[i];
    if not vs[v] then dfs(v);
  end;
end;

function find(x: arr): longint;
var
  i,j,k,le,ri,mid: longint;
begin
  fillchar(f,sizeof(f),0);
  for i:= n downto 1 do
    x[i]:= x[i-1];

  //
  x[0]:= -maxlongint;
  k:= 0;
  for i:= 1 to n do
  begin
    le:= 0; ri:= k;
    while (le <= ri) do
    begin
      mid:= (le + ri) div 2;
      if (x[f[mid]] <= x[i]) then
      begin
        j:= mid;
        le:= mid + 1;
      end
      else ri:= mid - 1;
    end;
    f[j + 1]:= i;
    k:= max(k,j + 1);
  end;

  exit(k);
end;

procedure process;
var
  i,tt,res: longint;
begin
  cnt:= 0;
  dfs(1);
  if (cnt < n) then
  begin
  	writeln(fo,-1);
    exit;
  end;

  //
  for i:= 0 to n-1 do
    ds[i]:= ds[i+1];

  res:= 0;
  for tt:= 0 to n-1 do
  begin
    for i:= 0 to n-1 do
      b[i]:= ds[(i + tt) mod n];
    res:= max(res,find(b));

    for i:= 0 to n-1 do
      b[i]:= ds[(n - 1 - i + tt) mod n];
    res:= max(res,find(b));
  end;
  writeln(fo,n - res);
end;


BEGIN
  openfile;
  while TRUE do
  begin
    readln(fi,n);
    if (n = 0) then break;
    input;
    process;
  end;
  closefile;
END.
