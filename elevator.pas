uses math;
const   MAX_K = 400;
        MAX_A = 40000;
var     fi,fo: text;
        k: longint;
        h,c,a: array[1..MAX_K] of longint;
        f: array[0..MAX_A] of boolean;


procedure swap(var x,y: longint);
var     z: longint;
begin
        z:= x; x:= y; y:= z;
end;

procedure input;
var     i,j: longint;
begin
        readln(fi,k);
        for i:= 1 to k do readln(fi,h[i],a[i],c[i]);

        //sort;
        for i:= 1 to k-1 do
         for j:= i+1 to k do
          if a[i] > a[j] then begin
                swap(a[i],a[j]);
                swap(h[i],h[j]);
                swap(c[i],c[j]);
          end;
end;

procedure DP;
var     i,j,t: longint;
begin
        fillchar(f,sizeof(f),false);
        f[0]:= true;
        //
        for i:= 1 to k do begin
                for j:= a[i] downto 0 do begin
                        for t:= 1 to c[i] do begin
                                if (f[j]) and (j+t*h[i] <= a[i]) then
                                 f[j+t*h[i]]:= true;
                        end;
                end;
        end;
        //
        for i:= MAX_A downto 0 do
         if f[i] then begin
                writeln(fo,i);
                break;
         end;
end;

begin
        assign(fi,''); reset(fi);
        assign(fo,''); rewrite(fo);
        //
        input;
        DP;
        //
        close(fi);
        close(fo);
end.
