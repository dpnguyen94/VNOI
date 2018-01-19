uses math;
7const
  LM = 128 + 5;
//type
var
  ntest,test: longint;
  w,h: longint;
  a: array[0..LM,0..LM] of char;
  f: array[0..2 * LM,0..LM,0..LM] of longint;
  dk: array[1..4] of longint = (0,0,1,1);
  dt: array[1..4] of longint = (0,1,0,1);


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
  i,k: longint;
begin
  readln(w,h);
  for i:= 1 to h do
  begin
    for k:= 1 to w do read(a[i,k]);
    readln;
  end;
end;

function calc(i,k,t: longint): longint;
var
  xk,xt,tt,kk,z,best,tmp,res: longint;
begin
  if (k > w) or (t > w) or (k > t) or (i > w + h - 1) then exit(0);

  if (f[i,k,t] <> -1) then exit(f[i,k,t]);

  xk:= i - k + 1;
  xt:= i - t + 1;
  if (xk > h) or (xt > h) then exit(0);

  if (a[xk,k] = '#') or (a[xt,t] = '#') then
  begin
    f[i,k,t]:= 0;
    exit(0);
  end;

  res:= 0;
  if (k = t) then
  begin
    if (a[xk,k] = '*') then res += 1;
  end
  else
  begin
    if (a[xk,k] = '*') then res += 1;
    if (a[xt,t] = '*') then res += 1;
  end;

  best:= -1;
  for z:= 1 to 4 do
  begin
    kk:= k + dk[z];
    tt:= t + dt[z];

    tmp:= calc(i + 1,kk,tt);
    if (tmp > best) then best:= tmp;
  end;

  f[i,k,t]:= res + best;
  exit(f[i,k,t]);
end;

procedure process;
//var
begin
  fillchar(f,sizeof(f),$FF);
  calc(1,1,1);
  if (f[w + h - 1,w,w] = -1) then writeln(0)
  else writeln(f[1,1,1]);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
