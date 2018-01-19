program rocks;
uses crt;
var     fi,fo: text;
        a: array[0..70000] of longint;
        vs: array[0..70000] of boolean;
        f: array[0..16] of longint =
        (1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536);
        n: integer;

function get_bit(x: longint; i: integer): integer;
begin
        get_bit:= (x shr i) and 1;
end;

function valid: boolean;
var     i,cnt: integer;
begin
        cnt:= 0;
        for i:= 0 to n-1 do
         if (get_bit(a[f[n]-1],i) <> 0) then inc(cnt);
        //
        if (cnt = 1) then exit(true)
        else exit(false);
end;

procedure print;
var     i,j: longint;
begin
        for i:= 0 to f[n]-1 do begin
                for j:= n-1 downto 0 do
                 if (get_bit(a[i],j) = 0) then write(fo,'O')
                 else write(fo,'X');
                writeln(fo);
        end;
        for i:= 1 to n do write(fo,'O');
        writeln(fo);
        close(fo);
        halt;
end;

procedure attempt(i: longint);
var     j,t: integer;
begin
        if (i = f[n]) then
         if (valid) then print
         else exit;

        for j:= 0 to n-1 do begin
                t:= get_bit(a[i-1],j);
                if (t = 0) then begin
                        a[i]:= a[i-1] + f[j];
                        if (not vs[a[i]]) then begin
                                vs[a[i]]:= true;
                                attempt(i+1);
                                vs[a[i]]:= false;
                        end;
                end
                else begin
                        a[i]:= a[i-1] - f[j];
                        if (not vs[a[i]]) then begin
                                vs[a[i]]:= true;
                                attempt(i+1);
                                vs[a[i]]:= false;
                        end;
                end;
        end;
end;

procedure process;
begin
        fillchar(vs,sizeof(vs),false);
        a[0]:= 0;
        vs[a[0]]:= true;
        attempt(1);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        readln(fi,n);
        process;
        //
        close(fi);
end.
