{
ID: ndchiph1
PROG: prefix
LANG: PASCAL
}
uses math;
const
    MAX_P = 210;
    MAX_S = 200000;
var
	fi,fo: text;
    s: ansistring;
    p: array[1..MAX_P] of string;
    np,last: longint;
    f: array[0..MAX_S] of boolean;


procedure input;
var i: longint; 	
	c: char;
    st: ansistring;
begin
	for i:=  1 to MAX_P do p[i]:= '';

    np:= 1;
    while TRUE do
    begin
    	readln(fi,st);
        inc(np);
        if (st = '.') then break;
        for i:= 1 to length(st) do
        begin
        	if (st[i] = ' ') then inc(np)
            else p[np]:= p[np] + st[i];
        end;
    end;

    //
    s:= '';
    while not eof(fi) do
    begin
		readln(fi,st);
        s:= s + st;
    end;
end;


procedure init;
var	i,j: longint;
	pz: string;
begin
	for i:= 1 to np-1 do
    	for j:= i+1 to np do
        	if (p[i] > p[j]) then
            begin
            	pz:= p[i]; p[i]:= p[j]; p[j]:= pz;
            end;
end;


function isprimi(st: string): boolean;
var	le,ri,mid: longint;
begin
	le:= 1; ri:= np;
    while (le <= ri) do
    begin
    	mid:= (le + ri) div 2;
        if (st = p[mid]) then exit(true);
        if (st > p[mid]) then le:= mid + 1
        else ri:= mid - 1;
    end;

    exit(false);
end;


procedure process;
var 	i,j,k,lens: longint;
		prefix: boolean;
        st: string;
begin
	f[0]:= true;
    last:= 0;

    lens:= length(s);
    for i:= 1 to lens do
    begin
		prefix:= false;
		st:= '';
        k:= i - 10 + 1;
        if (k < 1) then k:= 1;
        for j:= i downto k do
        begin
        	st:= s[j] + st;
            if (j > last + 1) then continue;

			if (f[j-1]) and (isprimi(st)) then
            begin
                prefix:= true;
                last:= i;
                break;
            end;
        end;

        f[i]:= prefix;
    end;

    //
    writeln(fo,last);
end;

begin
	assign(fi,'prefix.in'); reset(fi);
    assign(fo,'prefix.out'); rewrite(fo);
	//
    input;
    init;
    process;

    //
    close(fi);
    close(fo);
end.
