uses math;
const
	maxN = 50000;
//type

var                                	
	fi,fo: text;
 	n,test,ntest: longint;
    a,le,ri: array[0..maxN] of longint;


procedure input;
var
	i: longint;
begin
	readln(fi,n);
    for i:= 1 to n do read(fi,a[i]);
end;

procedure process;
var
	i,j,i1,j1,res: longint;	
begin	
	for i:= 1 to n do
    begin
    	le[i]:= i-1;
        ri[i]:= i+1;
    end;

	//
	a[0]:= -1; a[n+1]:= -1;
    for i:= 1 to n do
    begin
    	j:= le[i];
        while (a[j] >= a[i]) do j:= le[j];
        le[i]:= j;
    end;

    for i:= n downto 1 do
    begin
    	j:= ri[i];
        while (a[j] >= a[i]) do j:= ri[j];
        ri[i]:= j;
    end;

    res:= -maxlongint;
    for i:= 1 to n do
    begin
    	j:= a[i] * (ri[i] - le[i] - 1);
    	if (j > res) then begin
        	res:= j;
            i1:= le[i] + 1;
            j1:= ri[i] - 1;
        end;
    end;

    writeln(fo,res,' ',i1,' ',j1);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
    	input;
    	process;
    end;
    //
    close(fi);
    close(fo);
end.
