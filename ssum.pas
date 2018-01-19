uses math ;
const fi = 'SSUM.inp' ;
	  fo = 'SSUM.out' ;
      MaxK = 60 ;
      Base = 1000000007 ;

var f1 , f2 : text ;

	n , k  : Longint ;

    res : int64 ;

    A , B : array [ 0 .. MAxk ] OF Longint ;

procedure open_f ;
	begin
    	assign ( f1 , fi ) ;
        reset ( f1 ) ;
        assign ( f2 , fo ) ;
        rewrite ( f2 ) ;
    end ;

procedure close_f ;
	begin
    	close ( f1 ) ;
        close ( f2 ) ;
    end ;

procedure input ;
	begin

    	readln ( f1 , k , n ) ;

        if ( n = 0 ) and ( k = 0 ) then

        	begin

            	close_f ;

                Halt ;

            end ;

    end ;

procedure init ;
	begin

    	fillchar ( A , sizeof ( A ) , 0 ) ;

        fillchar ( B , Sizeof ( B ) , 0 ) ;

    end ;

function UCLN ( x , y : int64 ) : longint ;

	begin

    	while x * y <> 0 do

        	if x > y then x := x mod y

            else y := y mod x ;

        exit ( x + y ) ;

    end ;

procedure solve;

	var i , j , d : Longint ;

	begin

        for i := 1 to k + 1 do

        	begin

            	A [ i ] := i + n - 1;

                B [ i ] := i ;

            end ;

        For i := 1 to k + 1 do

        	for j := 1 to k + 1 do

            	begin

                	d := UCLN ( A [ i ] , B [ j ] ) ;

                    A [ i ] := A [ i ] div d ;

                    B [ j ] := B [ j ] div d ;

                end ;

        res := 1 ;

        For i := 1 to k + 1 do

        	res := ( res * A [ i ] ) Mod Base ;

    end ;

procedure output;
	begin

    	writeln ( f2 , res ) ;

    end ;

begin
	open_f ;

    while True do

    	begin

		    input ;
		    init ;
		    solve ;
		    output ;

        end ;

    close_f ;
end .
