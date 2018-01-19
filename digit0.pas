program digit0;
uses crt;
var     s: ansistring;
        c: array[0..10] of longint;
        a: array[1..200] of longint;
        fi,fo: text;

procedure init;
var     i: integer;
begin
        c[0]:= 1;
        for i:= 1 to 10 do c[i]:= c[i-1]*5;
end;

function count(a: longint): longint;
var     t,i: longint;
begin
     	t:= 0; i:= 1;
        while (c[i] <= a) do begin
                t:= t+(a div c[i]);
                inc(i);
        end;
        exit(t);
end;

procedure process;
var     t,i: longint;
begin
        readln(fi,s);
        t:= count(length(s));
        //
        fillchar(a,sizeof(a),0);
        for i:= 1 to length(s) do inc(a[ord(s[i])]);
        //
        for i:= 97 to 122 do
        	dec(t,count(a[i]));
		if (t = 1) then dec(t);
        writeln(fo,t);
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        init;
        process;
        //
        close(fi);
        close(fo);
end.
