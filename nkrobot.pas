uses math;
const
	maxN = 10;
type
	mang = array[1..maxN] of longint;
    robot = record
    	num: longint;
        a: mang;
    end;
var	
	fi,fo: text;
	a,b,d,m: mang;
    rb: array[1..maxN] of robot;
    res: longint;


procedure input;
var
	i,j: longint;
    s: string;
    c: char;
begin
	for i:= 1 to 9 do
    begin
    	readln(fi,s);
    	rb[i].num:= length(s);

        with rb[i] do
        	for j:= 1 to num do
        		a[j]:= ord(s[j]) - ord('0');
    end;

	for i:= 1 to 9 do
    begin
    	read(fi,c);
        case c of
        	'T': a[i]:= 0;
            'X': a[i]:= 1;
            'V': a[i]:= 2;
        end;
    end;
    readln(fi);
end;

procedure move(i: longint);
var
	j: longint;
begin
	with rb[i] do
    	for j:= 1 to num do
        	b[a[j]]:= (b[a[j]] + 1) mod 3;
end;

function better(m: mang): boolean;
var	
	i: longint;
begin
	for i:= 1 to 9 do
    begin
    	if (m[i] > d[i]) then exit(true);
        if (m[i] < d[i]) then exit(false);
    end;
end;

function valid: boolean;
var	
	i: longint;
begin
	for i:= 1 to 9 do
    	if (b[i] <> 0) then exit(false);

    exit(true);
end;

procedure solve;
var	
	i,j,s: longint;
begin
	s:= 0;
    for i:= 1 to 9 do inc(s,m[i]);
    if (s > res) then exit;
    //
    b:= a;
    for i:= 1 to 9 do
    	for j:= 1 to m[i] do move(i);

    //
    if valid then
    	if (s = res) then
        begin
        	if better(m) then d:= m;
        end else
    	begin
    		res:= s;
        	d:= m;
    	end;
end;

procedure attempt(i: integer);
var	
	j: longint;
begin
	if (i > 9) then
    begin
    	solve;
        exit;
    end;
    //
    for j:= 0 to 2 do
    begin
    	m[i]:= j;
        attempt(i+1);
    end;
end;

procedure process;
var	
	i,j: longint;
begin
	res:= maxlongint;
    attempt(1);

    if (res = maxlongint) then writeln(fo,0)
    else
    for i:= 1 to 9 do
    	for j:= 1 to d[i] do
        	write(fo,i);
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
