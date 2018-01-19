Program Bai_DT07;{Giai bai mang dien}
  Const fi= 'DT07.INP';
        fo= 'DT07.OUT';
        Mn = 100;
        max = 30000;
  Var  n, k: integer;
       a: array[1..Mn,1..Mn] of integer;
       d: array[1..Mn] of longint;
       vs: array[1..Mn] of boolean;
       gan: array[1..Mn] of Byte;
 (**************************************)
  Procedure READ_F;
    Var i, j: integer;
        f: text;
    Begin
     assign(f, fi); reset(f);
     readln(f, n);
     for i:= 1 to n do
       begin
         for j:= 1 to n do
           begin
            read(f, a[i,j]);
            if (a[i, j]= 0) then a[i, j]:= max;
           end;
         readln(f);
       end;
     close(f);
    End;
 (**************************************)
  Procedure Prim;
    Var i, u: integer;
        mind: longint;
    Begin
      for i:= 2 to n do
        begin
          d[i]:= a[1,i];
          vs[i]:= false;
          gan[i]:= 1;
        end;

       d[1]:=0; gan[1]:= 0; vs[1]:= true;
       k:=1;
       while (k<n) do //for k:= 1 to n do
         begin
             mind:= max; u:= 0;
             for i:= 1 to n do
               if not(vs[i]) and (d[i] < mind) then
                 begin
                    mind:= d[i]; u:= i;
                 end;
          if (u=0) then exit;
          vs[u]:= true;   k:= k+1;
          if (k=n) then exit;
          for i:= 1 to n do
            if not(vs[i]) and (d[i] > a[u, i]) then
              begin
                 d[i]:= a[u, i];
                 gan[i]:= u;
              end;
         end;
    End;
 (**************************************)
   Procedure WRITE_F;
     Var  f: text;
          i: integer;
          s: longint;
     Begin
      assign(f, fo); rewrite(f);
      if (k<n) then writeln(f, 0)
               else
       begin
        s:= 0;
        for i:= 2 to n do s:= s + d[i];
        writeln(f, s);
        for i:= 2 to n do
          if (i < gan[i]) then writeln(f, i, ' ', gan[i])
                          else writeln(f, gan[i], ' ', i);
       end;
     close(f);
     End;
 (**************************************)
  BEGIN
    READ_F;
    Prim;
    WRITE_F;
  END.
