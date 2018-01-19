uses math;

const FILEINP = 'totalodd.in1';
      FILEOUT = 'totalodd2.out';
      Num : array [ 1 .. 5 ] Of char = ( '1' , '3' , '5' , '7' , '9' ) ;
      MaxD = 500000 ;

Var f1 , f2 : text;

	A : array [ 0 .. MaxD ] Of Longint ;

    n , x : longint ;

    st : string ;
 	
procedure Open_f;
    begin
        assign(f1, FILEINP);
        reset(f1);
        assign(f2, FILEOUT);
        rewrite(f2);
    end;

procedure Input;
    begin

    	readln ( f1 , x ) ;

    end;

procedure select ( count : longint ; str : string ) ;
	
    var i , value : longint ;

    begin

    	if count = 0 then

        	begin

            	val ( str , value ) ;

                inc ( n ) ;

                A [ n ] := value ;

                exit ;

            end ;

        for i := 1 to 5 do select ( count - 1 , str + num [ i ] ) ;

    end ;

procedure Init;

	var i : longint ;

    begin

        for i := 1 to 8 do select ( i , '' ) ;

    end;

procedure Solve;

	var i , k , L , R , Mid , res : longint ;

    begin

    	L := 1 ;

        R := n ;

        while L < R do

        	begin

            	Mid := ( L + R ) div 2 ;

                if A [ Mid ] >= x then R := Mid

                else L := Mid + 1 ;

            end ;

        k := L ;

        i := 1 ;

        if x = 100000000 then

        	begin

            	writeln ( f2 , x ) ;

                exit ;

            end ;

        res := MaxLongint ;

        while i <= k do

        	begin

            	if A [ i ] + A [ k ] >= x then

                	begin

                    	if A [ i ] + A [ k ] < res then res := A [ i ] + A [ k ] ;

                        if res = x then break ;

                        dec ( k ) ;

                    end

                else inc ( i ) ;

            end ;

        writeln ( f2 , res ) ;

    end;


procedure Output;
    begin
    end;

procedure Close_f;
    begin
        close(f1);
        close(f2);
    end;

begin

    Open_f;

    Init ;

    Readln ( f1 , st ) ;

    while st <> '[CASE]' do readln ( f1 , st );

    while not ( st = '[END]' ) do

    	begin

    		Input;

		    Solve;
		
            Output;

		    Readln ( f1 , st ) ;

		    while ( st <> '[CASE]' ) or ( st = '[END]' ) do

    			if st = '[END]' then Break

		        else readln ( f1 , st ) ;

	    End ;

    Close_f;
end.
