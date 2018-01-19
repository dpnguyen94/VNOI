uses math;
const
	maxN = 10010;
    LM = 1 shl 8 - 1;
//type

var
	fi,fo: text;
    n,cnt: integer;
    a: array[1..8,1..maxN] of longint;
    f: array[1..maxN,0..LM] of int64;
    val: array[1..maxN,0..LM] of longint;
    valid,nv: array[0..LM] of integer;
    match: array[0..LM,1..LM] of integer;


procedure input;
var
	i,j: integer;
    res: longint;
begin
	readln(fi,n);
    res:= -maxlongint;

    for i:= 1 to 8 do
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

function getbit(i,j: integer): integer;
begin
	getbit:= (i shr j) and 1;
end;

procedure init;
var
	i,j,i1,j1,k: integer;
    OK: boolean;
begin
	cnt:= 0;

	for i:= 0 to LM do
    begin
    	for j:= 1 to 7 do
        begin
        	OK:= true;
        	if (getbit(i,j) = 1) and (getbit(i,j-1) = 1) then
            begin
            	OK:= false;
                break;
            end;
        end;

        if OK then
        begin
        	inc(cnt);
            valid[cnt]:= i;
        end;
    end;

    //
    for i:= 1 to cnt do
    	for j:= 1 to cnt do
            begin
            	i1:= valid[i];
                j1:= valid[j];

                OK:= true;
                for k:= 0 to 7 do
                	if (getbit(i1,k) = 1) and  (getbit(j1,k) = 1) then
                    begin
						OK:= false;
                        break;
                    end;

                if OK then
                begin
                	inc(nv[i1]);
                	match[i1,nv[i1]]:= j1;
                end;
            end;

        //
        for i:= 1 to n do
        	for j:= 1 to cnt do
            begin
            	j1:= valid[j];

            	for k:= 0 to 7 do 	
                	val[i,j1]:= val[i,j1] + getbit(j1,k) * a[k+1,i];
            end;
end;

procedure process;
var
	i,j,k,j1,k1: integer;
    t: int64;	
begin
	for i:= 1 to cnt do
		f[1,valid[i]]:= int64(val[1,valid[i]]);

    //
    for i:= 2 to n do
    	for j:= 1 to cnt do
            begin
            	j1:= valid[j];

            	t:= low(int64);
            	for k:= 1 to nv[j1] do
                begin
                	k1:= match[j1,k];

                	if (f[i-1,k1] > t) then t:= f[i-1,k1];
                end;

                f[i,j1]:= t + val[i,j1];
            end;
end;

procedure output;
var
	i: integer;
    res: int64;
begin
	res:= low(int64);

	for i:= 1 to cnt do 	
    	if (f[n,valid[i]] > res) then res:= f[n,valid[i]];

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
