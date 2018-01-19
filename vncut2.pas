uses math;
const
	inputfile = 'vncut.inp';
  outputfile = 'vncut.out';
  LM = 500;
//type

var
	fi,fo: text;
  m,n: longint;
  f: array[0..LM,0..LM] of longint;


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

  //
  write(fo,'(');
  for i:= 1 to LM do
  begin
		write(fo,'(');
    for j:= 1 to LM - 1 do
    begin
    	write(fo,f[i,j],',');
      if (j mod 50 = 0) then writeln(fo);
    end;
    writeln(fo,f[i,LM],'),');
  end;
end;

procedure output;
begin
end;


BEGIN
	openfile;
  input;
  init;
  output;
  closefile;
END.
