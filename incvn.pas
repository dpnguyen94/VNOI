{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  maxK = 50 + 5;
  base = 5000000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,k: longint;
  a,tt,b: array[0..maxN] of longint;
  f: array[1..maxK,1..maxN] of longint;


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

procedure sort(le,ri: longint); inline;
var
	i,j,t,z: longint;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= a[(le + ri) div 2];

  repeat
  	while (a[i] < t) do inc(i);
    while (a[j] > t) do dec(j);

    if (i <= j) then
    begin
    	z:= a[i]; a[i]:= a[j]; a[j]:= z;
      z:= tt[i]; tt[i]:= tt[j]; tt[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure input;
var
	i,cnt: longint;
begin
	readln(fi,n,k);
  for i:= 1 to n do
  begin
  	readln(fi,a[i]);
    tt[i]:= i;
  end;

  //
  sort(1,n);

  //
  a[0]:= -1;
  cnt:= 0;
  for i:= 1 to n do
  	if (a[i] <> a[i - 1]) then
    begin
    	inc(cnt);
      b[tt[i]]:= cnt;
    end
    else b[tt[i]]:= cnt;
end;

procedure update(pos,val,num: longint); inline;
begin
	while (val <= maxN) do
  begin
		f[pos,val]:= (f[pos,val] + num) mod base;
    val:= val + (val and (-val));
  end;
end;

function get(pos,val: longint): longint; inline;
var
	temp: longint;
begin
	temp:= 0;
	while (val >= 1) do
  begin
  	temp:= (temp + f[pos,val]) mod base;
    val:= val - (val and (-val));
  end;

  exit(temp);
end;

procedure process;
var
	i,j,temp,res: longint;
begin
	res:= 0;
	for i:= 1 to n do
  begin
  	update(1,b[i],1);
    if (k = 1) then inc(res);

    for j:= 2 to k do
    begin
    	temp:= get(j - 1,b[i] - 1);
      update(j,b[i],temp);

      if (j = k) then
      	res:= (res + temp) mod base;
    end;
  end;

  writeln(fo,res);
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
