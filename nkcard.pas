uses math;
const
	inputfile = '';
    outputfile = '';
	maxM = 1000010 + 100010;
//type

var
	fi,fo: text;
    m,k: longint;
    s: ansistring;
    a: array[0..maxM] of longint;
    res: array[1..3] of longint;


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
	c: char;
begin
	read(fi,m,k);

    s:= '';
    while TRUE do
    begin
    	read(fi,c);
        if (c = '.') then break;
        if (c <> ' ') then s:= s + c;
    end;

	for i:= 0 to m-1 do
    	a[i]:= i;
end;


procedure process;
var
	i,first,second,last,cnt: longint;
begin
	first:= 0;
    second:= 1;
    last:= m-1;

	for i:= 1 to length(s) do
    	if (s[i] = 'A') then
        begin
        	inc(last);
            a[last]:= a[first];

			a[first]:= -1;	
		    first:= second;
        inc(second);
        end
        else
        begin
        	inc(last);
            a[last]:= a[second];

        	a[second]:= -1;
          inc(second);
        end;

    cnt:= -1;
	for i:= first to last do
    begin
    	if (a[i] <> -1) then inc(cnt)
        else continue;

        if (cnt = k-1) then res[1]:= a[i];
        if (cnt = k) then res[2]:= a[i];
        if (cnt = k+1) then
        begin
        	res[3]:= a[i];
            break;
        end;
    end;

    for i:= 1 to 3 do
    	write(fo,res[i],' ');
end;


procedure output;
begin
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
