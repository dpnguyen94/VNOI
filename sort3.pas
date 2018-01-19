{
ID: ndchiph1
PROG: sort3
LANG: PASCAL
}
uses math;
var	
	fi,fo: text;
	head,last: array[1..3] of integer;
    num: array[1..3] of integer;
	a: array[1..1000] of integer;
    n: integer;

procedure input;
var 	i: integer;
begin
	readln(fi,n);

    fillchar(num,sizeof(num),0);
	for i:= 1 to n do
    begin
    	readln(fi,a[i]);
		inc(num[a[i]]);
    end;

    //init;
	head[1]:= 1; last[1]:= num[1];
    for i:= 2 to 3 do
    begin
    	head[i]:= last[i-1]+1;
        last[i]:= head[i]+num[i]-1;
    end;
end;

procedure swap(var x,y: integer);
var	z: integer;
begin
	z:= x; x:= y; y:= z;
end;

procedure greedy;
var 	i,j,cnt: longint;
		exist: boolean;
begin
	cnt:= 0;

    //
	for i:= 1 to n do
    begin
    	if (i < head[a[i]]) or (i > last[a[i]]) then
        begin
        	exist:= false;
        	for j:= i+1 to n do
            	if (i >= head[a[j]]) and (i <= last[a[j]])
	              	and (j >= head[a[i]]) and (j <= last[a[i]]) then
                begin
                	inc(cnt);
                    swap(a[i],a[j]);
                    exist:= true;
                    break;
                end;
			
            //
            if (not exist) then
            	for j:= i+1 to n do
                	if (i >= head[a[j]]) and (i <= last[a[j]])
                    	and ( (j < head[a[j]]) or (j > last[a[j]]) ) then
                    begin
                    	inc(cnt);
                        swap(a[i],a[j]);
                        break;
					end;
        end;
	end;

    //
    writeln(fo,cnt);
end;


begin
	assign(fi,'sort3.in'); reset(fi);
    assign(fo,'sort3.out'); rewrite(fo);
    //
    input;
    greedy;
    //
    close(fi);
    close(fo);
end.
