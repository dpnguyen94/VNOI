uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 50000000 + 10;
//type

var
	fi,fo: text;
  n: longint;
  f: array[0..LM] of longint;


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

function get_f(x: longint): int64;
begin
	if (x = 0) then exit(0);

	if (x <= LM) then
  begin
		if (f[x] = 0) then
    	f[x]:= max(x,get_f(x div 2) + get_f(x div 3) + get_f(x div 4));

    exit(f[x]);
  end;

  exit(max(x,get_f(x div 2) + get_f(x div 3) + get_f(x div 4)));
end;

procedure process;
begin
	writeln(fo,get_f(n));
end;

procedure output;
begin
end;


BEGIN
	openfile;
  while not eof(fi) do
  begin
  	input;
    process;
  end;
  closefile;
END.
