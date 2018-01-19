Const
     Fin='lqddiv.in1';
     Fout='lqddiv.out';
     MaxN=32;
Var
   Fi,Fo:Text;
   n,mA,mB,count:Longint;
   a:Array[0..MaxN]Of Longint;
   FA,FB,tmp,cnta:Array[0..1 shl 16-1]Of Longint;
Procedure ReadFile;
Var
   i:Longint;
Begin
     Assign(Fi,Fin);Reset(Fi);
     Assign(Fo,Fout);Rewrite(Fo);
     Read(Fi,n);
     For i:=1 to n do Read(Fi,a[i]);
     mA:=1  shl (n div 2) -1;
     mB:=1 shl(n-n div 2)-1;
End;
Procedure Sort(l,h:Longint);
Var
   i,j,Key,temp:Longint;
Begin
     If l>=h then Exit;
     i:=l;j:=h;
     Key:=FA[(l+h)div 2];
     Repeat
           While(FA[i]<Key)Do Inc(i);
           While(FA[j]>Key)Do Dec(j);
           If i<=j then
            Begin
                 If i<j then
                  Begin
                       temp:=FA[i];FA[i]:=FA[j];FA[j]:=temp;
                  End;
                 Inc(i);
                 Dec(j);
            End;
     Until i>j;
     Sort(l,j);
     Sort(i,h);
End;
Procedure Init;
Var
   i,j:Longint;
Begin
     For i:=0 to mA do
      Begin
           FA[i+1]:=0;
           For j:=1 to (n div 2) do
                 If(i shr(j-1)and 1=1)then FA[i+1]:=FA[i+1]+a[j]
                 Else FA[i+1]:=FA[i+1]-a[j];
      End;
     Sort(1,mA+1);
     Inc(mA);
     count:=0;
     FA[0]:=-MaxLongint;
     For i:=1 to mA do
      If FA[i]<>FA[i-1] then
       Begin
            Inc(count);
            tmp[count]:=FA[i];
            cnta[count]:=1;
       End
      Else Inc(cnta[count]);
     mA:=count;
     Fillchar(FA,SizeOf(FA),0);
     FA:=tmp;
     For i:=0 to mB do
      Begin
           FB[i+1]:=0;
           For j:=1 to (n-n div 2) do
                 If(i shr(j-1)and 1=1)then FB[i+1]:=FB[i+1]+a[j+ n div 2]
                 Else FB[i+1]:=FB[i+1]-a[j+ n div 2];
      End;
     Inc(mB);
//     For i:=1 to mB do
//      Writeln(Fo,FB[i]);
End;
Function FindMin(x:Longint):Longint;
Var
   First,Mid,Last,res,temp:Longint;
Begin
     First:=1;Last:=mA;
     Repeat
           Mid:=(First+Last)shr 1;
           temp:=FA[Mid];
           If temp=x then Exit(-1);
           If temp>x then
            Begin
                 res:=Mid;
                 Last:=Mid-1;
            End
        //   If temp<x then
           Else
                 First:=Mid+1;
     until First>Last;
     Exit(res);
End;
Function FindMax(x:Longint):Longint;
Var
   First,Mid,Last,temp,res:Longint;
Begin
     First:=1;Last:=mA;
     Repeat
           Mid:=(First+Last)shr 1;
           temp:=FA[Mid];
           If temp=x then Exit(Mid);
           If temp<x then
            Begin
                 res:=Mid;
                 First:=Mid+1;
            End
           Else
            Last:=Mid-1;
     Until First>Last;
     Exit(res);
End;
Procedure Solve;
Var
   i,res,result,cntres,temp,minres:Longint;
Begin
     cntres:=0;
     minres:=MaxLongint;
//     For i:=1 to count do
//      Writeln(Fo,FA[i],' ',cnta[i]);
    For i:=1 to mB do
     Begin
          temp:=-FB[i];
          If temp>=FA[1] then
           Begin
                res:=FindMax(temp);
                result:=abs(FA[res]+FB[i]);
                If result<minres then
                 Begin
                      minres:=result;
                      cntres:=cnta[res];
                 End
                Else
                 If result=minres then Inc(cntres,cnta[res]);
           End;
          If temp<=FA[mA] then
           Begin
                res:=FindMin(temp);
                If res<>-1 then
                Begin
                     result:=abs(FA[res]+FB[i]);
                     If result<minres then
                      Begin
                           minres:=result;
                           cntres:=cnta[res];
                      End
                     Else
                      If result=minres then Inc(cntres,cnta[res]);
                End;
           End;
     End;
    Writeln(Fo,minres,' ',cntres div 2);
End;
BEGIN
     ReadFile;
     Init;
     Solve;
     Close(Fi);
     Close(Fo);
END.
