{
ID: ndchiph1
PROG: fence9
LANG: PASCAL
}
uses math;
//const
//type
var                                	
	fi,fo: text;
    n,m,p,res: longint;


procedure input;
begin
	readln(fi,n,m,p);
end;

function npoint(po: longint): longint;
var
	i,t,npo: longint;
begin
	npo:= 0;
	for i:= 1 to m-1 do
    begin
		t:= po * i div m;		
        npo:= npo + t;
    end;

    exit(npo);
end;

procedure process;
begin
	res:= (max(n,p) - 1) * (m - 1);
    res:= res - npoint(n)
    	- npoint(abs(p-n));
end;

procedure output;
begin
	writeln(fo,res);
end;


begin
	assign(fi,'fence9.in'); reset(fi);
    assign(fo,'fence9.out'); rewrite(fo);
	//
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
