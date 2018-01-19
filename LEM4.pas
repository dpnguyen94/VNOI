const
  finp  = 'lem4.in1';
  fout  = 'lem4.out';
  maxn  = 10050;

var
  fi, fo          : text;
  Left, Right, T  : array[1..maxn * 4] of longint;
  Last            : array[1..maxn * 4] of longint;
  n, m            : longint;


procedure OpenF;
  begin
    assign(fi, finp);
    reset(fi);
    assign(fo, fout);
    rewrite(fo);
  end;

procedure CloseF;
  begin
    close(fi);
    close(fo);
  end;

procedure Enter;
  begin
    readln(fi, n);
    readln(fi, m);
  end;

procedure Init;
  var i : longint;
  begin
  end;

function Max(x, y : longint) : longint;
  begin
    if x > y then max := x
    else max := y;
  end;

function Min(x, y : longint) : longint;
  begin
    if x < y then min := x
    else min := y;
  end;

procedure Update(k, L, R, u, v, val : longint);
  var Mid : longint;
  begin
    if (L = u) and (R = v) then
      begin
        Case Val of
          1 : T[k] := R - L + 1;
          2 : T[k] := 0;
        end;
        Left[k]    := T[k];
        Right[k]   := T[k];
        Last[k]    := Val;
        exit;
      end;

    Mid := (L + R) shr 1;

    if Last[k] <> 0 then
      begin
        Case Last[k] of
          1 :
            begin
              T[k shl 1]      := Mid - L + 1;
              T[k shl 1 + 1]  := R - Mid;
            end;
          2 :
            begin
              T[k shl 1]      := 0;
              T[k shl 1 + 1]  := 0;
            end;
        end;

        Left[k shl 1]         := T[k shl 1];
        Right[k shl 1]        := T[k shl 1];
        Last[k shl 1]         := Last[k];

        Left[k shl 1 + 1]     := T[k shl 1 + 1];
        Right[k shl 1 + 1]    := T[k shl 1 + 1];
        Last[k shl 1 + 1]     := Last[k];

        Last[k]               := 0;
      end;

    if (u <= Mid) then Update(k shl 1, L, Mid, u, min(v, Mid), Val);
    if (Mid + 1 <= v) then Update(k shl 1 + 1, Mid + 1, R, max(u, Mid + 1), v, Val);

    T[k]      := max(T[k shl 1], T[k shl 1 + 1]);
    T[k]      := max(T[k], Right[k shl 1] + Left[k shl 1 + 1]);

    Left[k]   := Left[k shl 1];
    if Left[k] = (Mid - L + 1) then inc(Left[k], Left[k shl 1 + 1]);

    Right[k]  := Right[k shl 1 + 1];
    if Right[k] = (R - Mid) then inc(Right[k], Right[k shl 1]);
  end;

function Get(X, Y: longint) : longint;
  var u, v, res : longint;

  procedure Visit(k, Top, Bot : longint; var L, R : longint);
    var L1, R1, L2, R2, Mid : longint;
    begin

      L := -maxlongint div 2;
      R := -maxlongint div 2;

      if (Top = X) and (Bot = Y) then
        begin
          L   := Left[k];
          R   := Right[k];
          res := max(res, T[k]);
          exit;
        end;

      Mid := (L + R) shr 1;

      if Last[k] <> 0 then
        begin
          Case Last[k] of
            1 :
              begin
                T[k shl 1]      := Mid - L + 1;
                T[k shl 1 + 1]  := R - Mid;
              end;
            2 :
              begin
                T[k shl 1]      := 0;
                T[k shl 1 + 1]  := 0;
              end;
          end;

          Left[k shl 1]         := T[k shl 1];
          Right[k shl 1]        := T[k shl 1];
          Last[k shl 1]         := Last[k];

          Left[k shl 1 + 1]     := T[k shl 1 + 1];
          Right[k shl 1 + 1]    := T[k shl 1 + 1];
          Last[k shl 1 + 1]     := Last[k];

          Last[k]               := 0;
        end;

      if (X <= Mid)     then Visit(k * 2, Top, Mid, L1, R1);
      if (Mid + 1 <= Y) then Visit(k * 2 + 1, Mid + 1, Bot, L2, R2);

      if Top >= X then
        begin
          L := L1;
          if L1 = (Mid - Top + 1) then L := L + L2;
        end;

      if Bot <= Y then
        begin
          R := R2;
          if R2 = (Bot - Mid) then R := R + R1;
        end;

    res := max(res, R1 + L2);

    end;

  begin
    res := -maxlongint div 2;
    Visit(1, 1, n, u, v);
  end;

procedure Solve;
  var i, q, u, v  : longint;
  begin
    Update(1, 1, n, 1, n, 1);
    for i := 1 to m do
      begin
        read(fi, q);
        if q = 3 then writeln(fo, T[1])
        else
          begin
            readln(fi, u, v);
            Update(1, 1, n, u, v, q);
          end;
      end;
  end;

procedure Print;
  begin
  end;

BEGIN
  OpenF;
  Enter;
  Init;
  Solve;
  Print;
  CloseF;
END.
