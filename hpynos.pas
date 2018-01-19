uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 1000;
//type

var
	fi,fo: text;
  n: longint;
  f: array[1..LM] of boolean;


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

function trans(num: longint): longint;
var
	temp: longint;
begin
	temp:= 0;
  while (num > 0) do
  begin
		temp:= temp + sqr(num mod 10);
    num:= num div 10;
  end;

  exit(temp);
end;

procedure process;
var
	time: longint;
begin
	fillchar(f,sizeof(f),false);

  time:= 0;
  while (n <> 1) do
  begin
  	inc(time);
  	n:= trans(n);

    if f[n] then
    begin
    	time:= -1;
      break;
    end;

    f[n]:= true;
  end;

  writeln(fo,time);
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
