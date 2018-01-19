uses math;
const
	inputfile = 'treepath.inp';
  outputfile = 'treepath.out';
//type

var
	fi,fo: text;
	s: ansistring;
  n: longint;
  res: int64;
  ch : string = 'LCRS';
  c: array[1..10] of char;


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
	readln(fi,s);	
  n:= length(s);
end;

procedure solve;
var
	i: longint;
  sum,t: int64;
begin
	sum:= 1;
	t:= 1;
  for i:= 1 to n do
  begin
  	if (c[i] = 'S') then continue;

  	if (c[i] = 'L') then t:= t * 3;
    if (c[i] = 'C') then t:= t * 3 + 1;
    if (c[i] = 'R') then t:= t * 3 + 2;

    sum:= sum + t;
  end;

  res:= res + sum;
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

  if (s[i] = '*') then
  	for j:= 1 to 4 do
    begin
    	c[i]:= ch[j];
      attempt(i + 1);
    end
    else
    begin
  		c[i]:= s[i];
      attempt(i + 1);
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
