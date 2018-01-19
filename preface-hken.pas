{
ID: hoangducv1
PROG: preface
LANG: PASCAL
}
var	fi,fo: text;
	n: longint;

function transDigit(x:integer; c1,c5,c10: char): string;
var  i: integer;
	 r: string;
begin
	//
	if (x = 4) then exit(c1+c5);
    if (x = 9) then exit(c1+c10);

	//
    r:= '';
    if (x >= 5) then begin r:= c5; x:= x-5; end;
    for i:= 1 to x do r:= r + c1;
    exit(r);
end;


function trans(x:integer): string;
var r: string;
begin
	r:= '';
    if (x >= 1000) then r:= r + transDigit( (x div 1000)       , 'M', '-', '-');
    if (x >=  100) then r:= r + transDigit( (x div  100) mod 10, 'C', 'D', 'M');
    if (x >=   10) then r:= r + transDigit( (x div   10) mod 10, 'X', 'L', 'C');
    r:= r + transDigit( x mod 10, 'I', 'V', 'X');
    exit(r);
end;


function process: longint;
var i,j: longint;
	s: string;
	cnt: array[1..7] of longint;
    sr: string = 'IVXLCDM';
begin
	fillchar(cnt,sizeof(cnt),0);

    for i:= 1 to n do begin
		s:= trans(i);
        for j:= 1 to length(s) do begin
            case s[j] of
                'I': inc(cnt[1]);
                'V': inc(cnt[2]);
                'X': inc(cnt[3]);
                'L': inc(cnt[4]);
                'C': inc(cnt[5]);
                'D': inc(cnt[6]);
                'M': inc(cnt[7]);
            end;
        end;
    end;

    //
    for i:= 1 to 7 do
    	if (cnt[i] > 0) then writeln(fo,sr[i],' ',cnt[i]);
end;

begin
	assign(fi,'preface.in'); reset(fi);
    assign(fo,'preface.out'); rewrite(fo);


    readln(fi,n);
    process;

    close(fi);
    close(fo);

end.
