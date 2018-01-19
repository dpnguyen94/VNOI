const
	f='FAILED';
    s='SUCCESS';
var
	A,B:set of char;
    q,i:longint;
    y,x:char;
    m:string;
begin
	readln(q);
    for i:=1 to q do
    begin
    	readln(m);
    	y:=m[1];
   	 	x:=m[2];
    case y of
    'A': if x in A then writeln(f)
        	else
        	begin
        		writeln(s);
        		A:=A+[x]
        	end;
    'B': if x in B then writeln(f)
    		else
            begin
            	writeln(s);
                B:=B+[x]
            end;
    'C': if not(x in A) then writeln(f)
    		else
        	begin
        		writeln(s);
            	A:=A-[x]
        	end;
    'D': if not(x in B) then writeln(f)
    		else
            begin
            	writeln(s);
                B:=B-[x]
            end;
	'S': if x='A' then writeln(A<=B)
    		else writeln(B<=A);
    'E': writeln(A=B)
    end;
	end;
end.
