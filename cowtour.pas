{
ID: ndchiph1
PROG: cowtour
LANG: PASCAL
}
uses math;
const
	maxN = 150;
    maxC = 200000 * maxN;

var
	fi,fo: text;
    dx,dy: array[1..maxN] of int64;
    d,dist: array[1..maxN,1..maxN] of real;
    a: array[1..maxN,1..maxN] of boolean;
	n: longint;
    diameter: real;


procedure input;
var	x,y: int64;
	i,j: longint;
	c: char;
begin
	readln(fi,n);
    for i:= 1 to n do readln(fi,dx[i],dy[i]);
    //
    for i:= 1 to n do
	begin
    	for j:= 1 to n do
        begin
        	read(fi,c);
			if (c = '1') then a[i,j]:= true;
        end;
        readln(fi);
    end;
end;


procedure floyd;
var	i,j,k: longint;
begin
	for i:= 1 to n do
    	for j:= 1 to n do dist[i,j]:= sqrt(sqr(dx[i]-dx[j]) + sqr(dy[i]-dy[j]));        	


    for i:= 1 to n do
    	for j:= 1 to n do
        begin
			if (i = j) then
            begin
            	d[i,j]:= 0;
                continue;
            end;
            if (a[i,j]) then d[i,j]:= dist[i,j]
            else d[i,j]:= maxC;
        end;

	//
	for k:= 1 to n do
    	for i:= 1 to n do
        	for j:= 1 to n do
            	if (d[i,j] > d[i,k] + d[k,j]) then d[i,j]:= d[i,k] + d[k,j];


    diameter:= 0;
    for i:= 1 to n do
    	for j:= i+1 to n do
        	if (d[i,j] < maxC) and (d[i,j] > diameter) then diameter:= d[i,j];
end;


procedure process;
var	i,j,k: longint;
	maxd,res,t: real;
begin
    res:= maxC;
    //
    for i:= 1 to n do
    	for j:= i+1 to n do
        	if (d[i,j] = maxC) then
            begin
            	t:= dist[i,j];

            	maxd:= 0;
				for k:= 1 to n do
                	if (d[k,i] < maxC) and (d[k,i] > maxd) then maxd:= d[k,i];	
                t:= t + maxd;

                maxd:= 0;
                for k:= 1 to n do
                	if (d[k,j] < maxC) and (d[k,j] > maxd) then maxd:= d[k,j];
                t:= t + maxd;


                t:= max(t,diameter);
           	 	if t < res then res:= t;
            end;

    writeln(fo,res:0:6);
end;


begin
	assign(fi,'cowtour.in'); reset(fi);
    assign(fo,'cowtour.out'); rewrite(fo);
	//
    input;
    floyd;
    process;
    //
    close(fi);
    close(fo);
end.
