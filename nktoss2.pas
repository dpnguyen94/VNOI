uses math;
const
	inputfile = 'nktoss.inp';
  outputfile = 'nktoss2.out';
  maxN = 10000;
//type
var
	fi,fo: text;
  n,k: longint;
  f: array[0..maxN,0..1] of int64;


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
	readln(fi,n,k);
  dec(k);
end;


procedure process;
var
	i,j,sum: longint;
begin
	f[0,0]:= 1;
	
  sum:= 1;
	for i:= 1 to n do
  begin
  	f[i,1]:= f[i,1] + sum;
    if (i >= k) then
    	dec(sum,f[i - k,0]);

    f[i,0]:= f[i-1,0] + f[i-1,1];
    inc(sum,f[i,0]);
  end; 		
end;

procedure output;
begin
	if (k = 0) then writeln(fo,1 shl n - 1)
	else writeln(fo,(1 shl n) - f[n,0] - f[n,1]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
