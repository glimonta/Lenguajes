:- dynamic blanco/2.
:- dynamic turno/1.
:- dynamic negro/2.
:- dynamic vacio/2.
:- dynamic reyBlanco/2.
:- dynamic reyNegro/2.

imprimirTablero:-
  write('    1    2    3    4    5    6    7    8 '), nl,
  write(1), imprimirCasilla(1,1), imprimirCasilla(1,2), imprimirCasilla(1,3), imprimirCasilla(1,4), imprimirCasilla(1,5), imprimirCasilla(1,6), imprimirCasilla(1,7), imprimirCasilla(1,8), nl,
  write(2), imprimirCasilla(2,1), imprimirCasilla(2,2), imprimirCasilla(2,3), imprimirCasilla(2,4), imprimirCasilla(2,5), imprimirCasilla(2,6), imprimirCasilla(2,7), imprimirCasilla(2,8), nl,
  write(3), imprimirCasilla(3,1), imprimirCasilla(3,2), imprimirCasilla(3,3), imprimirCasilla(3,4), imprimirCasilla(3,5), imprimirCasilla(3,6), imprimirCasilla(3,7), imprimirCasilla(3,8), nl,
  write(4), imprimirCasilla(4,1), imprimirCasilla(4,2), imprimirCasilla(4,3), imprimirCasilla(4,4), imprimirCasilla(4,5), imprimirCasilla(4,6), imprimirCasilla(4,7), imprimirCasilla(4,8), nl,
  write(5), imprimirCasilla(5,1), imprimirCasilla(5,2), imprimirCasilla(5,3), imprimirCasilla(5,4), imprimirCasilla(5,5), imprimirCasilla(5,6), imprimirCasilla(5,7), imprimirCasilla(5,8), nl,
  write(6), imprimirCasilla(6,1), imprimirCasilla(6,2), imprimirCasilla(6,3), imprimirCasilla(6,4), imprimirCasilla(6,5), imprimirCasilla(6,6), imprimirCasilla(6,7), imprimirCasilla(6,8), nl,
  write(7), imprimirCasilla(7,1), imprimirCasilla(7,2), imprimirCasilla(7,3), imprimirCasilla(7,4), imprimirCasilla(7,5), imprimirCasilla(7,6), imprimirCasilla(7,7), imprimirCasilla(7,8), nl,
  write(8), imprimirCasilla(8,1), imprimirCasilla(8,2), imprimirCasilla(8,3), imprimirCasilla(8,4), imprimirCasilla(8,5), imprimirCasilla(8,6), imprimirCasilla(8,7), imprimirCasilla(8,8). nl,
  nl.

imprimirCasilla(X,Y):-
  vacio(X,Y), !,
  write(' |  |').

imprimirCasilla(X,Y):-
  negro(X,Y), !,
  write(' |< |').

imprimirCasilla(X,Y):-
  blanco(X,Y), !,
  write(' | >|').

imprimirCasilla(X,Y):-
  reyNegro(X,Y), !,
  write(' |<<|').

imprimirCasilla(X,Y):-
  rey_blanco(X,Y), !,
  write(' |>>|').

