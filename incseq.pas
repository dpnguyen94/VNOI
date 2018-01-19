uses math;
const
  inputfile = 'incseq.inp';
  outputfile = 'incseq.out';
  maxN = 100000 + 10;
var
  fi,fo: text;
  n,res,lmax: longint;
  a,d,tt,f,h,id: array[0..maxN] of longint;


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
  i: longint;
begin
  readln(fi,n);
  for i:= 1 to n do
  begin
    read(fi,a[i]);
    tt[i]:= i;
  end;
end;

procedure init;
var
  i,j,le,ri,mid: longint;
begin
  lmax:= 0;
  a[0]:= -maxlongint;
  for i:= 1 to n do
  begin
    le:= 0; ri:= lmax;
    while (le <= ri) do
    begin
      mid:= (le + ri) div 2;
      if (a[f[mid]] <= a[i]) then
      begin
        j:= mid;
        le:= mid + 1;
      end
      else ri:= mid - 1;
    end;
    d[i]:= j + 1;
    f[d[i]]:= i;

    if (d[i] > lmax) then lmax:= d[i];
  end;
end;

procedure swap(var x,y: longint);
var
  z: longint;
begin
  z:= x;
  x:= y;
  y:= z;
end;

procedure sort(le,ri: longint);
var
  i,j,t1,t2: longint;
begin
  if (le >= ri) then exit;
  i:= le; j:= ri;
  t1:= d[(i + j) div 2];
  t2:= tt[(i + j) div 2];

  repeat
    while (d[i] < t1) or ((d[i] = t1) and (tt[i] < t2)) do inc(i);
    while (d[j] > t1) or ((d[j] = t1) and (tt[j] > t2)) do dec(j);

    if (i <= j) then
    begin
      swap(d[i],d[j]);
      swap(tt[i],tt[j]);
      swap(a[i],a[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

function search(le,ri,pos: longint): boolean;
var
  tmp,mid: longint;
begin
  tmp:= -1;
  while (le <= ri) do
  begin
    mid:= (le + ri) div 2;
    if (tt[mid] > tt[pos]) then
    begin
      tmp:= mid;
      ri:= mid - 1;
    end
    else le:= mid + 1;
  end;

  if (tmp = -1) then exit(false);
  if (a[tmp] >= a[pos]) then exit(true);

  exit(false);
end;

procedure process;
var
  i,cnt: longint;
begin
  sort(1,n);

  cnt:= 0;
  for i:= 1 to n do
  begin
    if (d[i] <> d[i-1]) then
    begin
      inc(cnt);
      h[cnt]:= i;
    end;
    id[i]:= cnt;
  end;
  inc(cnt);
  h[cnt]:= n + 1;

  for i:= 1 to n do
    if search(h[id[i+1]],h[id[i]+2] - 1,i) then inc(res);

  cnt:= 0;
  for i:= 1 to n do
    if (d[i] = lmax) then inc(cnt);

  if (cnt = 1) then inc(res);
end;

procedure output;
begin
  writeln(fo,res);
end;


BEGIN
  openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
