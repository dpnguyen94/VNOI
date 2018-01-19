{
ID: hoangducv1
PROG: ariprog
LANG: PASCAL
}

uses math;
const   MAX_M = 125000;
var     fi,fo: text;
        b: array[0..MAX_M] of boolean;
		d: array[0..MAX_M] of byte;
        a: array[0..MAX_M] of longint;
        n,m,cnt: longint;

procedure init;
var     i,j: longint;
begin
        fillchar(b,sizeof(b),false);
        for i:= 0 to m do
         for j:= 0 to m do b[i*i+j*j]:= true;
        //
        cnt:= 0;
        for i:= 0 to m*m do
         if b[i] then begin
                inc(cnt);
                a[cnt]:= i;
         end;
end;

procedure process;
var     i,j,k,x,t1,t2: longint;
        exist: boolean;
begin
        exist:= false;
        t1:= 2*m*m;
        t2:= t1 div (n-1);
        //
        for i:= 1 to t2 do begin
				fillchar(d,sizeof(d),0);
                for j:= 1 to cnt do begin
						//
						if d[i] <> 0 then begin
							if d[i] = 1 then writeln(fo,a[j],' ', i);
							continue;
						end;
						
						//
						k:= 1; x:= a[j];
						repeat
							x:= x + i;
							if (x > t1) or (not b[x]) then break;
							inc(k);
						until false;
						
						//
                        if k>=n then begin
                                exist:= true;
                                writeln(fo,a[j],' ',i);
								for x:= 1 to k-n do d[a[j]+k*i]:= 1;		// mark to print and skip
								for x:= k-n+1 to k do d[a[j]+k*i]:= 2;		// mark to skip only
                        end;
                end;
        end;
        //
        if not exist then writeln(fo,'NONE');
end;


begin
        assign(fi,'ariprog.in'); reset(fi);
        assign(fo,'ariprog.out'); rewrite(fo);
        //
        readln(fi,n);
        readln(fi,m);
        init;
        process;
        //
        close(fi);
        close(fo);
end.
