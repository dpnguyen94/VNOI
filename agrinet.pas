{
ID: ndchiph1
PROG: agrinet
LANG: PASCAL
}
uses math;
const
	maxN = 110;
    maxC = 100000 * maxN * maxN;
var
	fi,fo: text;
    n: longint;
    c: array[0..maxN,0..maxN] of longint;
    d: array[0..maxN] of int64;
    vs: array[0..maxN] of boolean;
    t: array[0..maxN] of longint;

    	
procedure input;
var	
	i,j: longint;
begin
	readln(fi,n);
    for i:= 1 to n do
    	for j:= 1 to n do read(fi,c[i,j]);
    //init;
	d[1]:= 0;
    for i:= 2 to n do d[i]:= maxC;
end;

procedure process;
var	
	k,i,u: longint;
	min_d: int64;
begin
    for k:= 1 to n do
	begin
    	//
		u:= 0; min_d:= maxC;
    	for i:= 1 to n do
    		if not vs[i] and (d[i] < min_d) then
        	begin
				u:= i;
            	min_d:= d[i];
        	end;
    	
        //
    	vs[u]:= true;
	
        //
        for i:= 1 to n do
    		if not vs[i] and (d[i] > c[u,i]) then begin
        		d[i]:= c[u,i];
            	t[i]:= u;
        	end;
    end;
end;

procedure output;
var
	i: longint;
    res: int64;
begin
	res:= 0;
    for i:= 2 to n do inc(res,c[t[i],i]);

    writeln(fo,res);
end;

begin
	assign(fi,'agrinet.in'); reset(fi);
    assign(fo,'agrinet.out'); rewrite(fo);
	//
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
