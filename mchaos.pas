uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 100000 + 10;
  maxnode = maxN;
//type

var
	fi,fo: text;
  n: longint;
  s: array[1..maxN] of string[11];
	tt,a: array[1..maxN] of longint;
  f: array[1..maxnode] of longint;
  res: int64;


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
  	readln(fi,s[i]);
end;

procedure sort(le,ri: longint);
var
	i,j,z: longint;
  t,temp: string[11];
begin
	if (le >= ri) then exit;
  i:= le; j:= ri;
  t:= s[(le + ri) div 2];

  repeat
  	while (s[i] < t) do inc(i);
    while (s[j] > t) do dec(j);

    if (i <= j) then
    begin
    	temp:= s[i]; s[i]:= s[j]; s[j]:= temp;
      z:= tt[i]; tt[i]:= tt[j]; tt[j]:= z;

      inc(i);
      dec(j);
    end;
  until i > j;

  sort(le,j);
  sort(i,ri);
end;

procedure swap(var x,y: char);
var
	z: char;
begin
	z:= x;
  x:= y;
  y:= z;
end;

procedure reverse(var st: string);
var
	i,leng: longint;
begin
	leng:= length(st);
  for i:= 1 to leng div 2 do
  	swap(st[i],st[leng - i + 1]);
end;

procedure init;
var
	i: longint;
begin
	sort(1,n);

  //
  for i:= 1 to n do
  	reverse(s[i]);
  for i:= 1 to n do	
  	tt[i]:= i;

  //
  sort(1,n);
  for i:= 1 to n do
  	a[tt[i]]:= i;
end;

function get(x: longint): longint;
var
	temp: longint;
begin
	temp:= 0;
  while (x <= maxnode) do
  begin
		inc(temp,f[x]);
    x:= x + (x and (-x));
  end;

  exit(temp);
end;

procedure update(x: longint);
begin
	while (x >= 1) do
  begin
  	inc(f[x]);
    x:= x - (x and (-x));
  end;
end;

procedure process;
var
	i: longint;	
begin
	res:= 0;
	for i:= 1 to n do
  begin
  	res:= res + get(a[i] + 1);
    update(a[i]);
  end;
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
