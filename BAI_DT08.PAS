Program Bai_DT08;{Giai bai Tap trung quan}
  Const fi= 'DT08.INP';
        fo= 'DT08.OUT';
        max = 1000;
  Var   n: integer;
       qc: array[0..63] of array[1..2] of char;
       dcv, dcm: array['A'..'H', '1'..'8', 'A'..'H', '1'..'8'] of integer;
       t, kq: array['A'..'H', '1'..'8'] of integer;
 (**************************************)
  Procedure READ_F;
    Var f: text;
        st: string;
    Begin
     assign(f, fi); reset(f);
     readln(f, st);
     close(f);
     while (st[1]=' ') do delete(st,1,1);
     while (st[length(st)] = ' ') do dec(st[0]);
     n:= -1;
     while (st<>'') do
       begin
           inc(n);
           qc[n,1]:= st[1]; qc[n,2]:= st[2]; delete(st,1,2);
       end;
    End;
 (***************************************)
  Procedure Floyd;
    Var i, j, h, l, u, v: char;
        k, tg: integer;
    Begin
      for i:= 'A' to 'H' do
        for j:= '1' to '8' do
           for u:= 'A' to 'H' do
              for v:= '1' to '8' do
                begin
                if (abs(ord(u)-ord(i)) > abs(ord(v)-ord(j))) then
                       dcv[i, j, u, v]:= abs(ord(u)-ord(i))
                       else  dcv[i, j, u, v]:= abs(ord(v)-ord(j));

                if (abs(ord(u)-ord(i))* abs(ord(v)-ord(j)) = 2) then
                       dcm[i, j, u, v]:= 1
                       else dcm[i, j, u, v]:= max;
                end;
     for i:= 'A' to 'H' do
        for j:= '1' to '8' do
        dcm[i,j,i,j]:= 0;

     for h:= 'A' to 'H' do
     for l:= '1' to '8' do
     for i:= 'A' to 'H' do
        for j:= '1' to '8' do
           for u:= 'A' to 'H' do
              for v:= '1' to '8' do
               if (dcm[i,j,u,v] > dcm[i,j,h,l] + dcm[h,l,u,v]) then
                  dcm[i,j,u,v]:= dcm[i,j,h,l] + dcm[h,l,u,v];

     for i:= 'A' to 'H' do
        for j:= '1' to '8' do
         begin
            t[i, j]:= dcv[qc[0,1], qc[0,2], i, j];
            for k:= 1 to n do t[i,j]:= t[i,j] + dcm[qc[k, 1], qc[k, 2],i, j];
            kq[i,j]:= t[i,j];
            for k:= 1 to n do
                if (dcm[qc[k, 1], qc[k, 2],qc[0,1], qc[0,2]] +
                dcm[qc[0, 1], qc[0, 2],i, j] = dcm[qc[k, 1], qc[k, 2],i, j])
                then  begin
                       kq[i, j]:= kq[i,j] - dcv[qc[0, 1], qc[0, 2],i,j];
                       break;
                       end
                else
                  for u:= 'A' to 'H' do
                    for v:= '1'  to '8' do
                    begin
                        tg:= dcv[qc[0,1],qc[0,2], u, v] +
                          dcm[qc[k,1],qc[k,2], u, v] + dcm[u, v, i, j]
                          - dcv[qc[0,1],qc[0,2], i, j] -
                            dcm[qc[k,1],qc[k,2], i, j] + t[i, j];
                        if tg < kq[i, j] then kq[i, j]:= tg;
                    end;
          end;
    End;
 (**************************************)
   Procedure WRITE_F;
     Var  f: text;
          i, j, u, v: char;
          min: integer;
     Begin
      assign(f, fo); rewrite(f);
      min:= max;
      for i:= 'A' to 'H' do
        for j:= '1' to '8' do
          if (min > kq[i, j]) then
            begin
            min:= kq[i, j];
            u:= i; v:= j;
            end;
         writeln(f, min);
         writeln(f, u, v);
     close(f);
     End;
 (**************************************)
  BEGIN
    READ_F;
    Floyd;
    WRITE_F;
  END.
