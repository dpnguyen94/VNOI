{
ID: ndchiph1
PROG: fracdec
LANG: PASCAL
}
uses math;
const
    LM = 100010;
	
var
	fi,fo: text;
	n,d: longint;
    vs: array[0..LM] of boolean;
    pos: array[0..LM] of longint;
    sres,st: ansistring;


procedure input;
begin
	readln(fi,n,d);
end;


procedure process;
var		a,i,len: longint;
	exist: boolean;
begin
	sres:= '';
    str(n div d,st);
    sres:= sres + st + '.';
    n:= n mod d;
    if (n = 0) then sres:= sres + '0';
    //

    len:= length(sres);
    exist:= false;
    while TRUE do
    begin
    	if (n = 0) then break;
    	if (vs[n]) then
        begin
			a:= (n * 10) div d;
            exist:= true;
            break;
        end;
    	
        //
        vs[n]:= true;
        n:= n * 10;
        a:= n div d;
        str(a,st);
        sres:= sres + st;
        n:= n mod d;

        inc(len);
        if (pos[a] = 0) then pos[a]:= len;
    end;
	
    if (exist) then
    begin
    	insert('(',sres,pos[a]);
        sres:= sres + ')';
    end;

    for i:= 1 to length(sres) do
    begin
    	write(fo,sres[i]);
    	if (i mod 76 = 0) or (i = length(sres)) then writeln(fo);
    end;
end;


begin
	assign(fi,'fracdec.in'); reset(fi);
    assign(fo,'fracdec.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
