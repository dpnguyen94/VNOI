uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000 + 50;
//type

var
	fi,fo: text;
  ntest,test: longint;
  s: longint;
  f: array[1..LM,1..LM] of longint;


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
//var
begin
end;

procedure update(x,y,val: longint);
var
	y1: longint;
begin
	while (x <= s) do
  begin
		y1:= y;
    while (y1 <= s) do
    begin
    	inc(f[x,y1],val);
      y1:= y1 + (y1 and (-y1));
    end;
		x:= x + (x and (-x));
  end;
end;

function get(x,y: longint): longint;
var
	temp,y1: longint;
begin
	temp:= 0;
  while (x >= 1) do
  begin
  	y1:= y;
    while (y1 >= 1) do
    begin
			temp:= temp + f[x,y1];
      y1:= y1 - (y1 and (-y1));
    end;
		x:= x - (x and (-x));
  end;

  exit(temp);
end;

procedure process;
var
  num,x,y,a,l,b,r,t,sum,sum1,sum2,sum3: longint;
begin
	readln(fi,num,s);
	while true do
  begin
  	read(fi,num);
    if (num = 3) then exit;

    if (num = 1) then
    begin
    	readln(fi,x,y,a);
      inc(x);
      inc(y);
      update(x,y,a);
    end;

    if (num = 2) then
    begin
    	readln(fi,l,b,r,t);
      inc(l); inc(b);
      inc(r); inc(t);

      sum:= get(r,t);
      sum1:= get(l - 1,t);
      sum2:= get(r,b - 1);
      sum3:= get(l - 1,b - 1);

      writeln(fo,sum - (sum1 + sum2 - sum3));
    end;
  end;
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
