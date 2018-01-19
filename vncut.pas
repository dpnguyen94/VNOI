uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 300;
//type

var
	fi,fo: text;
  m,n: longint;
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
	readln(fi,m,n);
end;

procedure init;
var
	i,j,k,t,t1,t2: longint;
begin
	for i:= 1 to LM do
  	for j:= 1 to LM do
    	if (i = j) then f[i,j]:= 1
      else
      begin
      	t:= maxlongint;

        for k:= 1 to max(i,j) - 1 do
        begin
        	t1:= maxlongint;
          t2:= maxlongint;

					if (k < j) then t1:= f[i,k] + f[i,j - k];
          if (k < i) then t2:= f[k,j] + f[i - k,j];

          t:= min(t,min(t1,t2));
        end;

        f[i,j]:= t;
      end;
end;

function cutmin(i,j: longint): longint;
var
	temp: longint;	
begin
	if (i = 0) or (j = 0) then exit(0);
  if (i <= LM) and (j <= LM) then exit(f[i,j]);

	if (i > j) then
  begin
  	temp:= i;
		i:= j;
    j:= temp;
  end;

  temp:= j div i;
  exit(temp + cutmin(j mod i,i));
end;

procedure process;
begin
	if (max(m,n) <= LM) then writeln(fo,f[m,n])
  else writeln(fo,cutmin(m,n));
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  init;
  process;
  output;
  closefile;
END.
