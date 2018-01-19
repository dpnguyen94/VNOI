uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  m,n,k: longint;
  a: array[1..LM,1..LM] of boolean;
  f: array[1..LM] of longint;


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
	i,u,v: longint;
begin
	readln(fi,n,m,k);
	fillchar(a,sizeof(a),false);
  for i:= 1 to k do
  begin
  	readln(fi,u,v);
    a[u,v]:= true;
  end;
end;

function get(num: longint): longint;
var
	temp: longint;
begin
	temp:= 0;
  while (num <= LM) do
  begin
		temp:= temp + f[num];
    num:= num + (num and (-num));
  end;

  exit(temp);
end;

procedure update(num: longint);
begin
	while (num >= 1) do
  begin
  	inc(f[num]);
    num:= num - (num and (-num));
  end;
end;

procedure process;
var
	i,j: longint;
  res: int64;
begin
  fillchar(f,sizeof(f),0);
  res:= 0;
  for i:= 1 to n do
		for j:= 1 to m do
    	if a[i,j] then
      begin
      	res:= res + get(j + 1);

        update(j);
      end;

  writeln(fo,'Test case ',test,': ',res);
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
