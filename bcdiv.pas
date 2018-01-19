uses math;
const
	LM = 25;
//type

var                                	
	fi,fo: text;
    test,ntest: longint;
    n,k: longint;
    f: array[0..LM,0..LM] of qword;
    //f[i,j] la so cach chia i phan tu khac nhau vao j nhom,
    //moi nhom co >= 1 phan tu


procedure input;
begin
	readln(fi,n,k);	
end;

procedure process;
var
	i,j: longint;
begin		
	f[0,0]:= 1;

	for i:= 1 to LM do
    	for j:= 1 to LM do
        	f[i,j]:= f[i-1,j-1] + j * f[i-1,j];
end;

procedure output;
begin
	writeln(fo,f[n,k]);
end;

begin
	assign(fi,''); reset(fi);
    assign(fo,''); rewrite(fo);
	//
    process;
	readln(fi,ntest);
    for test:= 1 to ntest do
    begin
		input;
        output;
    end;
    //
    close(fi);
    close(fo);
end.
