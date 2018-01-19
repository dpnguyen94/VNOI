uses math ;
const FILEINP = 'allow.inp';
      FILEOUT = '';
      Maxn = 20 ;

Var f1 , f2 : text;

	A , Count , c : array [ 0 .. Maxn ] Of longint ;

    n , m , res : longint ;

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

	var i , k , x , y : longint ;

    begin

    	readln ( f1 , k , m ) ;

        for i := 1 to k do

        	begin

            	readln ( f1 , x , y ) ;

                if x >= m then inc ( res , y )

                else

                	begin

                    	inc ( n ) ;

                        A [ n ] := x ;

                        Count [ n ] := y ;

                    end ;	

            end ;

    end;

procedure swap ( var x , y : longint  ) ;

	var tmp : longint ;

    begin

    	tmp := x ;

        x := y ;

        y := tmp ;

    end ;

procedure Init;

	var i ,  j : longint ;

    begin

    	for i := 1 to n - 1 do

        	for j := i + 1 to n do

            	if a [ i ] < a [ j ] then

                	begin

                    	swap ( a [ i ] , a [ j ] ) ;

                        swap ( count [ i ] , count [ j ] ) ;

                    end ;

    end;

procedure solve ;

	var i , tmp , minc , k : longint;

	begin
    	
        while TRUE do
        	
            begin

            	minc := 1000000000 ;

                k := m ;

                fillchar ( c , sizeof ( c ) , 0 ) ;

            	for i := 1 to n do

                    begin

                    	tmp := k div A [ i ] ;

                        tmp := min ( tmp , count [ i ] ) ;

                        c [ i ] := tmp ;

                        k := k - A [ i ] * C [ i ] ;

                    end ;

                if k > 0 then
                	
                    begin

                    	for i := n downto 1 do
                        	
                            if c [ i ] < count [ i ] then
                            	
                                begin
                                	
                                    inc ( c [ i ] ) ;

                                	dec ( k , a [ i ] ) ;

                                    break ;

                                end ;

                    end ;

                if k > 0 then Exit ;

                for i := 1 to n do

                	if c [ i ] > 0 then

                    	minc := min ( minc , count [ i ] div c [ i ] ) ;

                res := res + minc ;

                for i := 1 to n do count [ i ] := count [ i ] - minc * c [ i ] ;

            end ;

    end ;

procedure Output;
    begin

    	writeln ( f2 , res) ;

    end;

begin
    Open_f;
    Input;
    Init;
    Solve;
    Output;
    Close_f;
end.
