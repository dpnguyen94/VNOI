program prudence;
uses crt;
const   fi = 'prudence.inp';
var     a,b: array[1..50] of 0..50;
        m,n,k,x,y: byte;
        direct: 0..3;
        f: text;


procedure input;
var     i: byte;
begin

        assign(f,fi); reset(f);
        readln(f,m,n,k,x,y);
        for i:= 1 to k do readln(f,a[i],b[i]);
        close(f);

        //init;
        direct:= 0;
end;

function diduoc(i,j: integer): boolean;
var     z: byte;
begin
        diduoc:= false;
        //
        if (i < 0) or (j < 0) or (i > n) or (j > m) then exit;
        for z:= 1 to k do if (i = a[z]) and (j = b[z]) then exit;
        //
        diduoc:= true;
end;

procedure go(i,j: integer);
begin
        if (direct <> 1) and diduoc(i,j-1) then begin
                writeln(i,' ',j-1);
                go(i,j-1);
                direct:= 1;
        end;

        if (direct <> 2) and diduoc(i+1,j) then begin
                writeln(i,' ',j-1);
                go(i+1,j);
                direct:= 2;
        end;

        if (direct <> 3) and diduoc(i-1,j) then begin
                writeln(i,' ',j-1);
                go(i-1,j);
                direct:= 3;
        end;

        if (i = x) and (j = y) then begin
                direct:= 0;
                writeln;
                exit;
        end;

end;



begin
        clrscr;
        input;
        go(0,0);
        readln;
end.
