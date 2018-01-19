{Nguyen Duc Phuong}
program chiakeo;
uses crt;
var     n: byte;
        a: array[1..200] of byte;
        b: array[1..200] of boolean;
        bd,pt: array[0..40000] of byte;
        w,t: word;

procedure input;
var     i: byte;
begin
        write('Nhap so goi : '); readln(n);
        for i:= 1 to n do
        begin
                write('Goi thu ',i,' co : '); readln(a[i]);
        end;
        t:= 0;
        for i:= 1 to n do t:= t+a[i];
        for i:= 1 to n do b[i]:= true;
end;

procedure process;
var     i,j: byte;
begin
        w:= 0; BD[w]:= 1; PT[w]:= 0;
        for i:= 1 to n do
        begin
                for j:= w downto 0 do
                if (BD[j] = 1) and (PT[j+a[i]] = 0) then
                begin
                        BD[j+a[i]]:= 1; PT[j+a[i]]:= i;
                end;
                inc(w,a[i]);
        end;
end;

procedure xuat;
var     k,i,min1,min2,m: word;
begin
        for i:= 0 to w do if (bd[i] = 1) and (i >= t/2) then
        begin
                min1:= i;
                break;
        end;
        for i:= w downto 0 do if (bd[i] = 1) and (i <= t/2) then
        begin
                min2:= i;
                break;
        end;
        if (min1 - t/2 <= t/2 - min2) then m:= min1 else m:= min2;
        k:= 0;
        repeat
                i:= PT[m];
                inc(k); BD[k]:= i; b[i]:= false;
                dec(m,a[i]);
        until m = 0;
        min1:= 0; min2:= 0;
        write('Nhom 1 gom cac goi: ');
        for i:= k downto 1 do begin
                write(bd[i],' ');
                min1:= min1+ a[bd[i]];
        end;
        writeln;
        //
        write('Nhom 2 gom cac goi: ');
        for i:= 1 to n do if (b[i]) then begin
                write(i,' ');
                min2:= min2+ a[i];
        end;
        writeln;
        //
        write('Chenh lech: ');
        write(abs(min1-min2));

end;



begin
        clrscr;
        input;
        process;
        xuat;
        readln;

end.
