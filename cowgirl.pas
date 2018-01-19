uses math;
const
	LM = 31;
//type

var
	fi,fo: text;
    m,n,ntest,test: longint;
    w: array[1..LM,0..LM] of longint;
    f: array[0..5] of longint;
    match: array[0..LM,0..LM] of boolean;


procedure init1;
var
	i: longint;
begin
	f[0]:= 1;
    for i:= 1 to 5 do f[i]:= f[i-1] * 2;
end;

procedure input;
var
	z: longint;
begin
	readln(fi,m,n);
    if (m < n) then
    begin
    	z:= m; m:= n; n:= z;
    end;
end;

function getbit(x,i: longint): longint;
begin
	getbit:= (x shr i) and 1;
end;

procedure init2;
var
	i,j,k,t: longint;
    valid: boolean;
begin
	fillchar(match,sizeof(match),false);

	for i:= 0 to f[n] - 1 do
    	for j:= 0 to f[n] - 1 do
        begin
        	valid:= true;
			for k:= 1 to n-1 do
            begin
				t:= getbit(i,k) + getbit(j,k) + getbit(i,k-1) + getbit(j,k-1);
                if (t = 0) or (t = 4) then
                begin
                	valid:= false;
                	break;
                end;
            end;

            match[i,j]:= valid;
        end;
end;

procedure process;
var
	i,j,k: longint;
begin
	fillchar(w,sizeof(w),0);

	for i:= 0 to f[n] - 1 do
    	w[1,i]:= 1;

    for i:= 2 to m do
    	for j:= 0 to f[n] - 1 do
			for k:= 0 to f[n] - 1 do
            	if (match[j,k]) then w[i,j]:= w[i,j] + w[i-1,k];
end;

procedure output;
var
	i,res: longint;
begin
	res:= 0;
	for i:= 0 to f[n]-1 do
    	res:= res + w[m,i];
    writeln(fo,res);
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
    init1;

    readln(fi,ntest);
    for test:= 1 to ntest do
    begin
    	input;
        init2;
    	process;
    	output;
    end;
    //
    close(fi);
    close(fo);
end.
