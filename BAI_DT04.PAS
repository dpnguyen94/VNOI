Program Bai_DT04;{Giai bai hanh trinh tren xe buyt}
  Const fi= 'DT04.INP';
        fo= 'DT04.OUT';
        Mn = 250;
        max = 1000000;
  Type  TH = Set of byte;
  Var  m, n, s, t: integer;
       tx: array[1..Mn] of TH;
       c, d: array[1..Mn] of longint;
       vs: array[1..Mn] of boolean;
       pre: array[1..Mn] of Byte;
 (**************************************)
  Procedure READ_F;
    Var i: integer;
        x: byte;
        f: text;
    Begin
     assign(f, fi); reset(f);
     readln(f, m, n);
     readln(f, s, t);
     for i:= 1 to m do
       begin
       read(f, c[i]);
        tx[i]:= [];
        while not(SeekEoln(f)) do
          begin
            read(f, x); tx[i]:= tx[i] + [x];
          end;
         readln(f);
       end;
     close(f);
    End;
 (**************************************)
 Function  DC(u, v: byte): byte;
   var i: integer;
   Begin
     DC:= 0;
     for i:= 1 to m do
       if (u in tx[i]) and (v in tx[i]) then
          begin
              DC:= i;
              exit;
          end;
   End;
 (***************************************)
  Procedure Dijktra;
    Var i, u: integer;
        mind: longint;
    Begin
      for i:= 1 to n do
        begin
          d[i]:= max;
          if (dc(s, i) > 0) then d[i]:= c[dc(s,i)];
          vs[i]:= false;
          pre[i]:= s;
       end;
      d[s]:= 0; pre[s]:= 0; vs[s]:= true;
       while not(vs[t]) do
         begin
             mind:= max; u:= 0;
             for i:= 1 to n do
               if not(vs[i]) and (d[i] < mind) then
                 begin
                    mind:= d[i]; u:= i;
                 end;
          if (u=0) then exit;
          vs[u]:= true;
          if vs[t] then exit;
          for i:= 1 to n do
            if not(vs[i]) and (dc(u, i) > 0) and (d[i] > d[u] + c[dc(u, i)]) then
              begin
                 d[i]:= d[u] + c[dc(u, i)];
                 pre[i]:= u;
              end;
         end;
    End;
 (**************************************)
   Procedure WRITE_F;
     Var  f: text;
          i, j, k: integer;
     Begin
      assign(f, fo); rewrite(f);
      if not(vs[t]) then writeln(f, 0)
                     else begin
        writeln(f, d[t]);
         k:= 0;
         i:= t;
         while (i > 0) do
        begin
         inc(k); d[k]:= i;
         i:= pre[i];
        end;
        writeln(f, k-1);
        for i:= k downto 2 do
          writeln(f, dc(d[i], d[i-1]), ' ', d[i], ' ', d[i-1]);
      end;
     close(f);
     End;
 (**************************************)
  BEGIN
    READ_F;
    Dijktra;
    WRITE_F;
  END.
