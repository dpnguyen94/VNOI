uses math;
const
  maxN = 2005;
//type
var
  ntest,test: longint;
  n: longint;
  a,s: array[0..maxN] of longint;
  f,mc: array[0..maxN,0..maxN] of longint;


procedure openfile;
begin
  assign(input,''); reset(input);
  assign(output,''); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i: longint;
begin
  readln(n);
  for i:= 1 to n do
  begin
    readln(a[i]);
    s[i]:= s[i - 1] + a[i];
  end;
end;

procedure process;
var
	i,j,leng,k,temp: longint;
begin
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
        if (k > i) then
        begin
          temp:= min(s[k - 1] - s[i - 1] + f[i,k - 1],s[j] - s[k - 1] + f[k,j]);
          if (temp > f[i,j]) then
          begin
      		  f[i,j]:= temp;
            mc[i,j]:= k;
          end;
        end;
      end;
    end;
  end;
end;

procedure output;
begin
  writeln(f[1,n]);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
