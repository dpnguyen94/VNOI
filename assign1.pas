uses math;
const
	inputfile = '';
  outputfile = '';
  maxN = 200 + 10;
//type

var
	fi,fo: text;
  ntest,test: longint;
  n,mid: longint;
  c: array[1..maxN,1..maxN] of longint;

  match: array[1..maxN] of longint;
  vs,free: array[1..maxN] of boolean;
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
	i,j: longint;
begin
	readln(fi,n);
  for i:= 1 to n do
  	for j:= 1 to n do
    	read(fi,c[i,j]);
end;

procedure dfs(u: longint);
var
	v: longint;
begin
	for v:= 1 to n do
		if (c[u,v] <= mid) then
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

function solve: boolean;
var
	i,save,cnt: longint;
begin
	fillchar(vs,sizeof(vs),false);
  fillchar(match,sizeof(match),0);

  cnt:= 0;
  repeat
  	save:= cnt;
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
          inc(cnt);
        end;
      end;
  until save = cnt;

  if (cnt = n) then exit(true);
  exit(false);
end;

procedure process;
var
	le,ri,res: longint;
begin
	le:= 0; ri:= maxint;
  while (le <= ri) do
  begin
		mid:= (le + ri) div 2;
    if solve then
    begin
			res:= mid;
			ri:= mid - 1;
    end
    else 	
    	le:= mid + 1;
  end;

  writeln(fo,res);
end;

procedure output;
//var
begin
end;


BEGIN
	openfile;
  input;
  process;
  output;
  closefile;
END.
