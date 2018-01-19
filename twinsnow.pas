uses math;
const
	inputfile = 'twinsnow.inp';
  outputfile = 'twinsnow.out';
	LM = 1000000 + 10;
type
	arr = array[0..5] of longint;
var
	fi,fo: text;
  n,maxprime: longint;
  a,b: arr;
  inset: array[0..LM] of longint;
  p: array[2..LM] of boolean;


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
  maxprime:= 999983;
end;

procedure output(t: longint);
begin
	if (t = 1) then writeln(fo,'Twin snowflakes found.')
  else writeln(fo,'No two snowflakes are alike.');
end;

function hashnum(x: arr): longint;
var
	i,sum: longint;
begin
	sum:= 0;
	for i:= 0 to 5 do
		sum:= (int64(sum) * 64 + x[i]) mod maxprime;

  exit(sum);
end;

procedure process;
var
	i,k,tt,tmp: longint;
begin
	for k:= 1 to n do
  begin
  	for i:= 0 to 5 do
    	read(fi,a[i]);
		
    for tt:= 0 to 5 do
    begin
    	for i:= 0 to 5 do
      	b[i]:= a[(i + tt) mod 6];

      tmp:= hashnum(b);
      if (inset[tmp] > 0) and (inset[tmp] < k) then
      begin
      	output(1);
        closefile;
        halt;
      end
      else inset[tmp]:= k;
    end;
  end;
end;


BEGIN
	openfile;
  input;
  process;
  output(0);
  closefile;
END.
