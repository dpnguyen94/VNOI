{
ID: ndchiph1	
PROG: holstein
LANG: PASCAL
}
uses math;
const
	MAX_V = 25;
    MAX_G = 15;	
var
	fi,fo: text;
    vn,gn,res: longint;
    v: array[1..MAX_V] of longint;
    g: array[1..MAX_G,1..MAX_V] of longint;
    d,a: array[1..MAX_G] of longint;


procedure input;
var 	i,j: longint;
begin
	readln(fi,vn);
    for i:= 1 to vn do read(fi,v[i]);
    readln(fi,gn);
    for i:= 1 to gn do
    begin
		for j:= 1 to vn do read(fi,g[i,j]);
        readln(fi);
    end;	
end;


procedure process2;
var 	i,j,t,cnt: longint;
		valid: boolean;
begin
	cnt:= 0;
	for i:= 1 to gn do
    	if (a[i] = 1) then inc(cnt);
    if (cnt >= res) then exit;

    //
	valid:= true;
	for j:= 1 to vn do
    begin
    	t:= 0;
        for i:= 1 to gn do
        	if (a[i] = 1) then inc(t,g[i,j]);

        //
        if (t < v[j]) then
        begin
        	valid:= false;
            break;
        end;
    end;

    //
    if (valid) then
    begin
    	res:= cnt;
    	for i:= 1 to gn do d[i]:= a[i];
    end;
end;

procedure attempt(i: longint);
var	j: longint;
begin
	if (i > gn) then
    begin
    	process2;
        exit;
    end;

    //
    for j:= 1 downto 0 do
    begin
    	a[i]:= j;
        attempt(i+1);
    end;
end;


procedure process;
var	i: longint;
begin
	res:= maxlongint;
	attempt(1);

	write(fo,res);

    for i:= 1 to gn do
    	if (d[i] = 1) then write(fo,' ',i);
    writeln(fo);
end;


begin
	assign(fi,'holstein.in'); reset(fi);
    assign(fo,'holstein.out'); rewrite(fo);
	//
    input;
    process;

    //
    close(fi);
    close(fo);
end.
