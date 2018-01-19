uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 2010;
//type

var
	fi,fo: text;
    n,m: longint;
    din,dout: array[1..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m);
    for i:= 1 to m do
    begin
		readln(fi,u,v);
		inc(dout[u]);
        inc(din[v]);
    end;
end;

procedure process;
var
	i,nin,nout,rin,rout: longint;
begin
	nin:= 0;
    nout:= 0;

	for i:= 1 to n do
    begin
        if (din[i] = 0) then
        begin
        	inc(nin);
            rin:= i;
        end;
        if (dout[i] = 0) then
        begin
        	inc(nout);
            rout:= i;
        end;
    end;

    if (nin > 1) or (nout > 1) then
    begin
    	writeln('NO');
        exit;
    end;

	writeln(fo,'YES');
    writeln(fo,rout,' ',rin);
end;

procedure output;
begin
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
