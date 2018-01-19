uses math;
const
	inputfile = '';
    outputfile = '';
    maxL = 110;
//type

var
	fi,fo: text;
    br,num: array[1..maxL] of longint;
    val: array['C'..'O'] of longint;
    s: string[maxL];

procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
begin	
	readln(fi,s);	
end;

function letter(c: char): boolean;
begin
	letter:= (c >= 'C') and (c <= 'O');
end;

function number(c: char): boolean;
begin
	number:= (c >= '2') and (c <= '9');
end;

procedure init;
var
	i,j: longint;
begin	
	val['C']:= 12;
    val['H']:= 1;
    val['O']:= 16;

    for i:= 1 to length(s) do
    begin
		if (s[i] = ')') then
        begin
        	for j:= i-1 downto 1 do
            	if (s[j] = '(') and (br[j] = 0) then
                begin
                	br[j]:= i;
                    break;
                end;
            if number(s[i+1]) then
            	num[i]:= ord(s[i+1]) - ord('0')
            else num[i]:= 1;
        end;
		
        if letter(s[i]) then
        	if number(s[i+1]) then
            	num[i]:= ord(s[i+1]) - ord('0')
            else num[i]:= 1;
    end;
end;

function calc(i,j: longint): longint;
var
	k,tmp,tt: longint;
begin
    tmp:= 0;

	k:= i;
    while (k <= j) do
    begin
		if letter(s[k]) then
        	tmp:= tmp + val[s[k]] * num[k];

        if (s[k] = '(') then
        begin
        	tt:= calc(k+1,br[k]-1);
            tmp:= tmp + tt * num[br[k]];
		    k:= br[k] + 1;
            continue;
        end;

        inc(k);
    end;

    exit(tmp);
end;

procedure process;
var
	res: longint;
begin
	res:= calc(1,length(s));
    writeln(fo,res);	
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;

begin
	openfile;
    input;
    init;
    process;
    closefile;
end.
