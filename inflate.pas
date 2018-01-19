{
ID: ndchiph1
PROG: inflate
LANG: PASCAL
}

uses math;
const
	maxM = 10010;
var
	fi,fo: text;
    m,n: longint;
    f: array[0..maxM] of longint;

    	
procedure input;
begin
	readln(fi,m,n);
end;

procedure process;
var
	i,j: longint;
    mi,po: longint;
begin	
    for i:= 1 to n do
    begin
		readln(fi,po,mi);
        for j:= mi to m do
        	f[j]:= max(f[j],f[j-mi] + po);
    end;

    writeln(fo,f[m]);
end;


begin
	assign(fi,'inflate.in'); reset(fi);
    assign(fo,'inflate.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
