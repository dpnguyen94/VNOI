{$MODE OBJFPC}
program RandomTest;
uses JudgerV2;

procedure GenTest(const Fname: ansiString; n: Integer;
 w: Integer = 1000000000; h: Integer = 1000000000);
var
  f: TextFile;
  i: Integer;
begin
  TGenerator.CreateF(f, FName);
  try
    WriteLn(f, n, ' ', h);
    for i := 1 to n do
      WriteLn(f, Random(w) + 1, ' ', Random(h - 1) + 1);
  finally
    TGenerator.CloseF(f);
  end;
end;

procedure GenAZ;
var
  c: Char;
  v: Integer;
  n, w, h: Integer;
begin
  for c := 'a' to 'z' do
    begin
      if Random(2) = 0 then
        begin
          n := TGenerator.Rand(1, 100);
          w := TGenerator.Rand(100, 200);
          h := TGenerator.Rand(100, 200);
        end
      else
        begin
          n := TGenerator.Rand(1, 4000);
          w := TGenerator.Rand(1, 1000000000);
          h := TGenerator.Rand(2, 1000000000);
        end;
      GenTest('ROWING._' + c, n, w, h);
    end;
end;

begin
  GenTest('ROWING._1', 4, 10, 8);
  GenTest('ROWING._2', 8, 9, 9);
  GenTest('ROWING._3', 10, 100, 10);
  GenTest('ROWING._4', 100, 1000, 100);
  GenTest('ROWING._5', 500, 10000, 10000);
  GenTest('ROWING._6', 1000, 10000, 10000);
  GenTest('ROWING._7', 1111);
  GenTest('ROWING._8', 2222);
  GenTest('ROWING._9', 3333);
  GenTest('ROWING._0', 4000);
  GenAZ;
end.

