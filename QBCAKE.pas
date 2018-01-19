uses math;

const FILEINP = '';
      FILEOUT = '';
      Maxn = 1500 ;
      oo = 1000000000 ;

Var f1 , f2 : text;

	Tx , Ty : array [ 0 .. Maxn ] Of longint ;

    n : longint;

    res : double ;

procedure Open_f;
    begin
        assign(f1, FILEINP);
        reset(f1);
        assign(f2, FILEOUT);
        rewrite(f2);
    end;

procedure Close_f;
    begin
        close(f1);
        close(f2);
    end;

procedure Input;

	var i : longint ;

    begin

        readln ( f1 , n ) ;

        for i := 1 to n do readln ( f1 , Tx [ i ] , Ty [ i ] ) ;
    	
    end;

procedure Init;
    begin
    end;

function DienTich ( i , j , t : longint ) : double ;

	begin

    	DienTich := ( Tx [ i ] - Tx [ j ] ) * ( Ty [ i ] + Ty [ j ] )

        		+   ( Tx [ j ] - Tx [ t ] ) * ( Ty [ j ] + Ty [ t ] )

                +   ( Tx [ t ] - Tx [ i ] ) * ( Ty [ t ] + Ty [ i ] ) ;

    	DienTich := abs ( DienTich ) / 2 ;

    end ;

procedure solve ;

	var i , j , t , l , r : longint;

    	MaxL , MaxR , tmp : Double ;

	begin
    	
        for i := 1 to n - 2 do

        	begin

            	l := i + 1 ;

                r := i + 3 ;

                for j := i + 2 to n do

                	begin

                    	MaxL := -oo ;

                        MaxR := -oo ;

                        while l < j do

                        	begin

                            	tmp := DienTich ( i , j , l ) ;

                                if tmp > MaxL then MaxL := tmp else Break ;

                                inc ( l ) ;

                            end ;

                        dec ( l ) ;

                        while r <= n do
                        	
                            begin

                            	tmp := DienTich ( i , j , r ) ;

                                if tmp > MaxR then MaxR := tmp else Break ;

                                inc ( r ) ;

                            end ;

                        dec ( r ) ;

                        if MaxL + MaxR > res then res := MaxL + MaxR ;

                    end ;

            end ;

    end ;

procedure Output;
    begin

    	writeln ( f2 , res : 0 : 1 ) ;

    end;

begin
    Open_f;
    Input;
    Init;
    Solve;
    Output;
    Close_f;
end.
