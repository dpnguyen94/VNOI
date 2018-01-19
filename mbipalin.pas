uses math;
const
	inputfile = '';
  outputfile = '';
  maxM = 1000000;
//type

var
	fi,fo: text;
  n,m,leng: longint;
  base: int64;
  a: array[1..10] of longint;
  cnt1,cnt2: array[0..maxM] of longint;


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
	readln(fi,n,m);
  n:= n div 2;

  base:= 1;
  for i:= 1 to n do
  	base:= (base * 10) mod m;
end;

procedure solve;
var
	i,j,t: longint;
  temp: int64;
begin
	if (n mod 2 = 0) then t:= leng
  else t:= leng - 1;

	j:= leng;
  for i:= t downto 1 do
  begin
		inc(j);
    a[j]:= a[i];
  end;
	
  temp:= 0;
  for i:= 1 to j do
  	temp:= temp * 10 + a[i];

  t:= temp mod m;
  if (a[1] > 0) then inc(cnt1[t]);
  inc(cnt2[t]);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > leng) then
  begin
  	solve;
    exit;
  end;	

  for j:= 0 to 9 do
  begin
		a[i]:= j;
		attempt(i + 1);
  end;
end;

procedure process;
var	
	i,j: longint;
  res: int64;
begin
	leng:= n div 2;
  if (n mod 2 = 1) then inc(leng);
  attempt(1);

  //
  res:= 0;
	for i:= 0 to m - 1 do
  begin
  	j:= (i * base) mod m;
		j:= (m - j) mod m;
		res:= res + int64(cnt1[i]) * cnt2[j];
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
