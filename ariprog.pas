{
ID: ndchiph1
PROG: ariprog
LANG: PASCAL
}

uses math;
const	MAX_M = 125000;
var fi,fo: text;
    b: array[0..MAX_M] of boolean;
    a: array[0..MAX_M] of longint;
    n,m,cnt: longint;

procedure init;
var i,j: longint;
begin
	fillchar(b,sizeof(b),false);
    for i:= 0 to m do
    for j:= 0 to m do b[i*i+j*j]:= true;
    //
    cnt:= 0;
    for i:= 0 to m*m do
    if b[i] then begin
    	inc(cnt);
        a[cnt]:= i;
    end;
end;

procedure process;
var	i,j,k,t1,t2: longint;
    valid,exist: boolean;
begin
	exist:= false;
    t1:= 2*m*m;
    t2:= t1 div (n-1);
    //
    for i:= 1 to t2 do begin
    	for j:= 1 to cnt do begin
        	for k:= n-1 downto 0 do begin
            	if (a[j] + k*i > t1) or (not b[a[j] + k*i]) then begin
                	valid:= false;
                    break;
                end;
            	valid:= true;
            end;

            if valid then begin
            	exist:= true;
                writeln(fo,a[j],' ',i);
            end;
        end;
    end;
    //
    if not exist then writeln(fo,'NONE');
end;


begin
	assign(fi,'ariprog.in'); reset(fi);
    assign(fo,'ariprog.out'); rewrite(fo);
    //
    readln(fi,n);
    readln(fi,m);
    init;
    process;
    //
    close(fi);
    close(fo);
end.
