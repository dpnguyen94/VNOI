uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  maxK = 10 + 5;
  base = 1000000000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,k: longint;
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

procedure input;
begin
	readln(fi,n,k);
end;

procedure update(pos,val,num: longint);
begin
	while (val >= 1) do
  begin
		f[pos,val]:= (f[pos,val] + num) mod base;		
    val:= val - (val and (-val));
  end;
end;

function get(pos,val: longint): longint;
var
	temp: longint;
begin
	temp:= 0;
  while (val <= n) do
  begin
  	temp:= (temp + f[pos,val]) mod base;
    val:= val + (val and (-val));
  end;

  exit(temp);
end;

procedure process;
var
	i,j,x,temp,res: longint;
begin
	res:= 0;
	for i:= 1 to n do
  begin
		read(fi,x);

    update(1,x,1);
    for j:= 2 to k do
    begin
			temp:= get(j - 1,x + 1);
      update(j,x,temp);

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
