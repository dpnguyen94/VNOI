uses math;
const
	inputfile = 'delnum.inp';
  outputfile = 'delnum.out';
  maxN = 100010;
//type

var
	fi,fo: text;
  n,top: longint;
	a,st: array[0..maxN] of longint;


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
	readln(fi,n);
  for i:= 1 to n do
  	read(fi,a[i]);
end;

procedure process;
var
	i,cnt: longint;
begin
  cnt:= 0;
  top:= 2;
  st[0]:= -maxlongint;
  st[1]:= a[1];
  st[2]:= a[2];
	for i:= 3 to n do
  begin
  	while (a[i] > st[top]) and (st[top - 1] > st[top]) do
    begin
    	dec(top);
      inc(cnt);
    end;

    inc(top);
    st[top]:= a[i];
  end;

	writeln(fo,n - cnt);
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
