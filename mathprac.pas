{
ID: ndchiph1
PROG: mathprac
LANG: PASCAL
}
uses math;
const
	inputfile = 'mathprac.in';
    outputfile = 'mathprac.out';
//type

var
	fi,fo: text;
    a,b,e: longint;
    power: array[0..62] of int64;

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
	readln(fi,a,b);
    power[0]:= 1;
    for i:= 1 to 62 do
    	power[i]:= power[i-1] * 2;
end;

function firstdigit(num: int64): longint;
var
	d: longint;
begin
	while (num > 0) do
    begin
		d:= num mod 10;
        num:= num div 10;
    end;

    exit(d);
end;

procedure process;
var
	exist: boolean;
begin
	exist:= false;
	for e:= a+1 to 62 do
    begin
    	if (firstdigit(power[e]) = b) then
        begin
        	writeln(fo,e);
            exist:= true;
            break;
        end;
    end;

    if not exist then writeln(fo,0);
end;

procedure output;
begin
end;


BEGIN
	openfile;
    input;
    process;
    output;
    closefile;
END.
