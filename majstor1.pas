uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 60;
///type

var
	fi,fo: text;
    n,r: longint;
    sv: string;
    s: array[1..maxN] of string;
    pl:array['P'..'S','P'..'S'] of longint;
    st:string='SRP';
procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;	
var
	i: longint;
begin
	readln(fi,r);
    readln(fi,sv);
    readln(fi,n);

    for i:= 1 to n do readln(fi,s[i]);

    pl['S','S']:= 1;
    pl['R','R']:= 1;
    pl['P','P']:= 1;
    pl['S','P']:= 2;
    pl['P','R']:= 2;
    pl['R','S']:= 2;
end;

procedure process;
var
	i,j,k,rmax,point,res: longint;
    c: char;
begin
	res:= 0;
    for i:= 1 to n do
    	for j:= 1 to r do
        	inc(res,pl[sv[j],s[i][j]]);
    writeln(fo,res);

    res:= 0;
    for i:= 1 to r do
    begin
    	rmax:= -1;
        for j:= 1 to 3 do
        begin
        	c:= st[j];
            point:= 0;
			for k:= 1 to n do
            	inc(point,pl[c,s[k][i]]);
        if (point > rmax) then rmax:= point;
    	end;
    	inc(res,rmax);
    end;

    //
    writeln(fo,res);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

begin
	openfile;
	input;
    process;
    closefile;
end.
