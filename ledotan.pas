uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 100010;
//type

var
	fi,fo: text;
    n,m,le,ri,res: longint;
    a: array[1..maxN] of longint;

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i: longint;
begin
	readln(fi,n,m);
    le:= 0;	
    for i:= 1 to n do
    begin
    	readln(fi,a[i]);
       	if (a[i] > le) then le:= a[i];
       	ri:= ri + a[i];
    end;
end;

function valid(k: longint): boolean;
var
	i,m1,k1: longint;
begin
	m1:= 1;
    k1:= k;

	for i:= 1 to n do
    begin
		if (a[i] <= k1) then k1:= k1 - a[i]
        else
        	if (m1 < m) then
		    begin
            	inc(m1);	
                if (a[i] <= k) then
                	k1:= k - a[i]
                else exit(false);
            end
            else exit(false);
    end;		

    exit(true);
end;

procedure process;
var
	mid: longint;
begin
	while (le <= ri) do
    begin
		mid:= (le + ri) div 2;	
        if (valid(mid)) then
        begin
			res:= mid;
            ri:= mid - 1;
        end
        else
        	le:= mid + 1;
    end;	
end;

procedure output;
begin	
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
    output;
    closefile;
end.
