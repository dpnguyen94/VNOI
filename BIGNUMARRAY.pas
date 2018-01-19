USES MATH;
CONST
        Finp='dd.inp';
        Fout='dd.out';
        base=1000000000;
type
        bignum=record
                leng:longint;
                num:array[1..10000] of longint;

        end;
        LLD    = Record
                Leng:Integer;
                num:Array[1..10000] Of int64;
               End;
VAR
        Fi,Fo:text;

        m,n:longint;
        d,f,e:bignum;
        g:longint;
        ok:boolean;

{Procedure device(A:BigNum;Var C:BigNum);
Var i:Integer;
Begin
        C.leng:=A.leng;
        FillChar(C.num,SizeOF(C.num),0);
        For i:=C.leng downTo 2 Do
          Begin
            C.num[i]:=C.num[i]+A.num[i] Shr 1;
            If A.num[i] And 1 = 1 Then C.num[i-1]:=500000000;
          End;
        C.num[1]:=C.num[1]+A.num[1] Shr 1;
        If C.num[C.leng]=0 Then Dec(C.leng);
End;}

Procedure plus(a,b:bignum;var c:bignum);
var
        i:longint;
begin
        with c do
                begin

                    fillchar(num,sizeof(num),0);
                    if a.leng>b.leng then leng:=a.leng else leng:=b.leng;

                    for i:=1 to leng do
                        begin
                           num[i]:=a.num[i]+b.num[i]+num[i];
                           if num[i]>base then
                                begin
                                    num[i+1]:=num[i] div base;
                                    num[i]:=num[i] mod base;
                                end;

                        end;

                    if num[leng+1]>0 then
                       inc(leng);
                end;
end;

Procedure subtract(a,b:bignum;var c:bignum);
var
        i:longint;
begin
        with c do
                begin
                    fillchar(num,sizeof(num),0);
                    if a.leng>b.leng then leng:=a.leng else leng:=b.leng;

                    for i:=1 to leng do
                        begin
                           num[i]:=a.num[i]-b.num[i]+num[i];
                           if num[i]<0 then
                                begin
                                    num[i+1]:=-1;
                                    num[i]:=num[i]+base;
                                end;
                        end;
                           if num[leng]=0 then dec(leng);

                end;
end;

Procedure Mul(A,B:BigNum;Var C:BigNum);
  Var i,j:longint;
      T1,T2:longint;
      CC:LLD;
  Begin
        FillChar(CC.num,SizeOF(CC.num),0);
        CC.Leng:=A.Leng+B.Leng;
        FillChar(C,SizeOF(C),0);
        For i:=1 To A.Leng Do
          For j:=1 To B.leng Do
            CC.num[i+j-1]:=CC.num[i+j-1]+Int64(A.num[i])*B.num[j];
        For i:=1 To CC.leng Do
          Begin
            If CC.num[i]>=Base Then
              Begin
                CC.num[i+1]:=CC.num[i+1]+CC.num[i] Div Base;
                CC.num[i]:=CC.num[i] Mod Base;
              End;
            C.num[i]:=CC.num[i];
          End;
        C.leng:=CC.leng;
        If C.num[C.leng]=0 Then Dec(C.leng);
  End;

Procedure Readfile;
var
        a,s:ansistring;
        i:integer;
        tmp:longint;
        z:longint;
        t:bignum;
Begin
        Assign(fi,finp);Reset(fi);
        Assign(fo,fout);Rewrite(fo);
        readln(fi,a);
        readln(fi,s);
        m:=length(a);
        n:=length(s);
        tmp:=1;
        for i:=m downto 1 do
        begin
                    val(a[i],d.num[tmp],g);
                    inc(tmp);
        end;
        d.leng:=m;
        tmp:=1;
        for i:=n downto 1 do
        begin
                    val(s[i],f.num[tmp],g);
                    inc(tmp);
        end;
        f.leng:=n;

        z:=max(m,n);

        for i:=z downto 1 do
                begin
                    if d.num[i]<f.num[i] then
                        begin
                                t:=d;
                                d:=f;
                                f:=t;
                                ok:=true;
                                break;
                        end;
                end;
        plus(d,f,e);
          for i:=e.leng downto 1 do
                write(fo,e.num[i]);

        writeln(fo);
        subtract(d,f,e);
        if ok=true then write(fo,'-');
                    for i:=e.leng downto 1 do
                write(fo,e.num[i]);
        writeln(fo);
        mul(d,f,e);
        for i:=e.leng downto 1 do
                write(fo,e.num[i]);


End;

Procedure Closefile;
Begin

        Close(fi);
        Close(fo);
End;

BEGIN
        Readfile;
        Closefile;
END.
