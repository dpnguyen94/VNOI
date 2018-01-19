program ttravel;
uses crt;
const   MAX_N = 100000;
var     fi,fo: text;
        cow,par: array[0..MAX_N] of longint;
        n: longint;

procedure process;
var     i,k,time: longint;
        c: char;
begin
        readln(fi,n);
        cow[0]:= -1;
        par[0]:= -1;
        for i:= 1 to n do begin
                read(fi,c);
                if (c = 'a') then begin
                        read(fi,k);
                        par[i]:= i-1;
                        cow[i]:= k;
                        readln(fi);
                end;
                if (c = 's') then begin
                        par[i]:= par[par[i-1]];
                        cow[i]:= cow[par[i-1]];
                        readln(fi);
                end;
                if (c = 't') then begin
                        read(fi,k);
                        par[i]:= par[k-1];
                        cow[i]:= cow[k-1];
                        readln(fi);
                end;
                //
                writeln(fo,cow[i]);
        end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        process;
        //
        close(fi);
        close(fo);
end.