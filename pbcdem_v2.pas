uses math;
const
	maxN = 4000;
    maxS = 100;
    LM = 1000000000;
type 	
	bignum = record
    	len: longint;
		a: array[0..10] of longint;
    end;
var
	fi,fo: text;
	f: array[0..maxN,0..maxS] of bignum;
    n: longint;
    res: bignum;

procedure input;
begin
	readln(fi,n);
end;



procedure add(x,y: bignum; var c: bignum);
var	i: longint;
begin
	with c do
    begin
    	len:= max(x.len,y.len);
		
        for i:= 1 to len do
        begin
        	inc(a[i],x.a[i] + y.a[i]);
            if (a[i] >= LM) then
            begin
            	a[i]:= a[i] - LM;
                a[i+1]:= 1;
            end;
        end;

        if (a[len+1] > 0) then inc(len);
    end;
end;


procedure setf(var x: bignum);
begin
	with x do
    begin
    	len:= 1;
        a[1]:= 0;
    end;
end;


procedure process;
var	i,j: longint;
begin
	for i:= 1 to n do setf(f[i,j]);
	for i:= 1 to n do
    begin
        for j:= 1 to maxS do
        	if (i >= j) then add(f[i-j,j],f[i-j,j-1],f[i,j]);
    end;

    for i:= 2 to 100 do add(res,f[n,i],res);
end;


function count(x: longint): longint);
var 	t: longint;
begin
	t:= 0;
    while (x > 0) do
    begin
    	inc(t);
        x:= x div 10;
    end;
end;

procedure output;
var	i: longint;
begin
	with res do
    begin
		for i:= len downto 1 do
    	begin

        	
   	 	end;

end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
