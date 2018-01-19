{
ID: ndchiph1
PROG: nocows
LANG: PASCAL
}
uses math;
const
	MAX_N = 210;
	MAX_K = 110;
    C = 9901;
var
	fi,fo: text;
	f,s: array[0..MAX_K,0..MAX_N] of longint;
    n,kn: longint;

procedure input;
begin
	readln(fi,n,kn);
end;


procedure process;
var	i,j,k,t: longint;
begin
    f[1,1]:= 1;
    for i:= 2 to kn do
    begin
		j:= 1;
        while (j <= n) do
        begin
        	k:= 1;
            while (k <= j-1-k) do
            begin
				if (k = j-1-k) then t:= 1
                else t:= 2;

                f[i,j]:= f[i,j] + t * (s[i-2,k] * f[i-1,j-1-k] +
                			f[i-1,k] * s[i-2,j-1-k] +
                        	f[i-1,k] * f[i-1,j-1-k]);

                f[i,j]:= f[i,j] mod C;
                inc(k,2);
			end;
			
            inc(j,2);
        end;
		
		//
        j:= 1;
        while (j <= n) do
        begin
        	s[i-1,j]:= s[i-1,j] + s[i-2,j] + f[i-1,j];
            s[i-1,j]:= s[i-1,j] mod C;
            inc(j,2);
        end;
    end;

    writeln(fo,f[kn,n]);
end;


begin
	assign(fi,'nocows.in'); reset(fi);
    assign(fo,'nocows.out'); rewrite(fo);
	//
    input;
    process;
    //
    close(fi);
    close(fo);
end.

