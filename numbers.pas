uses math;
const
	inputfile = '';
    outputfile = '';
//type

var
	fi,fo: text;


procedure openfile;
begin
	assign(fi,inputfile); reset(fi);
    assign(fo,outputfile); rewrite(fo);
end;

procedure input;
var
begin
end;

procedure process;
var
begin
end;

procedure output;
var
begin
end;

procedure closefile;
begin
	close(fi);
    close(fo);
end;


begin
	openfile;
    input;
    process;
    output;
    closefile;
end.
