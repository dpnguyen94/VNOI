uses math;
const
	inputfile = 'nktoss.inp';
  outputfile = 'nktoss.out';
  maxN = 20;
//type

var
	fi,fo: text;
  n,k,res: longint;
  a: array[1..maxN] of longint;


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

function solve: boolean;
var
	i,cnt: longint;
begin
	cnt:= 0;
	for i:= 1 to n do
  	if (a[i] = 0) then cnt:= 0
    else
    begin
    	inc(cnt);
      if (cnt = k) then exit(true);
    end;

  exit(false);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > n) then
  begin
  	if solve then inc(res);
    exit;
  end;

  for j:= 0 to 1 do
  begin
    a[i]:= j;
  	attempt(i+1);
  end;
end;

procedure process;
begin
	res:= 0;
	attempt(1);
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
