uses math;
const
	maxM = 27;	
//type

var
	fi,fo: text;
    n,m: longint;
    s: string;
    add,sub: array['a'..'z'] of longint;
    f: array[0..maxM,0..maxM] of longint;


procedure input;
var
	i: longint;
    c: char;
begin
	readln(fi,n,m);
    readln(fi,s);
    for i:= 1 to n do
        readln(fi,c,add[c],sub[c]);
end;

procedure process;
var
	i,j,t1,t2,t3: longint;
begin
	for j:= 2 to m do
    	for i:= j-1 downto 1 do
        	if (s[i] = s[j]) then f[i,j]:= f[i+1,j-1]
            else
			begin
            	t1:= f[i+1,j] + min(add[s[i]],sub[s[i]]);
                t2:= f[i,j-1] + min(add[s[j]],sub[s[j]]);
                t3:= f[i+1,j-1] + min(add[s[i]] + add[s[j]], sub[s[i]] + sub[s[j]]);

                f[i,j]:= min(t1,min(t2,t3));
            end;
end;

procedure output;
begin
	writeln(fo,f[1,m]);
end;


begin
	assign(fi,'cheappal.in'); reset(fi);
    assign(fo,'cheappal.out'); rewrite(fo);
    //
    input;
    process;
    output;
    //
    close(fi);
    close(fo);
end.
