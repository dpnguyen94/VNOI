{
ID: ndchiph1
PROG: ttwo
LANG: PASCAL
}
uses math;
const
	maxN = 11;
	
var
	fi,fo: text;
    vs: array[0..maxN,0..maxN,0..maxN,0..maxN,0..maxN,0..maxN ] of boolean;
	c: array[0..maxN,0..maxN] of char;
    dirx: array[1..4] of longint = (-1,0,1,0);
    diry: array[1..4] of longint = (0,1,0,-1);
    rot: array[1..4] of longint = (2,3,4,1);
    fx,fy,cx,cy,df,dc: longint;


procedure input;
var 	i,j: longint;
begin
	for i:= 0 to maxN do
    	for j:= 0 to maxN do c[i,j]:= '*';

    for i:= 1 to 10 do
    begin
    	for j:= 1 to 10 do
        begin
        	read(fi,c[i,j]);
        	if (c[i,j] = 'F') then
        	begin
        		fx:= i;
            	fy:= j;
            	c[i,j]:= '.';
        	end;

       	 	if (c[i,j] = 'C') then
        	begin
				cx:= i;
            	cy:= j;
            	c[i,j]:= '.';
        	end;
        end;

		readln(fi);
    end;
end;		


procedure process;
var	res: longint;
begin
	df:= 1; dc:= 1;
    res:= 0;
    while TRUE do
    begin
    	if (vs[fx,fy,df,cx,cy,dc]) then
        begin
        	res:= 0;
            break;
        end;

        if (fx = cx) and (fy = cy) then break;

        inc(res);
		vs[fx,fy,df,cx,cy,dc]:= true;				
		if (c[fx+dirx[df],fy+diry[df]] = '.') then
        begin
        	fx:= fx + dirx[df];
            fy:= fy + diry[df];
        end else df:= rot[df];

        if (c[cx+dirx[dc],cy+diry[dc]] = '.') then
        begin
        	cx:= cx + dirx[dc];
            cy:= cy + diry[dc];
        end else dc:= rot[dc];
    end;

    writeln(fo,res);
end;


begin
	assign(fi,'ttwo.in'); reset(fi);
    assign(fo,'ttwo.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
