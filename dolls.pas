uses math;
const
  maxN = 100000 + 5;
//type
var
  ntest,test: longint;
  n,k: longint;
  a: array[1..maxN] of longint;
  free: array[1..maxN] of boolean;


procedure openfile;
begin
  assign(input,'dolls.inp'); reset(input);
  assign(output,'dolls.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i: longint;
begin
  readln(n,k);
  for i:= 1 to n do
    read(a[i]);
end;

procedure qsort(le,ri: longint);
var
  i,j,t,temp: longint;
begin
  if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= a[random(ri - le + 1) + le];

  repeat
    while (a[i] < t) do inc(i);
    while (a[j] > t) do dec(j);

    if (i <= j) then
    begin
      temp:= a[i];
      a[i]:= a[j];
      a[j]:= temp;

      inc(i);
      dec(j);
    end;
  until i > j;

  qsort(le,j);
  qsort(i,ri);
end;

function find(le,ri,val: longint): longint;
var
  j,mid: longint;
begin
  j:= -1;
  while (le <= ri) do
  begin
    mid:= (le + ri) div 2;

    if (a[mid] < val) then le:= mid + 1
    else
      if free[mid] then
      begin
        j:= mid;
        le:= mid + 1;
      end
      else
        ri:= mid - 1;
  end;

  exit(j);
end;

procedure process;
var
  i,j: longint;
  res: int64;
begin
  qsort(1,n);

  //
  fillchar(free,sizeof(free),true);

  res:= 0;
  for i:= n downto 1 do
  begin
    j:= find(i + 1, n, a[i] + k);

    if (j = -1) then res:= res + a[i]
    else free[j]:= false;
  end;

  writeln(res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  closefile;
END.
