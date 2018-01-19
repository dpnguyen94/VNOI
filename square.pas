uses math;
const
    maxRC = 55;
//type
var
  ntest,test: longint;
  r,c: longint;
  a: array[0..maxRC,0..maxRC] of char;


procedure openfile;
begin
  assign(input,'A-large.in'); reset(input);
  assign(output,'square.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,k: longint;
begin
  for i:= 0 to maxRC do
    for k:= 0 to maxRC do a[i,k]:= ' ';

  readln(r,c);
  for i:= 1 to r do
  begin
    for k:= 1 to c do read(a[i,k]);
    readln;
  end;
end;

procedure output(x: longint);
var
  i,k: longint;
begin
  writeln('Case #',test,':');

  if (x = 0) then writeln('Impossible')
  else
  begin
    for i:= 1 to r do
    begin
      for k:= 1 to c do write(a[i,k]);
      writeln;
    end;
  end;
end;

procedure process;
var
  i,k: longint;
begin
  for i:= 1 to r do
    for k:= 1 to c do
      if (a[i,k] = '#') then
      begin
        if (a[i,k + 1] <> '#') or (a[i + 1,k] <> '#')
          or (a[i + 1,k + 1] <> '#') then
          begin
              output(0);
              exit;
          end;

        a[i,k]:= '/';
        a[i,k + 1]:= '\';
        a[i + 1,k]:= '\';
        a[i + 1,k + 1]:= '/';
      end;

  output(1);
end;


BEGIN
	openfile;
  readln(ntest);
  for test:= 1 to ntest do
  begin
    input;
    process;
  end;
  closefile;
END.
