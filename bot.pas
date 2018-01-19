uses math;
const
  maxN = 100 + 5;
//type
var
  ntest,test: longint;
  n,res: longint;
  r: array[1..maxN] of char;
  p,o,b: array[1..maxN] of longint;


procedure openfile;
begin
  assign(input,'bot.inp'); reset(input);
  assign(output,'bot.out'); rewrite(output);
end;

procedure closefile;
begin
	close(input);
  close(output);
end;

procedure input;
var
  i,no,nb: longint;
  sp: char;
begin
  read(n);
  no:= 0;
  nb:= 0;
  for i:= 1 to n do
  begin
    read(sp,r[i],p[i]);

    if (r[i] = 'O') then
    begin
      inc(no);
      o[no]:= p[i];
    end
    else
    begin
      inc(nb);
      b[nb]:= p[i];
    end;
  end;
end;

procedure process;
var
  i,t,nowo,nowb,nexto,nextb: longint;
begin
  nowo:= 1; nowb:= 1;
  nexto:= 1; nextb:= 1;
  res:= 0;
  for i:= 1 to n do
    if (r[i] = 'O') then
    begin
      t:= abs(p[i] - nowo) + 1;
      nowo:= p[i];
      res:= res + t;
      inc(nexto);

      if (nowb <= b[nextb]) then nowb:= min(b[nextb],nowb + t)
      else nowb:= max(b[nextb],nowb - t);
    end
    else
    begin
      t:= abs(p[i] - nowb) + 1;
      nowb:= p[i];
      res:= res + t;
      inc(nextb);

      if (nowo <= o[nexto]) then nowo:= min(o[nexto],nowo + t)
      else nowo:= max(o[nexto],nowo - t);
    end;
end;

procedure output;
begin
  writeln('Case #',test,': ',res);
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
