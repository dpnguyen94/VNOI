uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000 + 50;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
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
begin
	readln(fi,n);
end;

procedure update(x,y,val: longint);
var
	y1: longint;
begin
	while (x <= n) do
  begin
		y1:= y;
    while (y1 <= n) do
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
	ch: char;
  s: string;
  x,y,num,x1,y1,x2,y2,sum,sum1,sum2,sum3: longint;
begin
	fillchar(f,sizeof(f),0);
	while true do
  begin
  	read(fi,ch);
    if (ch = 'E') then
    begin
    	readln(fi);
      exit;
    end;

    s:= '';
    s:= s + ch;
    while true do
    begin
    	read(fi,ch);
      if (ch = ' ') then break;
      s:= s + ch;
    end;

    if (s = 'SET') then
    begin
    	readln(fi,x,y,num);
      inc(x);
      inc(y);
		
    	sum:= get(x,y);
      sum1:= get(x - 1,y);
      sum2:= get(x,y - 1);
      sum3:= get(x - 1,y - 1);

      update(x,y,num - (sum - sum1 - sum2 + sum3));
    end;
    if (s = 'SUM') then
    begin
    	readln(fi,x1,y1,x2,y2);
      inc(x1); inc(y1);
      inc(x2); inc(y2);

      sum:= get(x2,y2);
      sum1:= get(x1 - 1,y2);
      sum2:= get(x2,y1 - 1);
      sum3:= get(x1 - 1,y1 - 1);

      writeln(fo,sum - sum1 - sum2 + sum3);
    end;
  end;
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
