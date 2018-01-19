Program Bai_DT05;{Giai bai Tien thuong}
  Const fi= 'DT05.INP';
        fo= 'DT05.OUT';
        max = 1000000;
        hang: array[1..8] of char = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H');
  Var  k, m: longint;
       bc: array[1..8, 1..8, 1..8, 1..8] of longint;
       tt: array[1..8, 1..8] of longint;
 (**************************************)
  Procedure READ_F;
    Var i: integer;
        x: byte;
        f: text;
    Begin
     assign(f, fi); reset(f);
     readln(f, k, m);
     close(f);
    End;
 (**************************************)
 Function  mu(p: integer): longint;
   var i: integer;
       lt: longint;
   Begin
     lt:= 1;
     for i:= 1 to p do lt:= lt*2;
     mu:= lt;
   End;
 (***************************************)
  Procedure Floyd;
    Var i, j, h, l, u, v: integer;
        tg: longint;
    Begin
      for i:= 1 to 8 do
        for j:= 1 to 8 do
           for u:= 1 to 8 do
              for v:= 1 to 8 do
                begin
                 bc[i, j, u, v]:= max;
                 if (abs(u-i)*abs(v-j) = 2) then bc[i, j, u, v]:= 1;
                end;
     for i:= 1 to 8 do
        for j:= 1 to 8 do
         bc[i,j,i,j]:= 0;

     for h:= 1 to 8 do
      for l:= 1 to 8 do
       for i:= 1 to 8 do
        for j:= 1 to 8 do
           for u:= 1 to 8 do
              for v:= 1 to 8 do
               if (bc[i,j,u,v] > bc[i,j,h,l] + bc[h,l,u,v]) then
                  bc[i,j,u,v]:= bc[i,j,h,l] + bc[h,l,u,v];
     fillchar(tt, sizeof(tt), 0);
     for i:= 1 to 8 do
        for j:= 1 to 8 do
         begin
            tg:= 0;
           for u:= 1 to 8 do
              for v:= 1 to 8 do
             if (bc[i,j,u,v] <=k) then tg:= tg + mu(k- bc[i,j,u,v]);
              if (tg > m) then tt[i, j]:= 0
                          else tt[i, j]:= tg;
                end;
    End;
 (**************************************)
   Procedure WRITE_F;
     Var  f: text;
          i, j, k: integer;
          maxt: longint;
     Begin
      assign(f, fo); rewrite(f);
      maxt:= 0;
      for i:= 1 to 8 do
        for j:= 1 to 8 do
          if (maxt < tt[i, j]) then maxt:= tt[i, j];
      writeln(f, maxt);
       if (maxt > 0) then
          for i:= 1 to 8 do
            for j:= 1 to 8 do
              if (tt[i, j] = maxt) then  write(f,hang[i], j,  ' ');
     close(f);
     End;
 (**************************************)
  BEGIN
    READ_F;
    Floyd;
    WRITE_F;
  END.
