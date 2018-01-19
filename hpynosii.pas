uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  f,s: array[1..LM] of longint;
  p: array[1..LM] of boolean;


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

function trans(num: longint): longint;
var
	temp: longint;
begin
	temp:= 0;
  while (num > 0) do
  begin
		temp:= temp + sqr(num mod 10);
    num:= num div 10;
  end;

  exit(temp);
end;

procedure init;
var
	i,temp: longint;
begin
	for i:= 1 to LM do
  	s[i]:= trans(i);	

  //
	fillchar(f,sizeof(f),0);
	for i:= 1 to LM do
  begin
  	fillchar(p,sizeof(p),false);

  	temp:= i;
    while (temp <> 1) do
    begin
    	inc(f[i]);
    	temp:= s[temp];

      if p[temp] then
      begin
      	f[i]:= -1;
        break;
      end;
			p[temp]:= true;
    end;
  end;
end;

procedure process;
begin
	n:= trans(n);
	if (f[n] = -1) then writeln(fo,-1)
  else writeln(fo,f[n] + 1);
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
