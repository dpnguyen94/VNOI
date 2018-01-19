{
ID: ndchiph1
PROG: comehome
LANG: PASCAL
}
uses math;
const
	maxC = 1000000;
	

var
	fi,fo: text;
	c: array['A'..'z','A'..'z'] of longint;
    d: array['A'..'z'] of longint;
    free: array['A'..'z'] of boolean;
    p: longint;


procedure input;
var 	i,j,t: char;
	k,val: longint;
begin
    for i:= 'A' to 'z' do
    	for j:= 'A' to 'z' do
        	if (i = j) then c[i,j]:= 0
            else c[i,j]:= maxC;

	readln(fi,p);
    for k:= 1 to p do
    begin
    	readln(fi,i,t,j,val);
        if (val < c[i,j]) then
        begin
    		c[i,j]:= val;
            c[j,i]:= val;
        end;
    end;

    //init;
    for i:= 'A' to 'z' do d[i]:= maxC;
	d['Z']:= 0;
    fillchar(free,sizeof(free),true);
end;


procedure Dijkstra;
var 	i,u: char;	
	min: longint;
begin
	repeat
    	u:= ' '; min:= maxC;
        for i:= 'A' to 'z' do
        	if free[i] and (d[i] < min) then
            begin
		    	min:= d[i];
                u:= i;
            end;

        if (u = ' ') then break;
        free[u]:= false;

        for i:= 'A' to 'z' do
        	if free[i] and (d[i] > d[u] + c[u,i]) then d[i]:= d[u] + c[u,i];

        //
    until FALSE;
	
    min:= maxC;
    for i:= 'A' to 'Y' do
    	if (d[i] < min) then
        begin
        	min:= d[i];
            u:= i;
        end;

    writeln(fo,upcase(u),' ',min);	
end;


begin
	assign(fi,'comehome.in'); reset(fi);
    assign(fo,'comehome.out'); rewrite(fo);
	//
    input;
    Dijkstra;
    //
    close(fi);
    close(fo);
end.
