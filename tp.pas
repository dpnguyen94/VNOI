var
  n,i: longint;
  a: array[1..100] of longint;

BEGIN
  assign(input,'tp.inp'); reset(input);
  assign(output,'tp.out'); rewrite(output);

  readln(n);
  for i:= 1 to n do
    read(a[i]);

  writeln(n);
  for i:= n downto 1 do
    write(a[i],' ');

  close(input);
  close(output);
END.