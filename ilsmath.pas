uses math;
const
	inputfile = '';
  outputfile = '';
type
	int1 = longint;
  int2 = int64;
  bool = boolean;
var
	fi,fo: text;
  n,res: longint;
  kq: array[1..10] of longint;


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
  if (n = 1) then
  begin
  	inc(res);
    kq[1]:= 0;
  end;
end;

procedure process;
var
	x,numd: longint;
	tmp: real;
begin
	x:= 1;
  tmp:= 0;
  while TRUE do
  begin
  	tmp:= tmp + ln(x) / ln(10);

    numd:= trunc(tmp) + 1;

    if (numd = n) then
    begin
    	inc(res);
      kq[res]:= x;
    end;
    if (numd > n) then exit;

    inc(x);
  end;
end;

procedure output;
var
	i: longint;
begin
	if (res = 0) then writeln(fo,'NO')
  else writeln(fo,res);
	for i:= 1 to res do
  	writeln(fo,kq[i]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
