uses math;
const
	inputfile = 'color.inp';
    outputfile = 'color.out';
//type

var
	fi,fo: text;
    s,res: longint;
	a,b: array[1..5,1..10] of longint;
	num: array[1..5] of longint;
    f: array[0..10] of longint;

    h,le,ri: array[0..11] of longint;
    save: array[1..5,0..11] of longint;


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
	i,j: longint;
    c: char;
begin
	readln(fi,s);
	for i:= 1 to 5 do
    begin
		for j:= 1 to 10 do
        begin
        	read(fi,c);
            if (c = '0') then
            begin
            	inc(num[i]);
                b[i,num[i]]:= j;
            end;

            a[i,j]:= ord(c) - ord('0');
        end;
		readln(fi);
    end;

    //
    f[0]:= 1;
    for i:= 1 to 10 do
    	f[i]:= f[i-1] * 2;
end;


function findmax: longint;
var
	i,j,fm: longint;
begin
	for i:= 1 to 10 do
    begin
    	le[i]:= i-1;
        ri[i]:= i+1;
    end;

    for i:= 1 to 10 do
    begin
    	j:= le[i];
        while (h[j] >= h[i]) do j:= le[j];
        le[i]:= j;
    end;

	for i:= 10 downto 1 do
    begin
    	j:= ri[i];
        while (h[j] >= h[i]) do j:= ri[j];
        ri[i]:= j;
    end;

    fm:= 0;
    for i:= 1 to 10 do
    begin
    	j:= h[i] * (ri[i] - le[i] - 1);
        fm:= max(fm,j);
    end;

    exit(fm);
end;


procedure attempt(row: longint);
var
	i,j,n,smax: longint;
begin
	if (row > 5) then
    begin
    	smax:= findmax;
        if (smax = s) then inc(res);

        //
        exit;
    end;

    save[row]:= h;

	n:= num[row];
	for i:= 0 to f[n] - 1 do
    begin
		for j:= 0 to n-1 do
        	if ((i shr j) and 1 = 0) then 				    	
				inc(h[b[row,n-j]]);

        smax:= findmax;

        if (smax <= s) and (smax + 10 * (n - row) >= s) then attempt(row + 1);
        h:= save[row];	
    end;
end;


procedure process;
begin
	h[0]:= -1;
    h[11]:= -1;

    res:= 0;
	attempt(1);
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
