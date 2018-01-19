{
ID: ndchiph1
PROG: treasure
LANG: PASCAL
}
uses math;
const
	inputfile = 'treasure.in';
  outputfile = 'treasure.out';
  maxN = 5000 + 10;
//type

var
	fi,fo: text;
  n: longint;
  s: array[0..maxN] of longint;
  f: array[0..maxN,0..1] of longint;


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
	i,num: longint;
begin
	readln(fi,n);
	for i:= 1 to n do
  begin
  	readln(fi,num);
    s[i]:= s[i - 1] + num;
  end;
end;

procedure process;
var
	i,j,sum,nxt,prv: longint;
begin
	for j:= 1 to n do
  begin
  	nxt:= j mod 2;
    prv:= (j + 1) mod 2;

  	for i:= j downto 1 do
    begin
			sum:= s[j] - s[i - 1];

      f[i,nxt]:= sum - min(f[i + 1,nxt],f[i,prv]);
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[1,n mod 2]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