inicializarTablero:-
assert(vacio(1,1)), assert(blanco(1,2)), assert(vacio(1,3)), assert(blanco(1,4)), assert(vacio(1,5)), assert(blanco(1,6)), assert(vacio(1,7)), assert(blanco(1,8)),
assert(blanco(2,1)), assert(vacio(2,2)), assert(blanco(2,3)), assert(vacio(2,4)), assert(blanco(2,5)), assert(vacio(2,6)), assert(blanco(2,7)), assert(vacio(2,8)),
assert(vacio(3,1)), assert(blanco(3,2)), assert(vacio(3,3)), assert(blanco(3,4)), assert(vacio(3,5)), assert(blanco(3,6)), assert(vacio(3,7)), assert(blanco(3,8)),
assert(vacio(4,1)), assert(vacio(4,2)), assert(vacio(4,3)), assert(vacio(4,4)), assert(vacio(4,5)), assert(vacio(4,6)), assert(vacio(4,7)), assert(vacio(4,8)),
assert(vacio(5,1)), assert(vacio(5,2)), assert(vacio(5,3)), assert(vacio(5,4)), assert(vacio(5,5)), assert(vacio(5,6)), assert(vacio(5,7)), assert(vacio(5,8)),
assert(negro(6,1)), assert(vacio(6,2)), assert(negro(6,3)), assert(vacio(6,4)), assert(negro(6,5)), assert(vacio(6,6)), assert(negro(6,7)), assert(vacio(6,8)),
assert(vacio(7,1)), assert(negro(7,2)), assert(vacio(7,3)), assert(negro(7,4)), assert(vacio(7,5)), assert(negro(7,6)), assert(vacio(7,7)), assert(negro(7,8)),
assert(negro(8,1)), assert(vacio(8,2)), assert(negro(8,3)), assert(vacio(8,4)), assert(negro(8,5)), assert(vacio(8,6)), assert(negro(8,7)), assert(vacio(8,8)).

proximoJugador(blanco, negro).
proximoJugador(negro, blanco).

imprimirJugador(blanco):- write('Juega jugador 1'), nl, nl.
imprimirJugador(negro):-  write('Juega jugador 2'), nl, nl.

jugar:-
  write('Desea jugar con la máquina? (s/n)?'),
  read(R),
  ((R = s,!,
  write('Error 404: Maquina not found.'));
  (R = n,
  write('Comenzó el juego'), nl,
  inicializarTablero,
  imprimirTablero,
  assert(turno(blanco)),
  imprimirJugador(blanco))).


jugada(X1,Y1,X2,Y2):-
  reyNegro(X1,Y1),
  turno(negro),
  vacio(X2,Y2), !,
  comerReyNegro(X1,Y1,X2,Y2),

jugada(X1,Y1,X2,Y2):-
  reyNegro(X1,Y1),
  turno(negro),
  vacio(X2,Y2), !,
  moverReyNegro(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  reyBlanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2), !,
  comerReyBlanco(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  reyBlanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2), !,
  moverReyBlanco(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  blanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2), !,
  comerBlanco(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  blanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2), !,
  moverBlanco(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  negro(X1,Y1),
  turno(negro),
  vacio(X2,Y2), !,
  comerNegro(X1,Y1,X2,Y2).

jugada(X1,Y1,X2,Y2):-
  negro(X1,Y1),
  turno(negro),
  vacio(X2,Y2), !,
  moverNegro(X1,Y1,X2,Y2).


comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyAD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyAI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyDD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyDI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonAD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonAI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonDD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonDI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyAD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyAI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyDD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyDI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonAD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonAI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonDD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonDI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


validoComerReyBlancoAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 + 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerReyBlancoAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 - 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerReyBlancoDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 + 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerReyBlancoDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 - 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerReyNegroAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 + 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerReyNegroAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 - 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerReyNegroDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 + 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerReyNegroDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 - 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoAD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoAI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoDD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoDI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),


moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroAD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroAI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroDD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroDI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),


vaciosDiagonalAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =:= HastaX,
  vacio(DesdeX, DesdeY), !.

vaciosDiagonalAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalAD(NuevoX, NuevoY, HastaX, HastaY).


vaciosDiagonalAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =:= HastaX,
  vacio(DesdeX, DesdeY), !.

vaciosDiagonalAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalAD(NuevoX, NuevoY, HastaX, HastaY).


vaciosDiagonalDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =:= HastaX,
  vacio(DesdeX, DesdeY), !.

vaciosDiagonalDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalAD(NuevoX, NuevoY, HastaX, HastaY).


vaciosDiagonalDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =:= HastaX,
  vacio(DesdeX, DesdeY), !.

vaciosDiagonalDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalAD(NuevoX, NuevoY, HastaX, HastaY).

validoMoverReyBlancoAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - (X2 - X1),
  Y2 =:= Y1 + (Y2 - Y1),
  vaciosDiagonalAD(X1+1,Y1+1,X2,Y2).

validoMoverReyBlancoAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - (X2 - X1),
  Y2 =:= Y1 - (X2 - X1),
  vaciosDiagonalAI(X1+1,Y1+1,X2,Y2).

validoMoverReyBlancoDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + (X2 - X1),
  Y2 =:= Y1 + (X2 - X1),
  vaciosDiagonalDD(X1+1,Y1+1,X2,Y2).

validoMoverReyBlancoDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + (X2 - X1),
  Y2 =:= Y1 - (X2 - X1),
  vaciosDiagonalDI(X1+1,Y1+1,X2,Y2).

validoMoverReyNegroAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - (X2 - X1),
  Y2 =:= Y1 + (X2 - X1),
  vaciosDiagonalAD(X1+1,Y1+1,X2,Y2).

validoMoverReyNegroAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - (X2 - X1),
  Y2 =:= Y1 - (X2 - X1),
  vaciosDiagonalAI(X1+1,Y1+1,X2,Y2).

validoMoverReyNegroDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + (X2 - X1),
  Y2 =:= Y1 + (X2 - X1),
  vaciosDiagonalDD(X1+1,Y1+1,X2,Y2).

validoMoverReyNegroDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + (X2 - X1),
  Y2 =:= Y1 - (X2 - X1),
  vaciosDiagonalDI(X1+1,Y1+1,X2,Y2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyAD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyAI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyDD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyDI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonAD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonAI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonDD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonDI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyAD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyAI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyDD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyDI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonAD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1-1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1-1,Y1+1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonAI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1-1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1-1,Y1-1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonDD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1+1,Y1+1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1+1,Y1+1)).

comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonDI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(X1+1,Y1-1)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(X1+1,Y1-1)).


validoComerBlancoAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 + 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerBlancoAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 - 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerBlancoDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 + 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerBlancoDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 - 2,
  (reyNegro(X1+1,Y1+1) ; negro(X1+1,Y1+1)).

validoComerNegroAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 + 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerNegroAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 2,
  Y2 =:= Y1 - 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerNegroDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 + 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

validoComerNegroDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 2,
  Y2 =:= Y1 - 2,
  (reyBlanco(X1+1,Y1+1) ; blanco(X1+1,Y1+1)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoAD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoAI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoDD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),

moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoDI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),


moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroAD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroAI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroDD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),

moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroDI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),


validoMoverBlancoAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 1,
  Y2 =:= Y1 + 1,
  vacio(X2,Y2).

validoMoverBlancoAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 1,
  Y2 =:= Y1 - 1,
  vacio(X2,Y2).

validoMoverBlancoDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 1,
  Y2 =:= Y1 + 1,
  vacio(X2,Y2).

validoMoverBlancoDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 1,
  Y2 =:= Y1 - 1,
  vacio(X2,Y2).

validoMoverNegroAD(X1,Y1,X2,Y2):-
  X2 =:= X1 - 1,
  Y2 =:= Y1 + 1,
  vacio(X2,Y2).

validoMoverNegroAI(X1,Y1,X2,Y2):-
  X2 =:= X1 - 1,
  Y2 =:= Y1 - 1,
  vacio(X2,Y2).

validoMoverNegroDD(X1,Y1,X2,Y2):-
  X2 =:= X1 + 1,
  Y2 =:= Y1 + 1,
  vacio(X2,Y2).

validoMoverNegroDI(X1,Y1,X2,Y2):-
  X2 =:= X1 + 1,
  Y2 =:= Y1 - 1,
  vacio(X2,Y2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIXME CASOS BORDE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIXME CAMBIO TURNO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIXME CONDICION GANAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIXME SEGUIR JUGANDO DESPUES DE COMER %%%%%%%%%%%%%%%%%%%%%

















