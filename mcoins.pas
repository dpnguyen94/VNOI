uses math;
const
	maxN = 1000001;
//type

var
	fi,fo: text;
    m,n,t: longint;
    a: array[1..3] of longint;
    f: array[0..maxN] of boolean;

procedure input;
begin
	a[1]:= 1;
	readln(fi,a[2],a[3],m);
end;

procedure process;
var
	i,j: longint;
    iswin: boolean;
begin
	f[0]:= false;
    f[1]:= true;
	
	for i:= 2 to maxN do
    begin
		iswin:= false;
        for j:= 1 to 3 do
        	if (i >= a[j]) and not f[i-a[j]] then
            begin
            	iswin:= true;
                break;
            end;
		f[i]:= iswin;
    end;
end;


begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
    //
	input;
    process;

    for t:= 1 to m do
    begin
    	read(fi,n);
        if (f[n]) then write(fo,'A')
        else write(fo,'B');
    end;
    //
    close(fi);
    close(fo);
end.
