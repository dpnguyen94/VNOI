{
ID: ndchiph1
PROG: lamps
LANG: PASCAL
}
uses math;
const
	MAX_N = 100;
type
	mang = array[1..MAX_N] of longint;
var
	fi,fo: text;
    onst,offst: array[0..MAX_N] of longint;
    a: array[1..4] of longint;
    b: mang;
    n,c,cnt: longint;
    d: array[1..16,1..MAX_N] of longint;

procedure input;
var	i: longint;
begin
	readln(fi,n);
    readln(fi,c);

    onst[0]:= 0;
    while TRUE do
    begin
    	read(fi,i);
        if (i = -1) then break;
        inc(onst[0]);
        onst[onst[0]]:= i;
    end;

    offst[0]:= 0;
    while TRUE do
    begin
    	read(fi,i);
        if (i = -1) then break;
        inc(offst[0]);
        offst[offst[0]]:= i;
    end;
end;


procedure button1;
var	i: longint;
begin
	for i:= 1 to n do b[i]:= (b[i]+1) mod 2;
end;

procedure button2;
var i: longint;
begin
	for i:= 1 to n do
    	if (i mod 2 = 1) then b[i]:= (b[i]+1) mod 2;
end;

procedure button3;
var	i: longint;
begin
	for i:= 1 to n do
    	if (i mod 2 = 0) then b[i]:= (b[i]+1) mod 2;
end;

procedure button4;
var	i: longint;
begin
	for i:= 1 to n do
    	if ( (i-1) mod 3 = 0) then b[i]:= (b[i]+1) mod 2;
end;

procedure isvalid;
var		i,t: longint;
		valid: boolean;
begin
    t:= 0;
    for i:= 1 to 4 do
    	if a[i] = 1 then inc(t);
    if (t > c) or (t mod 2 <> c mod 2) then exit;

	for i:= 1 to n do b[i]:= 1;
	for i:= 1 to 4 do
		if a[i] = 1 then
        begin
        	case i of
            	1: button1;
                2: button2;
                3: button3;
                4: button4;
            end;
        end;

    //
    valid:= true;
    for i:= 1 to onst[0] do
    	if b[onst[i]] = 0 then
        begin
        	valid:= false;
            break;
        end;

    for i:= 1 to offst[0] do
    	if b[offst[i]] = 1 then
        begin
        	valid:= false;
            break;
        end;

    //
    if valid then
    begin
		inc(cnt);
        for i:= 1 to n do d[cnt,i]:= b[i];
    end;
end;


procedure attempt(i: longint);
var 	j: longint;
begin
	if (i > 4) then
    begin
    	isvalid;
    	exit;
    end;

    //
    for j:= 0 to 1 do
    begin
    	a[i]:= j;
        attempt(i+1);
    end;
end;


function cmp(x,y: mang): boolean;
var	i: longint;
begin
	for i:= 1 to n do
    begin
		if (x[i] > y[i]) then exit(true);
        if (x[i] < y[i]) then exit(false);
    end;
end;

procedure sort;
var 	i,j,z,k: longint;
begin
	for i:= 1 to cnt-1 do
    	for j:= i+1 to cnt do
        	if cmp(d[i],d[j]) then
				for k:= 1 to n do
                begin
                	z:= d[i,k]; d[i,k]:= d[j,k]; d[j,k]:= z;
                end;
end;

procedure process;
var 	i,j: longint;
begin
	cnt:= 0;
	attempt(1);

    if (cnt = 0) then writeln(fo,'IMPOSSIBLE');

    sort;
    for i:= 1 to cnt do
    begin
    	for j:= 1 to n do write(fo,d[i,j]);
        writeln(fo);
    end;
end;



begin
	assign(fi,'lamps.in'); reset(fi);
    assign(fo,'lamps.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
