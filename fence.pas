{
ID: ndchiph1
PROG: fence
LANG: PASCAL
}
uses math;
const
    maxN = 510;
    maxE = 1500;
//type

var                                	
	fi,fo: text;
    a: array[1..maxN,1..maxN] of longint;
    vt: array[1..maxN] of longint;
    f,top: longint;
    st: array[1..maxE] of longint;


procedure input;
var
	u,v,i: longint;
begin
	readln(fi,f);
    for i:= 1 to f do
    begin
    	readln(fi,u,v);
        inc(vt[u]);
        inc(vt[v]);

        inc(a[u,v]);
        inc(a[v,u]);
    end;
end;


procedure push(v: longint);
begin
	inc(top);
    st[top]:= v;
end;

function get: longint;
begin
	exit(st[top]);
end;

function pop: longint;
begin
	pop:= st[top];
    dec(top);
end;

procedure process;
var
	u,v,cnt: longint;
    dd: array[1..maxE] of longint;
begin	
	u:= 1;
	for v:= 1 to maxN do
    	if (vt[v] mod 2 = 1) then
        begin
        	u:= v;
            break;
        end;

    push(u);
    cnt:= 0;
    while (top > 0) do
    begin
    	u:= get;
        for v:= 1 to maxN do
        	if (a[u,v] > 0) then
            begin
            	dec(a[u,v]);
                dec(a[v,u]);
                push(v);
                break;
            end;

        if (u = get) then
        begin
        	inc(cnt);
            dd[cnt]:= pop;
        end;
    end;

    for u:= cnt downto 1 do writeln(fo,dd[u]);
end;


begin
	assign(fi,'fence.in'); reset(fi);
    assign(fo,'fence.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
