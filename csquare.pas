uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 250 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  a: int64;
  m,n: longint;
  b: array[1..LM] of longint;


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
	ch: char;
begin
	read(fi,a);
  read(fi,ch);

  n:= 0;
  while true do
  begin
  	read(fi,ch);
    if (ch = ' ') then break;

    inc(n);
    b[n]:= ord(ch) - ord('0');
  end;

  readln(fi,m);
end;

procedure process;
var
	i: longint;
	res,temp: int64;
begin
	res:= 1;

  while (n > 0) do
  begin
		if (b[n] mod 3 <> 0) then
    	for i:= 1 to b[n] mod 3 do
      	res:= (res * a) mod m;

    temp:= a;
    for i:= 1 to 2 do
    	a:= (a * temp) mod m;

    dec(n);
  end;

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
    process;
  end;
  closefile;
END.
