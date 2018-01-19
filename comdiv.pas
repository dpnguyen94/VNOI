uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000 + 10;
  maxpr = 200;
//type

var
	fi,fo: text;
  ntest,test: longint;
  a,b,npr,cnt: longint;
  p: array[1..LM] of boolean;
  pr: array[1..maxpr] of longint;
  num: array[1..10] of longint;
	

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
	readln(fi,a,b);
end;

procedure init;
var
	i,j: longint;
begin
	fillchar(p,sizeof(p),true);

  for i:= 2 to LM do
  	if p[i] then
    begin
    	j:= i + i;
      while (j <= LM) do
      begin
      	p[j]:= false;
				j:= j + i;
      end;
    end;

  npr:= 0;
  for i:= 2 to LM do
  	if p[i] then
    begin
    	inc(npr);
      pr[npr]:= i;
    end;
end;

procedure process;
var
	i,r,g: longint;
begin
	while (b > 0) do
  begin
  	r:= a mod b;
    a:= b;
    b:= r;
  end;

  g:= a;
  cnt:= 0;
  for i:= 1 to npr do
  begin
  	if (g = 1) then break;

  	if (g mod pr[i] = 0) then
    begin
			inc(cnt);
      num[cnt]:= 0;

      while (g mod pr[i] = 0) do
      begin
      	g:= g div pr[i];
        inc(num[cnt]);
      end;
    end;
  end;

  if (g <> 1) then
  begin
  	inc(cnt);
    num[cnt]:= 1;
  end;
end;

procedure output;
var	
	i: longint;
	res: int64;
begin
	res:= 1;
	for i:= 1 to cnt do
  	res:= res * (num[i] + 1);

  writeln(fo,res);
end;


BEGIN
	openfile;
  init;
  readln(fi,ntest);
  for test:= 1 to ntest do
  begin
  	input;
    process;
    output;
  end;
  closefile;
END.
