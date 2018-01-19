program qbhv;
uses crt;
const   fi = '';
        fo = '';
var     s: string;
        f: array[0..9] of longint;
        a: array[65..90] of 0..9;
        n: integer;
        sl: longint;
        c: char;
        t: text;

procedure swap(var c1,c2: char);
var     c: char;
begin
        c:= c1; c1:= c2; c2:= c;
end;

procedure init;
var     i,j: integer;
begin
        readln(t,s);
        n:= length(s);
        //init;
        f[0]:= 1;
        for i:= 1 to n do f[i]:= f[i-1]*i;
        //sort;
        for i:= 1 to n-1 do
         for j:= i+1 to n do if (s[i] > s[j]) then swap(s[i],s[j]);
end;

procedure calc;
var     i: integer;
begin
        fillchar(a,sizeof(a),0);
        for i:= 1 to n do inc(a[ord(s[i])]);
        sl:= f[n];
        for i:= 65 to 90 do sl:= sl div f[a[i]];
        writeln(t,sl);
end;

procedure gen;
var     i,j,k,l,r: integer;
begin
        writeln(t,s);
        i:= 0;
        for j:= n-1 downto 1 do
                if (s[j] < s[j+1]) then begin
                        i:= j; break;
                end;
        if i = 0 then exit;
        //
        k:= n;
        while (s[k] <= s[i]) do dec(k);
        swap(s[k],s[i]);
        //
        l:= i+1; r:= n;
        while (l < r) do begin
                swap(s[l],s[r]);
                inc(l); dec(r);
        end;
        gen;
end;

begin
        assign(t,fi); reset(t);
        init;
        close(t);
        assign(t,fo); rewrite(t);
        calc;
        gen;
        close(t);
end.
