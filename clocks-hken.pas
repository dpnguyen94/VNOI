{
ID: hoangducv1
PROG: clocks
LANG: PASCAL
}

uses math;
type
        mang = array[1..9] of integer;
var     fi,fo: text;
        a: array[1..9] of integer;

procedure input;
var     i: integer;
begin
        for i:=1 to 9 do begin
                read(fi,a[i]);
                a[i] := a[i] div 3;
        end;
end;

function calmove(x:integer):integer;
begin
        x:= x mod 4;
        if (x <> 0) then  calmove:=4-x
        else              calmove:=0;
end;

function better(v,vmin: mang):boolean;
var     i: integer;
begin
        better:= false;
        for i:=1 to 9 do begin
                if (v[i] > vmin[i]) then begin better:=true; exit; end;
                if (v[i] < vmin[i]) then exit;
        end;
end;

procedure process;
var     i1,i2,i3,i4,i5,i6,i7,i8,i9: integer;
        j, k, cnt, min: integer;
        v, vmin: mang;
        first: boolean;
begin
        //
        min:= 1000;

        //
        for i1:=0 to 3 do
        for i2:=0 to 3 do
        for i3:=0 to 3 do begin
                //
                i4:= calmove(a[1]+i1+i2);
                i5:= calmove(a[2]+i1+i2+i3);
                i6:= calmove(a[3]+i2+i3);
                i7:= calmove(a[4]+i1+i4+i5);
                i8:= calmove(a[7]+i4+i7);
                i9:= calmove(a[6]+i3+i5+i6);



                //
                if (calmove(a[5]+i1+i3+i5+i7+i9) <> 0) then continue;
                if (calmove(a[8]+i5+i7+i8+i9) <> 0) then continue;
                if (calmove(a[9]+i6+i8+i9) <> 0) then continue;

                {
                if ((i1=2) and (i2=3) and (i4=1) and (i8=3) and (i9=1)) then begin
                        writeln(fo, i1, ' ', i2, ' ', i3);
                        writeln(fo, i4, ' ', i5, ' ', i6);
                        writeln(fo, i7, ' ', i8, ' ', i9);
                end;
                }

                //
                cnt:= i1+i2+i3+i4+i5+i6+i7+i8+i9;
                v[1]:= i1; v[2]:= i2; v[3]:= i3;
                v[4]:= i4; v[5]:= i5; v[6]:= i6;
                v[7]:= i7; v[8]:= i8; v[9]:= i9;
                if ((min>cnt) or ((min=cnt) and (better(v,vmin)))) then begin
                        min:= cnt;
                        for j:=1 to 9 do vmin[j]:= v[j];
                end;

        end;

        //
        first:= true;
        for j:=1 to 9 do
        for k:=1 to vmin[j] do begin
                if not first then write(fo, ' ');
                write(fo, j);
                first:= false;
        end;
        if not first then writeln(fo);
end;


BEGIN
        assign(fi,'clocks.in'); reset(fi);
        assign(fo,'clocks.out'); rewrite(fo);

        input;
        process;

        close(fi);
        close(fo);

END.