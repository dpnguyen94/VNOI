uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 2000 + 10;
  maxC = 1000000000;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n: longint;
  a,s: array[0..maxN] of longint;
  f,mc: array[0..maxN,0..maxN] of longint;


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
  begin
  	read(fi,a[i]);
    s[i]:= s[i - 1] + a[i];
  end;
end;

procedure process;
var
	i,j,leng,k,temp: longint;
begin
  for i:= 0 to n do
  	for j:= 0 to n do	
    	f[i,j]:= maxC;

  for i:= 1 to n do
  begin
  	f[i,i]:= 0;
    mc[i,i]:= i;
  end;

  for leng:= 2 to n do
  begin
  	for i:= 1 to n - leng + 1 do
    begin
    	j:= i + leng - 1;

      for k:= mc[i,j - 1] to mc[i + 1,j] do
      begin
				temp:= s[j] - s[i - 1] + f[i,k - 1] + f[k,j];
        if (temp < f[i,j]) then
        begin
      		f[i,j]:= temp;
          mc[i,j]:= k;
        end;
      end;
    end;
  end;
end;

procedure output;
begin
	writeln(fo,f[1,n]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
