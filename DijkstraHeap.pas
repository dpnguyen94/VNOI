uses math;
const
        finp='';
        fout='';
        maxn=1000;
        maxc=1000000000;
var
        fi,fo:text;
        n,m,s,t,nheap:longint;
        a:array[1..maxn,1..maxn] of longint;
    	f,heap,cs:array[1..maxn] of longint;
	    free: array[1..maxn] of boolean;

procedure mofile;
begin
        assign(fi,finp);
        reset(fi);
        assign(fo,fout);
        rewrite(fo);
end;

procedure dongfile;
begin
        close(fi);
        close(fo);
end;

procedure nhap;
var
        i,j,u,v,c:longint;
begin
        readln(fi,n,m,s,t);
        for i:=1 to n do
        	for j:=1 to n do a[i,j]:=maxc;

        for i:=1 to m do
        begin
                readln(fi,u,v,c);
                a[u,v]:=c;
                a[v,u]:=c;
        end;
end;

procedure inkq;
begin
        writeln(fo,f[t]);
end;

function extract:longint;
var
        d,c,luu:longint;
begin
        extract:=heap[1];

        //
        luu:=heap[nheap];
        dec(nheap);
        d:=1;
        repeat
                c:=d*2;
                if (c+1<=nheap) and (f[heap[c]]>f[heap[c+1]]) then inc(c);
                if (c>nheap) or (f[heap[c]]>=f[luu]) then break;
                heap[d]:=heap[c];
                cs[heap[d]]:=d;
                d:=c;
        until false;

        heap[d]:=luu;
        cs[luu]:=d;
end;

procedure update(x:longint);
var
        d,c,luu:longint;
begin
        luu:=heap[x];
        d:=x;
        repeat
                c:=d div 2;
                if (c=0) or (f[heap[c]]<=f[luu]) then break;
                heap[d]:=heap[c];
                cs[heap[d]]:=d;
                d:=c;
        until false;

        heap[d]:=luu;
        cs[luu]:=d;
end;

procedure xuly;
var
        i,bien,u:longint;
begin
        for i:=1 to n do f[i]:=maxc;
        fillchar(free,sizeof(free),true);

        f[s]:=0;
        cs[s]:=1;
        heap[1]:=s;
        bien:=1;
        nheap:=n;

        for i:=1 to n do
	        if i<>s then
    	    begin
        		inc(bien);
                cs[i]:=bien;
            	heap[bien]:=i;
  		    end;

        repeat
        	u:=extract;
            free[u]:= false;

            for i:=1 to n do
            if free[i] and (a[u,i]<>maxc) and (f[i]>f[u]+a[u,i]) then
            begin
            	f[i]:=f[u]+a[u,i];
                update(cs[i]);
            end;
        until nheap = 0;;
end;


begin
        mofile;
        nhap;
        xuly;
        inkq;
        dongfile;
end.
