uses math;
const
	inputfile = '';
  outputfile = '';
  maxval = 70000;
  maxpr = 7000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  m,n,npr: longint;
  p: array[1..maxval] of boolean;
  pr: array[1..maxpr] of longint;


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
	readln(fi,m,n);
end;

procedure init;
var
	i,j: longint;
begin
	fillchar(p,sizeof(p),true);
  for i:= 2 to maxval do
  	if p[i] then
    begin
    	j:= i + i;
      while (j <= maxval) do
      begin
      	p[j]:= false;
        j:= j + i;
      end;
    end;

  npr:= 0;
  for i:= 2 to maxval do
  	if p[i] then
    begin
    	inc(npr);
      pr[npr]:= i;
    end;
end;

function isprime(num: longint): boolean;
var
	i: longint;
begin
	if (num = 1) then exit(false);
  if (num = 2) then exit(true);

  for i:= 1 to npr do
  begin
  	if (pr[i] * pr[i] > num) then exit(true);
  	if (num mod pr[i] = 0) then exit(false);
  end;

	exit(true);
end;

procedure process;
var
	i: longint;
begin
	for i:= m to n do
  	if isprime(i) then writeln(fo,i);

  writeln(fo);
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
