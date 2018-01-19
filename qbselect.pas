uses math;
const
	maxN = 10010;
    LM = 1 shl 4 - 1;
//type

var
	fi,fo: text;
    n,res: longint;
    a: array[1..4,1..maxN] of longint;
    valid: array[0..LM] of boolean;
    match: array[0..LM,0..LM] of boolean;
    f,val: array[1..maxN,0..LM] of longint;


procedure input;
var
	i,j: longint;
begin
	readln(fi,n);

    res:= -maxlongint;
	for i:= 1 to 4 do
    	for j:= 1 to n do
        begin
        	read(fi,a[i,j]);
            if (a[i,j] > res) then res:= a[i,j];
        end;

    if (res <= 0) then
    begin
        writeln(fo,res);
        close(fi); close(fo);
    	halt;
    end;
end;

function getbit(i,j: longint): longint;
begin
	getbit:= (i shr j) and 1;
end;

procedure init;
var
	i,j,k,t: longint;
begin
	for i:= 0 to LM do
    begin
    	valid[i]:= true;
    	for j:= 1 to 3 do
        	if (getbit(i,j) = 1) and (getbit(i,j-1) = 1) then
            begin
            	valid[i]:= false;
                break;
            end;		
    end;

    for i:= 0 to LM do
    	for j:= 0 to LM do
        	if valid[i] and valid[j] then
            begin
            	match[i,j]:= true;
            	for k:= 0 to 3 do
                	if (getbit(i,k) = 1) and (getbit(j,k) = 1) then
                    begin
                    	match[i,j]:= false;
                        break;
                    end;
            end;

    for i:= 1 to n do
    	for j:= 0 to LM do
        	if valid[j] then
            begin
            	for k:= 0 to 3 do
                	val[i,j]:= val[i,j] + getbit(j,k) * a[k+1,i];
            end;
end;

procedure process;
var
	i,j,k,t: longint;
begin
	for i:= 0 to LM do
    	if valid[i] then f[1,i]:= val[1,i];

    for i:= 2 to n do
    	for j:= 0 to LM do
        	if (valid[j]) then
        	begin
            	t:= -maxlongint;

				for k:= 0 to LM do
                	if (valid[k]) then
                		if (match[j,k]) then
                    		if (f[i-1,k] > t) then t:= f[i-1,k];

                f[i,j]:= t + val[i,j];
            end;
end;

procedure output;
var
	i: longint;
begin
	res:= -maxlongint;

    for i:= 0 to LM do
		if (valid[i]) then
        	if (f[n,i] > res) then
            	res:= f[n,i];

    writeln(fo,res);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    input;
    init;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
