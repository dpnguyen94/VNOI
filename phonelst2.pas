uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 10000 + 10;
  base = 10009;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  s: array[1..maxN] of string;
  pr: array[1..10] of longint = (2,3,5,7,11,13,17,19,23,29);
  hash: array[0..base,1..50] of longint;
  c: array[0..base] of longint;


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
	i: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  	readln(fi,s[i]);
end;

procedure process;
var
	i,j,t,temp: longint;
  st: string;
begin
	fillchar(hash,sizeof(hash),0);
  fillchar(c,sizeof(c),0);

	for i:= 1 to n do
  begin
  	temp:= 0;
    for j:= 1 to length(s[i]) do
			temp:= (temp + ord(s[i][j]) * pr[j]) mod base;

    inc(c[temp]);
    hash[temp,c[temp]]:= i;
  end;

  for i:= 1 to n do
  begin
  	temp:= 0;
    st:= '';
  	for j:= 1 to length(s[i]) - 1 do
    begin
    	st:= st + s[i][j];
			temp:= (temp + ord(s[i][j]) * pr[j]) mod base;

      for t:= 1 to c[temp] do
      	if (st = s[hash[temp,t]]) then
        begin
        	writeln(fo,'NO');
          exit;
        end;
    end;
  end;

  writeln(fo,'YES');
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
