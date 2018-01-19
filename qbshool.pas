{$MODE OBJFPC}
PROGRAM qbschool ;

 Const

  Fi = '';
  Fo = '';
  maxN = 5000 ;
  maxM = 40001;
  maxD = high( integer ) - 1  ;

 Type
     Tedge = Record
       u ,v : integer ;
       w : integer;

       End;

 Var

  link  ,head : array[1..maXM] of integer ;
  f : text ;
  d:  array[1..maxN] of int64 ;
  s , t:  integer ;
  e : array[1..maxM] of TEdge ;
  g : array[1..maxN] of int64 ;
  heap  : array[0..maxM] of integer ;
  pos : array[1..maxN] of integer ;
  nheap , n , m : integer ;

 Procedure Enter ;

  var i  , w , u , v , k , t : integer ;

  Begin
       Assign(f , fi );  Reset( f );
       Readln(f , n , m ) ;
       t := 0 ;
       For i := 1 to m do

        Begin

              readln(f, k , u ,v , w);
              Case k of

                1 : Begin
                        inc( t , 1 ) ;
                        e[ t ]. u := u ;
                        e[ t ].v := v ;
                        e[ t ].w := w ;
                        link[ t ] := head[ u ];
                        head[ u ] := t ;
                    end ;
                2 : Begin
                         inc( t , 2 );
                         link[ t ] := head[ u ] ;
                          head[ u ] := t ;
                         link[ t - 1 ] := head[ v ];

                         head[v] := t - 1 ;
                         e[ t ].u := u ; e[ t ].v := v ; e[ t ].w := w;
                         e[ t - 1].v := u ;e[t-1].u := v ;e[t-1].w := w ;
                    end ;

                    end ;
        end ;
        m := t ;
        Close( f );
  end ;

 Procedure Init ;

  var i : integer;

  Begin
       s := 1 ;
       t := n ;
       For i := 1 to n do d[ i ] := maxD ;
     //  for i := 1 to n do g[ i ] := 1 ;
     g[1] := 1 ;
       d[ s ] := 0 ;
       heap[ s ] := 1 ;
       nheap := 1 ;
       pos[ s ] := 1;
  end;

 Procedure Update( v : integer );

  var p , c : integer ;

  begin
       c := pos[ v ];
       If c = 0 then
           Begin
                Inc( nheap ) ;
                c := nheap ;
           end ;

       Repeat
              p := c div 2 ;
              if ( p = 0 ) or ( d[ heap[ p ] ] <= d[ v ] ) then break ;
              heap[ c ] := heap[ p ] ;
              pos[heap[ c ] ] := c ;
              c := p ;
       Until False ;
       heap[ c ] := v ;
       pos[ v ] := c ;
  end ;

 Function Extract : integer ;

  var p , v , c : integer ;

  Begin
       Result := heap[ 1 ];
        v := heap[ nheap ] ;
        Dec(nheap );
        p := 1 ;
       Repeat
             c := p * 2 ;
             If ( c < nheap ) and ( d[ heap[ c+1]]< d[heap[c]] ) then Inc(c);
             If ( c > nheap ) or ( d[v] <= d[heap[c]] ) then Break ;
             heap[ p ] := heap [ c ];
             pos[ heap[p] ] := p ;
             p := c ;
       Until False ;
       heap[ p ] := v ;
       pos[ v ] := p ;
  end ;


 Function Relax( u ,v ,w : integer ) : Boolean ;

  Begin
       Result := d[ v ] > d[ u ] + w ;
        If Result then
                        Begin
                             d[ v ] := d[ u ] + w ;

                             g[ v ] := g[ u ]  ;
                        end
                         Else If d[ v ] = d[ u ] + w then g[ v ] := g[v] + g[ u ];
  end ;

 Procedure Dijkstra ;

 var u  , v,  i : integer ;

 Begin
      init ;
      Repeat
                u := Extract ;
                If ( u = 0 ) or ( u = t ) then Break ;
                i := head[ u ] ;

                While i <> 0 do

                  Begin
                      If Relax( u , e[i].v , e[i].w ) then Update(e[i].v );
                      i := link[ i ] ;
                  end ;
      Until nheap = 0 ;
 End ;

Procedure Print ;

 Begin
      Assign( f, fo ) ; Rewrite(f);
      Writeln(f , d[ t ],' ',g[ t ]  ) ;
      Close( f );
 end ;

Begin
    Enter;
    Dijkstra ;
    Print ;
End.
