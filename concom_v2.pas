{
ID: ndchiph1
PROG: concom
LANG: PASCAL
}
uses math;
const
	MAX_N = 101;
	
//type

var
	fi,fo: text;
    control: array[1..MAX_N,1..MAX_N] of boolean;
    own: array[1..MAX_N,1..MAX_N] of longint;
    n: longint;


procedure addcontrol(i,j: longint);
var	k: longint;
begin
	if control[i,j] then exit;

    control[i,j]:= true;

    for k:= 1 to MAX_N do
    	inc(own[i,k],own[j,k]);

    for k:= 1 to MAX_N do
    	if control[k,i] then addcontrol(k,j);

    for k:= 1 to MAX_N do
    	if own[i,k] > 50 then addcontrol(i,k);
end;



procedure addown(i,j,p: longint);
var	k: longint;
begin
	for k:= 1 to MAX_N do
    	if control[k,i] then inc(own[k,j],p);

    for k:= 1 to MAX_N do
    	if own[k,j] > 50 then addcontrol(k,j);
end;


procedure process;
var 	i,j,a,b,p: longint;
	exist: boolean;
begin
	for i:= 1 to MAX_N do control[i,i]:= true;

	for i:= 1 to n do
    begin
    	readln(fi,a,b,p);
        addown(a,b,p);
    end;

    exist:= false;
    for i:= 1 to MAX_N do
    	for j:= 1 to MAX_N do
        	if (i <> j) and (control[i,j]) then
            begin
            	writeln(fo,i,' ',j);
                exist:= true;
            end;

	if not exist then writeln(fo,0);
end;


begin
	assign(fi,'concom.in'); reset(fi);
    assign(fo,'concom.out'); rewrite(fo);
	//
    readln(fi,n);
    process;
    //
    close(fi);
    close(fo);
end.
