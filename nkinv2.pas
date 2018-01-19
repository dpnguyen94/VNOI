uses math;
const
	inputfile = 'nkinv.inp';
  outputfile = 'nkinv.out';
  maxN = 60000 + 10;
  maxnode = maxN;
//type

var
	fi,fo: text;
  n,res: longint;
  f: array[1..maxnode] of longint;


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
	while (x > 0) do
  begin
  	inc(f[x]);
    x:= x - (x and (-x));
  end;
end;

procedure process;
var
	i,num: longint;
begin
	res:= 0;
	for i:= 1 to n do
  begin
  	readln(fi,num);
    inc(res,get(num + 1));
    update(num);
  end;
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
