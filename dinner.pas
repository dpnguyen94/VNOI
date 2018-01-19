uses math;
const
	inputfile = 'dinner.inp';
    outputfile = 'dinner.out';
    LM = 1010;
type
	point = record
    	x,y: int64;
    end;
var
	fi,fo: text;
    n,m: longint;
    c,s: array[0..LM] of point;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n,m);
    for i:= 1 to n do
    	readln(fi,c[i].x,c[i].y);
    for i:= 1 to m do
    	readln(fi,s[i].x,s[i].y);
end;

procedure process;
var
begin
end;

procedure output;
var
begin
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
