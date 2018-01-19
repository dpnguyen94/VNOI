{$INLINE ON}

uses math;

const FILEINP = '';
      FILEOUT = '';
      Maxn = 40 + 10 ;
      MaxSize = 1048576 + 10 ;

type arr = array [ 0 .. MaxSize ] Of Longint ;

Var f1 , f2 : text;

	m , n , count1 , count2 , res : longint ;

    b : array [ 1 .. 20 ] Of Boolean ;

    W , V : array [ 0 .. Maxn ] Of longint ;

    w1 , v1 , w2 , v2 : arr ;

procedure Open_f;
    begin
        assign(f1, FILEINP);
        reset(f1);
        assign(f2, FILEOUT);
        rewrite(f2);
    end;

procedure Input;

	var i : longint ;

    begin

    	readln ( f1 , n , m ) ;

        for i := 1 to n do

        	readln ( f1 , w [ i ] , v [ i ] ) ;

    end;

procedure process ; inline ;

	var i , sum1 , sum2 , val1 , val2  : longint ;

    begin

    	sum1 := 0 ;

        sum2 := 0 ;

        val1 := 0 ;

        val2 := 0 ;

    	inc ( count1 ) ;

        inc ( count2 ) ;

    	for i := 1 to n div 2 do

        	if b [ i ] then

            	begin

                	sum1 := sum1 + w [ i ] ;

                    val1 := val1 + v [ i ] ;

                    sum2 := sum2 + w [ i + n div 2 ] ;

                    val2 := val2 + v [ i + n div 2 ] ;

                end ;

        w1 [ count1 ] := sum1 ;

        w2 [ count2 ] := sum2 ;

        v1 [ count1 ] := val1 ;

        v2 [ count2 ] := val2 ;

        if n mod 2 = 1 then

           begin

                inc ( count2 ) ;
                        	
                w2 [ count2 ] := sum2 + w [ n ] ;

                v2 [ count2 ] := val2 + v [ n ] ;

           end ;


    end ;

procedure attemp ( x : longint ) ; inline ;

	begin

    	if x > n div 2 then

        	process

        else

        	begin

                b [ x ] := false ;

                attemp ( x + 1 ) ;

                b [ x ] := true ;

                attemp ( x + 1 ) ;

            end ;

    end ;

procedure swap ( var x , y : longint ) ;  inline ;

	var tmp : longint;

    begin

    	tmp := x ;

        x := y ;

        y := tmp ;

    end ;

procedure Sort1 ( L , R : longint ) ;  inline ;

    	var i , j , Pivot : longint ;

        begin

        	i := L ;

            j := R ;

            Pivot := W1 [ Random ( R - L + 1 ) + L ] ;

            Repeat

            	while W1 [ i ] < Pivot do inc ( i ) ;

                While W1 [ j ] > Pivot do dec ( j ) ;

                if i <= j then

                	begin

                    	swap ( W1 [ i ] , W1 [ j ] ) ;

                        swap ( V1 [ i ] , V1 [ j ] ) ;

                        inc ( i ) ;

                        dec ( j ) ;

                    end ;

            until i > j ;

            if i < R then Sort1 ( i , R ) ;

            if L < j then sort1 ( L , j ) ;

        end ;

procedure Sort2 ( L , R : longint ) ;  inline ;

    	var i , j , Pivot : longint ;

        begin

        	i := L ;

            j := R ;

            Pivot := W2 [ Random ( R - L + 1 ) + L ] ;

            Repeat

            	while W2 [ i ] < Pivot do inc ( i ) ;

                While W2 [ j ] > Pivot do dec ( j ) ;

                if i <= j then

                	begin

                    	swap ( W2 [ i ] , W2 [ j ] ) ;

                        swap ( V2 [ i ] , V2 [ j ] ) ;

                        inc ( i ) ;

                        dec ( j ) ;

                    end ;

            until i > j ;

            if i < R then Sort2 ( i , R ) ;

            if L < j then sort2 ( L , j ) ;

        end ;


procedure init;

	var i : longint ;

	begin

    	attemp ( 1 ) ;

        Sort1 ( 1 , Count1 ) ;

        Sort2 ( 1 , Count2 ) ;

        for i := 2 to count1 do

        	V1 [ i ] := Max ( V1 [ i ] , V1 [ i - 1 ] ) ;

        for i := 2 to count2 do

        	V2 [ i ] := Max ( V2 [ i ] , V2 [ i - 1 ] ) ;

    end ;

procedure Solve;

	var i , j , k : longint ;

    begin

        res := 0 ;

        k := count2 ;
                  	
		for i := 1 to count1 do

        	for j := k downto 1 do

                if W1 [ i ] + W2 [ j ] <= m then

                	begin

                    	k := j ;

                        res := max ( V1 [ i ] + V2 [ j ] , res ) ;

                        break ;

                    end ;
            	

    end;


procedure Output;
    begin

    	writeln ( f2 , res ) ;

    end;

procedure Close_f;
    begin
        close(f1);
        close(f2);
    end;

begin
    Open_f;
    Input;
    Init;
    Solve;
    Output;
    Close_f;
end.
