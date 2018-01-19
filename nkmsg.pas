uses math;
const
	maxN = 1510;
//type

var
	fi,fo: text;
    n,cnt,cpn,res: longint;
    a,b: array[1..maxN,1..maxN] of boolean;
    vs: array[1..maxN] of boolean;
    st,number,low,c: array[1..maxN] of longint;
    top: longint;


procedure input;
var
	i,j: longint;
    c: char;
begin
    readln(fi,n);
    for i:= 1 to n do
    begin
    	for j:= 1 to n do
		begin
        	read(fi,c);
			if (c = '1') then a[i,j]:= true;        	
        end;
        readln(fi);
    end;
end;

procedure visit(i: longint);
var
 	j: longint;
begin
	inc(cnt); number[i]:= cnt;
    low[i]:= number[i];

    inc(top);
    st[top]:= i;

    for j:= 1 to n do
    	if (not vs[j]) and (a[i,j]) then
        	if number[j] <> 0 then
            	low[i]:= min(low[i],number[j])
            else
            begin
            	visit(j);
                low[i]:= min(low[i],low[j]);
            end;

    if (number[i] = low[i]) then
    begin
    	inc(cpn);
        repeat
        	j:= st[top];
        	dec(top);
            c[j]:= cpn;

            vs[j]:= true;
        until j = i;
    end;
end;

procedure process1;
var
	i: longint;
begin
	for i:= 1 to n do
    	if (number[i] = 0) then visit(i);
end;

procedure process2;
var
	i,j: longint;
begin
	for i:= 1 to n do
    	for j:= 1 to n do
        	if (a[i,j]) and (c[i] <> c[j]) then b[c[i],c[j]]:= true;


    for i:= 1 to cpn do
    begin
    	cnt:= 0;
    	for j:= 1 to cpn do
        	if (b[j,i]) then inc(cnt);

        //
        if (cnt = 0) then inc(res);
    end;
end;

procedure output;
begin
	writeln(fo,res);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    process1;
    process2;
    output;
    //
    close(fi);
    close(fo);
end.
