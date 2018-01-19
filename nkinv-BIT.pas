{$MODE OBJFPC}

Const   MaxN                    =       60000;

Var     N, R, X, i              :       Longint;
        F                       :       Array [ 0 .. MaxN ] Of Longint;

Function Get( X : Longint ) : Longint;
Begin
     Result := 0;
     While X <= MaxN Do
           Begin
                Inc( Result, F[ X ] );
                Inc( X, X And ( X Xor ( X - 1 ) ) );
           End;
End;

Procedure Update( X : Longint );
Begin
     If X = 0 Then Exit;
     While X >= 1 Do
           Begin
                Inc( F[ X ] );
                Dec( X, X And ( X Xor ( X - 1 ) ) );
           End;
End;

Begin
     Read( N );
     For i := 1 To N Do
         Begin
              Read( X );
              Inc( R, Get( X ) );
              Update( X - 1 );
         End;
     Write( R );
End.
