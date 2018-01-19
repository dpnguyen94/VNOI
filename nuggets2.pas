{
ID: ndchiph1
PROG: nuggets
LANG: PASCAL
}
uses math;
const
	inputfile = 'nuggets.in';
  outputfile = 'nuggets.out';
  LM = 67000;
//type

var
	fi,fo: text;
  n: longint;
  f: array[0..LM] of boolean;


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

procedure process;
var
	i,j,num: longint;
begin
	f[0]:= true;
	for i:= 1 to n do
  begin
  	readln(fi,num);
    for j:= num to LM do
    	if f[j-num] then f[j]:= true;
  end;

  f[0]:= false;
  for i:= 66500 downto 0 do
  	if not f[i] then
    	if (i < 66000) then
      begin
      	writeln(fo,i);
        exit;
      end
      else
      begin
      	writeln(fo,0);
        exit;
      end;
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
