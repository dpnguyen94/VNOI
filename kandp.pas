uses math;
const
  inputfile = '';
  outputfile = '';
  LM = 1000 + 10;
type
  queue = record
    x,y: longint;
    t: boolean;
  end;
var
  fi,fo: text;
  mx,my,tx,ty: longint;
  d: array[-LM..LM,-LM..LM] of longint;
  qu: array[1..4 * LM * LM] of queue;
  dq,cq: longint;

  dx: array[1..8] of longint = (2,1,-1,-2,-2,-1,1,2);
  dy: array[1..8] of longint = (1,2,2,1,-1,-2,-2,-1);


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
var
  num: longint;
begin
  readln(fi,mx,my);
  readln(fi,tx,ty);

  readln(fi,num);
  if (num = 0) then qu[1].t:= true
  else qu[1].t:= false;
end;

procedure process;
var
  u,v,k,u1,v1: longint;
  turn: boolean;
begin
  dq:= 1;
  cq:= 1;
  qu[1].x:= mx;
  qu[1].y:= my;
  d[mx,my]:= 1;

  while (dq <= cq) do
  begin
    u:= qu[dq].x;
    v:= qu[dq].y;
    turn:= qu[dq].t;
    inc(dq);

    if turn then
    begin
      for k:= 1 to 8 do
      begin
        u1:= u + dx[k];
        v1:= v + dy[k];

        if (abs(u1) > LM) or (abs(v1) > LM) or (d[u1,v1] > 0) then continue;

        inc(cq);
        qu[cq].x:= u1;
        qu[cq].y:= v1;
        qu[cq].t:= false;
        d[u1,v1]:= d[u,v] + 1;

        if (d[tx,ty] > 0) then
        begin
          writeln(fo,'YES');
          writeln(fo,d[tx,ty] - 1);
          exit;
        end;
      end;
    end
    else
    begin
      u1:= u + 1;

      if (abs(u1) > LM) or (d[u1,v] > 0) then continue;

      inc(cq);
      qu[cq].x:= u1;
      qu[cq].y:= v;
      qu[cq].t:= true;
      d[u1,v]:= d[u,v];

      if (d[tx,ty] > 0) then
      begin
        writeln(fo,'NO');
        exit;
      end;
    end;
  end;

  writeln(fo,'NO');
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
