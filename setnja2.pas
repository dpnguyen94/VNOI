uses math;
const
	inputfile = 'setnja.inp';
  outputfile = 'setnja.out';
  maxN = 10010;
//type

var
	fi,fo: text;
  n: longint;
  s: ansistring;
  a,c,f: array[0..maxN] of longint;
  power: array[0..15] of longint;


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
	readln(fi,s);
  n:= length(s);
end;

procedure init;
var
	i: longint;
begin
	for i:= 1 to n do
  begin
  	if (s[i] = '*') then c[i]:= c[i-1] + 1
    else c[i]:= c[i-1];

    if (s[i] = 'P') then a[i]:= 1;
    if (s[i] = 'L') then a[i]:= 2;
    if (s[i] = 'R') then a[i]:= 3;
  end;

  power[0]:= 1;
  for i:= 1 to 15 do
  	power[i]:= power[i-1] * 3;
end;

procedure process;
var
	i: longint;
begin
	if (a[1] = 0) then f[1]:= 6
  else f[1]:= a[1];

	for i:= 2 to n do
  begin
		if (a[i] = 0) then f[i]:= 5 * f[i-1] + power[c[i-1]];
    if (a[i] = 1) then f[i]:= f[i-1];
    if (a[i] = 2) then f[i]:= 2 * f[i-1];
    if (a[i] = 3) then f[i]:= 2 * f[i-1] + power[c[i-1]];
  end;
end;

procedure output;
begin
	writeln(fo,f[n]);
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
