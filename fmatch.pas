uses math;
const
	inputfile = '';
  outputfile = '';
  LM = 50000 + 10;
  maxP = 150000 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,m,p,res: longint;
  x,y,a: array[1..maxP] of longint;
  h,match: array[1..LM] of longint;

  vs,free: array[1..LM] of boolean;
  exist: boolean;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
  assign(fo,outputfile); rewrite(fo);
end;

procedure closefile;
begin
	close(fi);
  close(fo);
end;

procedure input;
var
	i,u,v: longint;
begin
	readln(fi,n,m,p);

  for i:= 1 to p do
  begin
  	readln(fi,u,v);
    inc(h[u]);
		
    x[i]:= u;
    y[i]:= v;
  end;

  for i:= 2 to n + 1 do
  	h[i]:= h[i - 1] + h[i];

  for i:= 1 to p do
  begin
  	u:= x[i];
    v:= y[i];

    a[h[u]]:= v;

    dec(h[u]);
  end;
end;

procedure dfs(u: longint);
var
	i,v: longint;
begin
	for i:= h[u] + 1 to h[u + 1] do
  begin
		v:= a[i];

		if free[v] then
    begin
			free[v]:= false;
      if (match[v] = 0) then exist:= true
      else dfs(match[v]);

      if exist then
      begin
      	match[v]:= u;
        exit;
      end;
    end;
  end;
end;

procedure process;
var
	i,save: longint;
begin
	res:= 0;
	repeat
  	save:= res;
    fillchar(free,sizeof(free),true);

    //
		for i:= 1 to n do
    	if not vs[i] then
      begin
      	exist:= false;
        dfs(i);

        if exist then
        begin
          vs[i]:= true;
          inc(res);
        end;
      end;
  until save = res;
end;

procedure output;
begin
	writeln(fo,res);
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
