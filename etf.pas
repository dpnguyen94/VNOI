uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,npr: longint;
  p: array[1..LM] of boolean;
  pr,list: array[1..200] of longint;


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
	i,cnt,res: longint;
begin
	res:= n;
	cnt:= 0;
	for i:= 1 to npr do
  	if (n mod pr[i] = 0) then
    begin
    	inc(cnt);
      list[cnt]:= pr[i];

			while (n mod pr[i] = 0) do
      	n:= n div pr[i];
    end;

  if (n <> 1) then
  begin
  	inc(cnt);
    list[cnt]:= n;
  end;

  for i:= 1 to cnt do
  	res:= res div list[i] * (list[i] - 1);

  writeln(fo,res);
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
