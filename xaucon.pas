{$R+,Q+}
const fi = '' ;
	  fo = '' ;
      Maxn = 100000 + 10 ;

var f1 , f2 : text ;

	st : ansistring ;

	n : longint ;

    a : array [ 0 .. Maxn ] of longint ;

    s : array [ -Maxn .. Maxn ] Of longint ;

    res : int64 ;

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

    	readln ( f1 , st ) ;

    end ;

procedure init ;
	begin

    	n := length ( st ) ;

        fillchar ( s , sizeof ( s ) , 0 ) ;

        s [ 0 ] := 1 ;

        a [ 0 ] := 0 ;

        res := 0 ;

    end ;

function cal ( x : longint ) : int64 ;

	begin

    	if x < 2 then exit ( 0 )

        else exit ( ( ( x - 1 ) * x ) div 2 ) ;

    end ;

procedure solve ;

	var i : longint ;

	begin

    	{ tinh chenh lech }

    	for i := 1 to n do

        	if st [ i ] = 'a' then

            	begin
				
               		a [ i ] := a [ i - 1 ] + 1 ;

                    inc ( s [ a [ i ] ] ) ;

                end

            else

            	begin

                	a [ i ] := a [ i - 1 ] - 1 ;

                    inc ( s [ a [ i ] ] ) ;

                end ;


            for i := -n to n do

				res := res + cal ( s [ i ]  ) ;


    end ;

procedure output ;
	begin

    	writeln ( f2 , res ) ;

    end ;

begin
	open_f ;
    input ;
    init ;
    solve ;
    output ;
    close_f ;
end .
