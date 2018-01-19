{
ID: ndchiph1
PROG: clocks
LANG: PASCAL
}

uses math;
type
	mang = array[1..9] of integer;
var	
	fi,fo: text;
	a,b,d,m: mang;
    res: integer;

procedure input;
var i: integer;
begin
	for i:= 1 to 9 do begin
    	read(fi,a[i]);
        a[i]:= a[i] div 4;
    end;
end;

procedure move1;
begin
	b[1]:= (b[1]+1) mod 4;
    b[2]:= (b[2]+1) mod 4;
    b[4]:= (b[4]+1) mod 4;
    b[5]:= (b[5]+1) mod 4;
end;

procedure move2;
begin
	b[1]:= (b[1]+1) mod 4;
    b[2]:= (b[2]+1) mod 4;
    b[3]:= (b[3]+1) mod 4;
end;

procedure move3;
begin
	b[2]:= (b[2]+1) mod 4;
    b[3]:= (b[3]+1) mod 4;
    b[5]:= (b[5]+1) mod 4;
    b[6]:= (b[6]+1) mod 4;
end;

procedure move4;
begin
	b[1]:= (b[1]+1) mod 4;
    b[4]:= (b[4]+1) mod 4;
    b[7]:= (b[7]+1) mod 4;
end;

procedure move5;
begin
	b[2]:= (b[2]+1) mod 4;
    b[4]:= (b[4]+1) mod 4;
    b[5]:= (b[5]+1) mod 4;
    b[6]:= (b[6]+1) mod 4;
    b[8]:= (b[8]+1) mod 4;
end;

procedure move6;
begin
	b[3]:= (b[3]+1) mod 4;
    b[6]:= (b[6]+1) mod 4;
    b[9]:= (b[9]+1) mod 4;
end;

procedure move7;
begin
	b[4]:= (b[4]+1) mod 4;
    b[5]:= (b[5]+1) mod 4;
    b[7]:= (b[7]+1) mod 4;
    b[8]:= (b[8]+1) mod 4;
end;

procedure move8;
begin
	b[7]:= (b[7]+1) mod 4;
    b[8]:= (b[8]+1) mod 4;
    b[9]:= (b[9]+1) mod 4;
end;

procedure move9;
begin
	b[5]:= (b[5]+1) mod 4;
    b[6]:= (b[6]+1) mod 4;
    b[8]:= (b[8]+1) mod 4;
    b[9]:= (b[9]+1) mod 4;
end;

function better(d: mang): boolean;
var	i: integer;
begin
	for i:= 1 to 9 do
    begin
    	if (d[i] > m[i]) then exit(true);
        if (d[i] < m[i]) then exit(false);
    end;
end;

function valid: boolean;
var	i: integer;
begin
	for i:= 1 to 9 do
    	if (b[i] <> 3) then exit(false);

    exit(true);
end;

procedure process2;
var	i,j,s: integer;
begin
	s:= 0;
    for i:= 1 to 9 do inc(s,m[i]);
    if (s > res) then exit;
    //
    b:= a;
    for i:= 1 to 9 do
    begin
    	case i of
        	1: for j:= 1 to m[i] do move1;
        	2: for j:= 1 to m[i] do move2;
        	3: for j:= 1 to m[i] do move3;
        	4: for j:= 1 to m[i] do move4;
        	5: for j:= 1 to m[i] do move5;
        	6: for j:= 1 to m[i] do move6;
        	7: for j:= 1 to m[i] do move7;
        	8: for j:= 1 to m[i] do move8;
        	9: for j:= 1 to m[i] do move9;
        end;
    end;

    //
    if valid then
    	if (s = res) then
        begin
			if better(d) then d:= m;       	
        end else
        begin
        	res:= s;
            d:= m;
        end;
end;

procedure attempt(i: integer);
var	j: integer;
begin
	if (i > 9) then
    begin
    	process2;
        exit;
    end;
    //
    for j:= 0 to 3 do
    begin
    	m[i]:= j;
        attempt(i+1);
    end;
end;

procedure process1;
var	i,j: integer;
	first: boolean;
begin
	res:= maxint;
    attempt(1);

    first:= true;
    for i:= 1 to 9 do
    begin
    	for j:= 1 to d[i] do
        begin
        	if not first then write(fo,' ');
            write(fo,i);
            first:= false;
        end;
    end;
    writeln(fo);
end;

begin
	assign(fi,'clocks.in'); reset(fi);
	assign(fo,'clocks.out'); rewrite(fo);
    //
    input;
    process1;

    //
    close(fi);
	close(fo);
end.
