program tuchanchinh;
uses crt;
const   MN = 100;
        fo = 'chanchinh.out';
var     a: array[1..100] of byte;
        i: byte;
        f: text;

function bang(i,k: byte): boolean;
var     j: byte;
begin
        bang:= false;
        for j:= 0 to k-1 do
                if a[i-j] <> a[i-j-k] then exit;
        bang:= true;
end;


function cchinh(i: byte): boolean;
var     j: byte;
begin
        cchinh:= false;
        for j:= 1 to (i div 2) do
                if bang(i,j) then exit;
        cchinh:= true;
end;

function tim(i: byte): boolean;
begin
        tim:= true;
        while(a[i] < 3) do
        begin
                inc(a[i]);
                if cchinh(i) then exit;
        end;
        tim:= false;
end;

procedure printres(i: byte);
var     j: byte;
begin
        assign(f,fo); rewrite(f);
        if i = 0 then write('Vo nghiem')
        else
        for j:= 1 to 100 do
        begin
                case a[j] of
                1: write(f,'A');
                2: write(f,'C');
                else write(f,'B');
                end;
        end;
        close(f);
end;


begin
        for i:= 1 to 100 do a[i]:= 0;
        {khoi tao}

        i:= 1;
        repeat
                if i > 100 then begin printres(100); exit; end;
                if i < 1 then begin printres(0); exit; end;

                if tim(i) then inc(i)
                else begin a[i]:= 0; dec(i); end;
        until false;
end.