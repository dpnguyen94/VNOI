uses math;
const
	inputfile = '';
    outputfile = '';
    maxN = 7;
//type

var
	fi,fo: text;
    n,res: longint;
    a: array[0..maxN,0..maxN] of longint;
    sh,b,c: array[0..maxN] of longint;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
	i,j: longint;
begin
	for i:= 0 to n-1 do
    	for j:= 0 to n-1 do
        	read(fi,a[i,j]);
end;

procedure solve;
var
	i,j,m: longint;	
begin
	fillchar(c,sizeof(c),0);
	
    //
	for i:= 0 to n-1 do
    begin
		for j:= 0 to n-1 do
        begin
        	b[j]:= a[i, (j + n - sh[i]) mod n];
            c[j]:= c[j] + b[j];
        end;
    end;

    m:= -maxlongint;
    for i:= 0 to n-1 do
    	if (c[i] > m) then m:= c[i];

    //
	if (m < res) then
    	res:= m;
end;

procedure attempt(i: longint);
var
	j: longint;
begin
	if (i = n) then
    begin
    	solve;
        exit;
    end;

    for j:= 0 to n-1 do
	begin
    	sh[i]:= j;
        attempt(i+1);
    end;
end;

procedure process;
begin
	res:= maxlongint;

	attempt(1);
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
    while TRUE do
    begin
    	readln(fi,n);
        if (n = -1) then break;

        //
        input;
    	process;
    	output;
    end;
    closefile;
end.
