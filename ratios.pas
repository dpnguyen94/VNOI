{
ID: ndchiph1
PROG: ratios
LANG: PASCAL
}
uses math;
const
	LM = 310;
    MAX = 99;
var
	fi,fo: text;
    n,a,b,c: array[1..3] of longint;


procedure input;
var
	i: longint;
begin
	for i:= 1 to 3 do read(fi,n[i]);
    for i:= 1 to 3 do readln(fi,a[i],b[i],c[i]);
end;

procedure process;
var
	i,j,k,i1,j1,k1,res,tmp,tt: longint;
    t: array[0..4] of longint;
begin
    tmp:= maxlongint;

	for i:= 0 to MAX do
    	for j:= 0 to MAX do
        	for k:= 0 to MAX do
            begin
            	t[1]:= i * a[1] + j * a[2] + k * a[3];
				t[2]:= i * b[1] + j * b[2] + k * b[3];
                t[3]:= i * c[1] + j * c[2] + k * c[3];
                t[4]:= i + j + k;

                //
                t[0]:= maxlongint;
                for tt:= 1 to 3 do
                	if (n[tt] > 0) and (t[tt] > 0) and (t[tt] mod n[tt] = 0) then
                    begin
						t[0]:= t[tt] div n[tt];
                    	break;
                    end;

                if (t[0] = maxlongint) then
                begin
                	if (t[1] = n[1]) and (t[2] = n[2]) and (t[3] = n[3])
                		and (t[4] < tmp) then
                        begin
                        	i1:= i; j1:= j; k1:= k;
                            res:= 1;
                            tmp:= t[4];
                        end;
                end else
                begin
                	if (t[1] = n[1] * t[0]) and (t[2] = n[2] * t[0])
                    	and (t[3] = n[3] * t[0]) and (t[4] < tmp) then
                        begin
                        	i1:= i; j1:= j; k1:= k;
                            res:= t[0];
                            tmp:= t[4];
                        end;
                end;
                //

			end;


    if (tmp = maxlongint) then writeln(fo,'NONE')
    else writeln(fo,i1,' ',j1,' ',k1,' ',res);
end;


begin
	assign(fi,'ratios.in'); reset(fi);
    assign(fo,'ratios.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.
