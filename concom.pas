uses math;
const
	MAX_N = 110;

type
	mang = array[1..MAX_N] of boolean;
	
var
	fi,fo: text;
	control: array[1..MAX_N,1..MAX_N] of boolean;
    own: array[1..MAX_N,1..MAX_N] of longint;
    n: longint;


procedure input;
var 	i,a,b: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    begin 	
    	readln(fi,a,b,own[a,b]);
        table1[a]:= true;
        table2[b]:= true;
    end;	
end;


procedure process;
var 	i,j: longint;
		exist: boolean;
begin
	

end;


begin
	assign(fi,'concom.in'); reset(fi);
    assign(fo,'concom.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
