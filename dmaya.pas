uses math;
const
	inputfile = '';
    outputfile = '';
//type

var
	fi,fo: text;
	n,m,res: longint;
    a,b: ansistring;
    ca,cb: array['A'..'z'] of longint;


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
begin
	readln(fi,n,m);
    readln(fi,a);
    readln(fi,b);
end;


procedure process;
var
	i: longint;
    c: char;
    match: boolean;
begin
	for i:= 1 to n do
    begin
    	inc(ca[a[i]]);
    	inc(cb[b[i]]);
    end;

    match:= true;
    for c:= 'A' to 'z' do
    	if (cb[c] <> ca[c]) then
        begin
        	match:= false;
            break;
        end;

    if match then res:= 1
    else res:= 0;

    for i:= n+1 to m do
    begin
    	dec(cb[b[i-n]]);
        inc(cb[b[i]]);

        match:= true;
        for c:= 'A' to 'z' do
        	if (cb[c] <> ca[c]) then
            begin
            	match:= false;
                break;
            end;
        if match then inc(res);
    end;
end;


procedure output;
begin
	writeln(fo,res);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
