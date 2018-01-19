{
ID: ndchiph1
PROG: castle
LANG: PASCAL
}
uses math;
const
	LM = 50;
var
	fi,fo: text;
    a: array[1..LM,1..LM] of longint;
    b: array[0..LM+1,0..LM+1] of longint;
    dx: array[0..3] of longint = (0,-1,0,1);
    dy: array[0..3] of longint = (-1,0,1,0);
    c: array[0..LM*LM] of longint;
    cnt1,cnt2: longint;
    n,m: longint;


procedure input;
var	i,j: longint;
begin
	readln(fi,m,n);
    for i:= 1 to n do
    begin
    	for j:= 1 to m do read(fi,a[i,j]);
        readln(fi);
    end;
end;

function getbit(x,y: longint): longint;
begin
	exit( (x shr y) and 1 );
end;

procedure ffill(x,y: longint);
var	k: longint;
begin
	if (x < 1) or (x > n) or (y < 1) or (y > m) then exit;
    if (b[x,y] > 0) then exit;
    //
    inc(cnt2);
	b[x,y]:= cnt1;
    for k:= 0 to 3 do
    	if (getbit(a[x,y],k) = 0) then ffill(x+dx[k],y+dy[k]);
end;

procedure process;
var	i,j,k,t,i1,j1,k1,t1,largest: longint;
begin
	//init;
	fillchar(b,sizeof(b),0);
    c[0]:= 0;
		
    cnt1:= 0;
	for i:= 1 to n do
        for j:= 1 to m do
        begin
            if (b[i,j] = 0) then begin
            	cnt2:= 0;
            	inc(cnt1);
                ffill(i,j);
            end;
			c[cnt1]:= cnt2;
        end;
	
    writeln(fo,cnt1);

    //
    largest:= 0;
    for i:= 1 to cnt1 do
    	if (c[i] > largest) then largest:= c[i];
    writeln(fo,largest);

    //
    largest:= 0;
    for j:= 1 to m do
    	for i:= n downto 1 do
        	for k:= 0 to 3 do
            begin
                if (getbit(a[i,j],k) = 1) and (b[i,j] <> b[i+dx[k],j+dy[k]]) then
                begin
                	t:= c[b[i,j]]+c[b[i+dx[k],j+dy[k]]];
            		if (t > largest) then
                    begin
                    	largest:= t;
                        i1:= i;
                        j1:= j;
                        k1:= k;
                	end;
            	end;
    		end;
    //
    writeln(fo,largest);
    write(fo,i1,' ',j1,' ');

    //
    case k1 mod 2 of
    		0: write(fo,'E');
            1: write(fo,'N');
        end;	
	writeln(fo);
end;


begin
	assign(fi,'castle.in'); reset(fi);
    assign(fo,'castle.out'); rewrite(fo);
	//

    input;
    process;

    //
    close(fi);
    close(fo);
end.
