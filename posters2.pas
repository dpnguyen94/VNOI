uses math;
const
  inputfile = '';
  outputfile = '';
  maxN = 40000 + 10;
  maxnode = 8 * maxN;
//type
var
  fi,fo: text;
  ntest,test: longint;
  n,k,cnt: longint;
  a,tt,num: array[0..2 * maxN] of longint;

  color: array[0..maxN] of boolean;
  numx,numy: array[0..2 * maxN] of longint;
  IT: array[1..maxnode] of longint;


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
  i,x,y: longint;
begin
  readln(fi,n);
  cnt:= 0;
  for i:= 1 to n do
  begin
    readln(fi,x,y);
    inc(cnt);
    a[cnt]:= x;
    num[cnt]:= 1;
    tt[cnt]:= i;

    inc(cnt);
    a[cnt]:= y;
    num[cnt]:= 2;
    tt[cnt]:= i;
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
  i,j,t: longint;
begin
  if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= a[(le + ri) div 2];

  repeat
    while (a[i] < t) do inc(i);
    while (a[j] > t) do dec(j);

    if (i <= j) then
    begin
      swap(a[i],a[j]);
      swap(tt[i],tt[j]);
      swap(num[i],num[j]);

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure init;
var
  i: longint;
begin
  sort(1,2 * n);

  //
  cnt:= 0;
  for i:= 1 to 2 * n do
  begin
    if (a[i] <> a[i - 1]) then inc(cnt);

    if (num[i] = 1) then numx[tt[i]]:= cnt
    else numy[tt[i]]:= cnt;
  end;
end;

procedure update(nd,x,y,u,v: longint);
var
	mid: longint;
begin
	if (u = x) and (v = y) then
  begin
  	IT[nd]:= k;
    exit;
  end;

  mid:= (x + y) div 2;
  if (u <= mid) then update(2 * nd,x,mid,u,min(v,mid));
  if (v >= mid + 1) then update(2 * nd + 1,mid + 1,y,max(u,mid + 1),v);
end;

procedure getnum(nd,x,y: longint);
var
	mid: longint;
begin
	if (x = y) then
  begin
  	color[IT[nd]]:= true;
    exit;
  end;

  if (IT[nd] > IT[2 * nd]) then IT[2 * nd]:= IT[nd];
  if (IT[nd] > IT[2 * nd + 1]) then IT[2 * nd + 1]:= IT[nd];
  mid:= (x + y) div 2;
  getnum(2 * nd,x,mid);
  getnum(2 * nd + 1,mid + 1,y);
end;

procedure process;
var
  i,res: longint;
begin
	fillchar(IT,sizeof(IT),0);
  for i:= 1 to n do
  begin
    k:= i;
    update(1,1,cnt,numx[i],numy[i]);
  end;

  fillchar(color,sizeof(color),false);
  getnum(1,1,cnt);

  //
  res:= 0;
  for i:= 1 to maxN do
    if color[i] then inc(res);

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
  openfile;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    init;
    process;
    output;
  end;
  closefile;
END.
