Const      INP     =     '' ;
           OUT     =     '' ;

Type       Mang    =     array[1..3]     of Integer ;
           Mang1   =     array[1..10000] of real    ;

Var        n       :     LongInt ;
           Tien    :     Double  ;
           A       :     array[1..10001] of Mang ;
           f       :     Text    ;

Procedure Swap( i , j : Integer) ;
Var
     tg : Mang ;
Begin
     tg := A[i]  ; A[i]  := A[j]  ; A[j]  := tg ;
End ;

Function Giatri(  i : Integer ) : Real ;
Begin
     Giatri := A[i,1] / A[i,2] ;
End ;

Procedure Quicksort( l , r : Integer ) ;
Var
     i , j : Integer ;
     Key   : Real    ;
Begin
     If l >= r then Exit ;
     Key := Giatri( l + Random(r-l+1) ) ;
     i := l ; j := r ;
     While i < j do Begin
           While Giatri(i) > Key do Inc(i) ;
           While Giatri(j) < Key do Dec(j) ;
           If i <= j then Begin
              If i < j then Swap( i , j ) ;
              Inc(i) ; Dec(j) ;
           End ;
     End ;
     Quicksort(l,j) ; Quicksort(i,r) ;
End ;

Procedure Init ;
Var
     i : Integer ;
Begin
     For i := 1 to n do A[i,3] := i ;
     Quicksort(1,n) ;
End ;

Procedure Process ;
Var
     i , bd , kt : Integer ;
     S           : Double  ;
Begin
     S := 0 ;
     For i := 1 to n do S := S + A[i,1] ;
     For i := 1 to n do Begin
         Tien := Tien + S * A[i,2] ;
         S := S - A[i,1] ;
     End ;
End ;

Procedure KetQua ;
Var
     i : Integer ;
Begin
     Assign(f,OUT) ;
     Rewrite(f)    ;
     Writeln(f,Tien:0:0) ;
     For i := 1 to n do Write(f,A[i,3],' ') ;
     Close(f)      ;
End ;

Procedure Nhapdl ;
Var
     i : Integer   ;
Begin
     Assign(f,INP) ;
     Reset(f)      ;
     Readln(f,n)   ;
     For i := 1 to n do Read(f,A[i,1]) ;
     For i := 1 to n do Read(f,A[i,2]) ;
     Close(f)      ;
End ;

BEGIN
     Nhapdl ;
     Init   ;
     Process;
     KetQua ;
END.