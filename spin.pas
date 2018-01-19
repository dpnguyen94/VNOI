{
ID: ndchiph1	
PROG: spin
LANG: PASCAL
}
uses math;
const
	C = 360;
var
	fi,fo: text;
    b,a,ext: array[1..5,1..5] of longint;
    sp,ws: array[1..5] of longint;

    	
procedure input;
var
	i,j: longint;
begin
	for i:= 1 to 5 do
    begin
    	read(fi,sp[i],ws[i]);
        for j:= 1 to ws[i] do
        	read(fi,a[i,j],ext[i,j]);
    end;
end;

function valid: boolean;
var
	i,j,k,t: longint;
    valid1,valid2: boolean;
begin
	for k:= 0 to 359 do
    begin
    	valid2:= true;

    	for i:= 1 to 5 do
        begin
        	valid1:= false;

			for j:= 1 to ws[i] do
            begin
            	t:= b[i,j] + ext[i,j];
            	if ( (b[i,j] <= k) and (k <= t) )
                	or ( (b[i,j] <= k + 360) and (k + 360 <= t) ) then
                    begin
                    	valid1:= true;
                        break;
                    end;
            end;
			
            if (valid1 = false) then
            begin
            	valid2:= false;
                break;
            end;
        end;	

        if valid2 then exit(true);
    end;

    //
    exit(false);
end;

function process: longint;
var
	i,j,k,t,angle: longint;
begin
	for k:= 0 to 359 do
    begin
    	for i:= 1 to 5 do
        begin
			angle:= sp[i] * k;
            for j:= 1 to ws[i] do
            	b[i,j]:= (a[i,j] + angle) mod C;
        end;
	
    	if (valid) then exit(k);
    end;

    exit(k+1);
end;


begin
	assign(fi,'spin.in'); reset(fi);
    assign(fo,'spin.out'); rewrite(fo);
	//
    input;
    if (process = 360) then writeln(fo,'none')
    else writeln(fo,process);
    //
    close(fi);
    close(fo);
end.
