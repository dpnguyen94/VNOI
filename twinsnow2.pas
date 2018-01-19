{$INLINE ON}
uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
type
	arr = array[0..5] of longint;
var
	fi,fo: text;
  n,cnt: longint;
  a: arr;
  b: array[1..12 * maxN,0..5] of longint;
  id: array[1..12 * maxN] of longint;


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
begin
	readln(fi,n);
end;

procedure output(t: longint);
begin
	if (t = 1) then writeln(fo,'Twin snowflakes found.')
  else writeln(fo,'No two snowflakes are alike.');
end;

procedure init;
var
	i,k,tt: longint;
begin
	cnt:= 0;
	for k:= 1 to n do
  begin
  	for i:= 0 to 5 do
    	read(fi,a[i]);

    for tt:= 0 to 5 do
    begin
    	inc(cnt);
      id[cnt]:= k;
    	for i:= 0 to 5 do
      	b[cnt,i]:= a[(i + tt) mod 6];
    end;

    for tt:= 0 to 5 do
    begin
    	inc(cnt);
      id[cnt]:= k;
      for i:= 0 to 5 do
				b[cnt,i]:= a[(5 - i + tt) mod 6];      	
    end;
  end;
end;

function compare(var x,y: arr): longint; inline;
var
	i: longint;
begin
	for i:= 0 to 5 do
  begin
  	if (x[i] > y[i]) then exit(1);
    if (x[i] < y[i]) then exit(-1);
  end;

  exit(0);
end;

procedure sort(le,ri: longint); inline;
var
	i,j,k: longint;
  t,z: arr;
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= b[(le + ri) div 2];

  repeat
		while (compare(b[i],t) = -1) do inc(i);
    while (compare(b[j],t) = 1) do dec(j);

    if (i <= j) then
    begin
    	z:= b[i]; b[i]:= b[j]; b[j]:= z;
      k:= id[i]; id[i]:= id[j]; id[j]:= k;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure process;
var
	i,j: longint;
begin
	sort(1,cnt);

	for i:= 1 to cnt - 1 do
  if (id[i] <> id[i+1])
  	and (compare(b[i],b[i+1]) = 0) then
  begin
  	output(1);
    exit;
  end;
  output(0);
end;


BEGIN
	openfile;
  input;
  init;
  process;
  closefile;
END.
