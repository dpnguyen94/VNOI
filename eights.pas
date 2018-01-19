uses math;
const
	inputfile = '';
  outputfile = '';
//type

var
	fi,fo: text;
  ntest,test: longint;
  k: int64;
  a: array[0..3] of longint = (942,192,442,692);
  f,p: array[1..13] of int64;


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
	readln(fi,k);
end;

procedure init;
var
  i: longint;
begin
  f[1]:= 36;
  p[1]:= 1;

  for i:= 2 to 12 do
  begin
  	f[i]:= f[i - 1] * 10;
    p[i]:= p[i - 1] * 10;
  end;
end;

procedure process;
var
	i: longint;
  head,tail,temp: int64;
begin
	if (k <= 4) then
  begin
  	writeln(fo,a[k mod 4]);
    exit;
  end;

	k:= k - 4;
	i:= 1;
	while (k >= f[i]) do
  begin
		k:= k - f[i];
		inc(i);
  end;

  if (k = 0) then
  begin
  	dec(i);
    k:= f[i];
  end;

	tail:= a[k mod 4];
  temp:= k div 4;
  if (k mod 4 <> 0) then inc(temp);
	head:= p[i] + temp - 1;

  writeln(fo,head * 1000 + tail);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  init;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    process;
  end;
  closefile;
END.
