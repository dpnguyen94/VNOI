program Bai_DT06;{Giai bai Diep vien 007}
  Const fi= 'MC.INP';
        fo= 'MC.OUT';
        max = 10000;
        Mn = 100;
  Type  O = record
             i, j: integer;
            end;
  Var  m, n, h, k, x, y: integer;
       mc: array[0..mn+1, 0..mn+1] of byte;
       dnx, dnl: array[1..1000] of o;
       lr: array[1..10] of o;
       d: array[1..mn, 1..mn] of integer;
       preh, prec: array[1..mn, 1..mn] of byte;
 (**************************************)
  Procedure READ_F;
    Var i, j: integer;
        f: text;
    Begin
     assign(f, fi); reset(f);
     readln(f, m, n);
     readln(f, x, y);
     fillchar(mc, sizeof(mc), 2);
     for i:= 1 to m do
       begin
          for j:= 1 to n do read(f, mc[i, j]);
          readln(f);
       end;
     readln(f, h);
       for i:= 1 to h do
          readln(f, dnx[i].i, dnx[i].j, dnl[i].i, dnl[i].j);
    readln(f, k);
       for i:= 1 to k do readln(f, lr[i].i, lr[i].j);
     close(f);
    End;
 (**************************************)
  Procedure Dijktra;
    Var i, j, l, u, v: integer;
        mind: integer;
        ok: boolean;
    Begin
      for i:= 1 to m do
        for j:= 1 to n do
           begin
                d[i, j]:= max;
                for u:= 1 to h do
               if (dnx[u].i=x) and (dnx[u].j=y) and (mc[i,j]=0) and
                  (dnl[u].i=i) and (dnl[u].j=j) then
                     begin
                      d[i,j]:= 1;
                      break;
                     end;
                preh[i,j]:= x; prec[i, j]:= y;
            end;
         if (mc[x-1,y]=0) then d[x-1, y]:= 1;
         if (mc[x+1,y]=0) then d[x+1, y]:= 1;
         if (mc[x,y-1]=0) then d[x, y-1]:= 1;
         if (mc[x,y+1]=0) then d[x, y+1]:= 1;

      //
      d[x, y]:= 0; mc[x,y]:= 2; preh[x, y]:= 0; prec[x, y]:= 0;
      ok:= true;
      while ok do
        begin
         mind:= max; u:= 0; v:= 0;
         for i:= 1 to m do
          for j:= 1 to n do
               if (mc[i,j] = 0) and (d[i,j] < mind) then
                  begin
                    mind:= d[i,j]; u:= i; v:= j;
                  end;

       if (u = 0) then exit;
       mc[u,v]:= 2;
       for i:= 1 to k do
        if (lr[i].i=u) and (lr[i].j=v) then exit;

        //sua nhan
         if (mc[u-1,v]=0) and (d[u-1,v] > d[u,v]+1) then
           begin
           d[u-1, v]:= d[u,v] + 1;
           preh[u-1,v]:= u; prec[u-1,v]:= v;
           end;
         if (mc[u+1,v]=0) and (d[u+1,v] > d[u,v]+1) then
           begin
           d[u+1, v]:= d[u,v] + 1;
           preh[u+1,v]:= u; prec[u+1,v]:= v;
           end;
        if (mc[u,v-1]=0) and (d[u,v-1] > d[u,v]+1) then
           begin
           d[u, v-1]:= d[u,v] + 1;
           preh[u,v-1]:= u; prec[u,v-1]:= v;
           end;
        if (mc[u,v+1]=0) and (d[u,v+1] > d[u,v]+1) then
           begin
           d[u, v+1]:= d[u,v] + 1;
           preh[u,v+1]:= u; prec[u,v+1]:= v;
           end;
       for i:= 1 to m do
        for j:= 1 to n do
                for l:= 1 to h do
               if (dnx[l].i=u) and (dnx[l].j=v) and (mc[i,j]=0) and
                  (dnl[l].i=i) and (dnl[l].j=j) and (d[i,j]>d[u,v]+1) then
                     begin
                      d[i,j]:= d[u,v] + 1;
                      preh[i,j]:= u; prec[i, j]:= v;
                      break;
                     end;
       end;
    End;
 (**************************************)
   Procedure WRITE_F;
     Var  f: text;
          i, j, u, v: integer;
          mind: integer;
   Procedure Print(i, j: byte);
    Begin
     if (preh[i,j] > 0) then print(preh[i,j], prec[i,j]);
     writeln(f, i, ' ',j);
    End;

     Begin
      assign(f, fo); rewrite(f);
      mind:= max;
      for i:= 1 to k do
          if (mind > d[lr[i].i, lr[i].j]) then
            begin
            mind:= d[lr[i].i, lr[i].j];
            u:= lr[i].i; v:= lr[i].j;
            end;
      if (mind = max) then writeln(f,0)
                      else
         begin
         writeln(f, mind+1);
         print(u, v);
        end;
     close(f);
     End;
 (**************************************)
  BEGIN
    READ_F;
    Dijktra;
    WRITE_F;
  END.
