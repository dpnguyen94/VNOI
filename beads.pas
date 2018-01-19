{
ID : ndchiph1;
PROG : beads
LANG : PASCAL
}

program beads;
uses crt;
const   fi = 'beads.in';
        fo = 'beads.out';
var     s,t: ansistring;
        l: integer;
        p: array[1..350] of integer;
        b: array[1..350] of boolean;
        f: text;


procedure input;
var c:char;i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,l);
        for i:=1 to l do begin read(f,c);s:=s+c;end;
        close(f);
end;

procedure init;
var     i: integer;
begin
        for i:= 1 to l do p[i]:= 0;
end;

procedure process;
var     i,j: integer;
        c: char;
begin
        //process
        for i:= 1 to l do
        begin
                t:= s + copy(s,1,i);
                delete(t,1,i);
                //
                for j:= 1 to l do b[j]:= true;

                //dau
                if t[1] = 'w' then
                begin
                        j:= 1;
                        while (t[j] = 'w') do inc(j);
                        c:= t[j];
                        j:= 1;
                        while (t[j] = 'w') or (t[j] = c) do
                        begin
                                if j > l then break;
                                inc(p[i]);
                                b[j]:= false;
                                inc(j);
                        end;
                end
                else
                begin
                        j:= 1;
                        while (t[j] = t[1]) or (t[j] = 'w') do
                        begin
                                if j > l then break;
                                inc(p[i]);
                                b[j]:= false;
                                inc(j);
                        end;
                end;

                //cuoi
                if t[l] = 'w' then
                begin
                        j:= l;
                        while (t[j] = 'w') do dec(j);
                        c:= t[j];
                        j:= l;
                        while (t[j] = 'w') or (t[j] = c) do
                        begin
                                if j < 1 then break;
                                if (b[j]) then inc(p[i]);
                                dec(j);
                        end;

                end
                else
                begin
                        j:= l;
                        while (t[j] = t[l]) or (t[j] = 'w') do
                        begin
                                if j < 1 then break;
                                if (b[j]) then inc(p[i]);
                                dec(j);
                        end;
                end;
        end;
end;

procedure output;
var     i,max: integer;
begin
        max:= p[1];
        for i:= 2 to l do
                if p[i] > max then max:= p[i];
        assign(f,fo); rewrite(f);
        writeln(f,max);
        close(f);
end;

begin
        clrscr;
        input;
        init;
        //
        process;
        output;
        //readln;
end.
;
        input;
        init;
        //
        process;
        output;
        //readln;
end.
