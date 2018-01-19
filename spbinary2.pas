uses math;
const
	inputfile = 'spbinary.inp';
  outputfile = 'spbinary.out';
  maxN = 20;
  maxK = 10;
//type

var
	fi,fo: text;
  n,k,res: longint;
  a: array[0..maxN] of longint;


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

procedure solve;
var
	d,i,cnt: longint;
begin
	for d:= 0 to 1 do
  begin
  	cnt:= 0;
		for i:= 1 to n do
    begin
    	if (a[i] <> d) then cnt:= 0
      else inc(cnt);
			
      if (cnt > k) then exit;
    end;
  end;

  inc(res);
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i > n) then
  begin
  	solve;
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
