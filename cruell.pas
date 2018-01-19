uses math;
const
	inputfile = '';
  outputfile = '';
  base = 1000000000;
  LM = 1600;
type
	bignum = array[0..LM] of longint;
var
	fi,fo: text;
  n: int64;
  p: longint;
	res: bignum;
  add: array[1..LM] of longint;


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
	readln(fi,n,p);
end;

procedure muln(var res: bignum);
var
	i: longint;
  tmp: int64;
begin
	for i:= 1 to res[0] do
  	add[i]:= 0;

	for i:= 1 to res[0] do
  begin
		tmp:= res[i] * n + add[i];

    inc(add[i + 1],tmp div base);
    inc(add[i + 2],add[i + 1] div base);
    add[i + 1]:= add[i + 1] mod base;

    if (tmp >= base) then
    	tmp:= tmp mod base;
    res[i]:= tmp;
  end;

  while (add[res[0] + 1] > 0) do
  begin
  	inc(res[0]);
    res[res[0]]:= add[res[0]];
  end;
end;

procedure process;
var
	i: longint;
begin
	res[0]:= 1;
  res[1]:= 1;
  for i:= 1 to p do
  	muln(res);
end;

procedure output;
var
	i: longint;
  s: string;
  sres: ansistring;
begin
	str(res[res[0]],sres);
	
  for i:= res[0] - 1 downto 1 do
  begin
  	str(res[i],s);
    while (length(s) < 9) do s:= '0' + s;

    sres:= sres + s;
  end;

  for i:= 1 to length(sres) do
  begin
  	write(fo,sres[i]);
    if (i mod 70 = 0) then writeln(fo);
  end;
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
