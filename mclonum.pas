uses math;
const
  maxN = 65;
//type
var
  ntest,test: longint;
  n: longint;
  a,res: array[0..maxN] of longint;
  b,num: array[0..9] of longint;


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
  s: string;
  i: longint;
begin
  readln(s);
  n:= length(s);
  for i:= 1 to n do
    a[i]:= ord(s[i]) - ord('0');
  readln(s);
  for i:= 1 to n do
    inc(b[ord(s[i]) - ord('0')]);
end;

procedure process1;
var
  i,j,k,t,d: longint;
  ok: boolean;
begin
  num:= b;
  for i:= 1 to n do
  begin
    ok:= false;
    for d:= a[i] to 9 do
      if (num[d] > 0) then
      begin
        ok:= true;
        res[i]:= d;
        dec(num[d]);

        if (d > a[i]) then
        begin
          for k:= 1 to i do write(res[k]);
          for j:= 0 to 9 do
            for k:= 1 to num[j] do write(j);
          writeln;
          exit;
        end;

        break;
      end;

    if not ok then
    begin
      for k:= i - 1 downto 1 do
      begin
        inc(num[res[k]]);
        for d:= a[k] + 1 to 9 do
          if (num[d] > 0) then
          begin
            res[k]:= d;
            dec(num[d]);
            for t:= 1 to k do write(res[t]);
            for j:= 0 to 9 do
              for t:= 1 to num[j] do write(j);
            writeln;
            exit;
          end;
      end;

      writeln(0);
      exit;
    end;
  end;

  for i:= 1 to n do write(res[i]);
  writeln;
end;

procedure process2;
var
  i,j,k,t,z,d: longint;
  ok: boolean;
begin
  num:= b;
  for i:= 1 to n do
  begin
    ok:= false;
    if (i = 1) then t:= 1
    else t:= 0;
    for d:= a[i] downto t do
      if (num[d] > 0) then
      begin
        ok:= true;
        res[i]:= d;
        dec(num[d]);

        if (d < a[i]) then
        begin
          for k:= 1 to i do write(res[k]);
          for j:= 9 downto 0 do
            for k:= 1 to num[j] do write(j);
          writeln;
          exit;
        end;

        break;
      end;

    if not ok then
    begin
      for k:= i - 1 downto 1 do
      begin
        inc(num[res[k]]);
        if (k = 1) then z:= 1
        else z:= 0;
        for d:= a[k] - 1 downto z do
          if (num[d] > 0) then
          begin
            res[k]:= d;
            dec(num[d]);
            for t:= 1 to k do write(res[t]);
            for j:= 9 downto 0 do
              for t:= 1 to num[j] do write(j);
            writeln;
            exit;
          end;
      end;

      writeln(0);
      exit;
    end;
  end;

  for i:= n downto 1 do
  begin
    inc(num[res[i]]);
    if (i = 1) then t:= 1
    else t:= 0;
    for d:= a[i] - 1 downto t do
      if (num[d] > 0) then
      begin
        res[i]:= d;
        dec(num[d]);
        for k:= 1 to i do write(res[k]);
        for j:= 9 downto 0 do
          for k:= 1 to num[j] do write(j);
        writeln;
        exit;
      end;
  end;

  writeln(0);
  exit;
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process1;
  process2;
  output;
  closefile;
END.
