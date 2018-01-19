uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 14;
  LM = maxN + 3;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  f: array[0..maxN,-LM..LM,-LM..LM] of longint;
  dx: array[1..6] of longint = (-1,-1,0,0,1,1);
  dy: array[1..6] of longint = (-1,0,-1,1,0,1);


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

procedure process;
var
	i,j,k,t,temp: longint;	
begin
	f[0,0,0]:= 1;
  temp:= maxN + 2;
	for k:= 1 to maxN do
  	for i:= -temp to temp do
    	for j:= -temp to temp do
      	for t:= 1 to 6 do
        	f[k,i,j]:= f[k,i,j] + f[k - 1,i + dx[t],j + dy[t]];
end;

procedure output;
begin
	writeln(fo,f[n,0,0]);
end;


BEGIN
	openfile;
  process;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    output;
  end;
  closefile;
END.
