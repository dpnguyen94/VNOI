uses math;
//const
//type
var
  ntest,test: longint;
  c,d,n: longint;
  a: array['A'..'Z','A'..'Z'] of char;
  x: array['A'..'Z','A'..'Z'] of boolean;
  s,res: string;


procedure openfile;
begin
  assign(input,'magic.inp'); reset(input);
  assign(output,'magic.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i: longint;
  sp,c1,c2: char;
begin
  for c1:= 'A' to 'Z' do
    for c2:= 'A' to 'Z' do
      a[c1,c2]:= ' ';
  fillchar(x,sizeof(x),false);

  read(c);
  for i:= 1 to c do
  begin
    read(sp,c1,c2,a[c1,c2]);
    a[c2,c1]:= a[c1,c2];
  end;
  read(d);
  for i:= 1 to d do
  begin
    read(sp,c1,c2);
    x[c1,c2]:= true;
    x[c2,c1]:= true;
  end;
  read(n,sp,s);
end;

procedure process;
var
  i,k,len: longint;
begin
  res:= '';
  for i:= 1 to n do
  begin
    len:= length(res);
    if (len = 0) then
    begin
      res:= res + s[i];
      continue;
    end;

    if (a[s[i],res[len]] <> ' ') then res[len]:= a[s[i],res[len]]
    else
    begin
      for k:= 1 to len do
        if x[s[i],res[k]] then res:= '';
      if (res <> '') then res:= res + s[i];
    end;
  end;
end;

procedure output;
var
  i: longint;
begin
  write('Case #',test,': ');

  if (res = '') then writeln('[]')
  else
  begin
    write('[');
    for i:= 1 to length(res) - 1 do write(res[i],', ');
    writeln(res[length(res)],']');
  end;
end;


BEGIN
	openfile;
  readln(ntest);
  for test:= 1 to ntest do
  begin
    input;
    process;
    output;
  end;
  closefile;
END.
