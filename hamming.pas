{
ID: ndchiph1
PROG: hamming
LANG: PASCAL
}
uses math;
const
	MAX_N = 64;
    LM = 256;
var
	fi,fo: text;
    a: array[0..MAX_N] of longint;
    n,b,d: longint;
    maxval: longint;
    dist: array[0..LM,0..LM] of longint;


function getbit(x,y: longint): longint;
begin
	getbit:= (x shr y) and 1;
end;

procedure init;
var	i,j,k: longint;
begin
	maxval:= 1 shl b;
    fillchar(dist,sizeof(dist),0);

    //
	for i:= 1 to maxval do
    	for j:= i-1 downto 0 do
        	for k:= 0 to 7 do
            	if ( getbit(i,k) <> getbit(j,k) ) then inc(dist[i,j]);
end;

procedure printres;
var i: longint;
begin
	for i:= 0 to n-1 do
    begin
		if (i mod 10 = 0) then write(fo,a[i])
        else write(fo,' ',a[i]);

        //
        if (i mod 10 = 9) or (i = n-1) then writeln(fo);
    end;
end;


procedure attempt(i: longint);
var 	j,k: longint;
		valid: boolean;
begin
    for j:= a[i-1]+1 to maxval do
    begin
    	valid:= true;
        for k:= 0 to i-1 do
        begin
        	if (dist[j,a[k]] < d) then
            begin
				valid:= false;
                break;
            end;
        end;
		
        //
        if (valid) then
        begin
        	a[i]:= j;
            if (i = n-1) then
            begin
            	printres;
                close(fi); close(fo);
                halt;
            end else
            attempt(i+1);
        end;
    end;
end;


procedure process;
begin
	a[0]:= 0;
    attempt(1);
end;


begin
	assign(fi,'hamming.in'); reset(fi);
    assign(fo,'hamming.out'); rewrite(fo);
	//
    readln(fi,n,b,d);
    init;
    process;
    //
    close(fi);
    close(fo);
end.
