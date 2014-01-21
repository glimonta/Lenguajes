:- dynamic tablero/1.

sign(peon_negro,  ' |< |').
sign(peon_blanco, ' | >|').
sign(rey_negro,   ' |<<|').
sign(rey_blanco,  ' |>>|').
sign(vacio,       ' |  |').

imprimirTablero(Tablero):-
  write('    1    2    3    4    5    6    7    8 '), nl,
  imprimirFila(Tablero, 1),
  imprimirFila(Tablero, 2),
  imprimirFila(Tablero, 3),
  imprimirFila(Tablero, 4),
  imprimirFila(Tablero, 5),
  imprimirFila(Tablero, 6),
  imprimirFila(Tablero, 7),
  imprimirFila(Tablero, 8),
  nl.

imprimirFila(Tablero, Fila):-
  write(Fila),
  imprimirFila(Tablero, Fila, 1).

imprimirFila(_, _, 9):-
  nl,!.

imprimirFila(Tablero, Fila, Columna):-
  obtenerContenidoCasilla(Tablero, Fila, Columna, Contenido),
  write(Contenido),
  ProximaColumna is Columna + 1,
  imprimirFila(Tablero, Fila, ProximaColumna).

obtenerCasilla(Tablero, Fila, Columna, Casilla):-
  Pos is ((Fila - 1) * 8) + Columna,
  arg(Pos, Tablero, Casilla).

obtenerFicha(Tablero, Fila, Columna, Ficha):-
  obtenerCasilla(Tablero, Fila, Columna, Ficha),
  (Ficha = peon_negro; Ficha = peon_blanco; Ficha = rey_negro; Ficha = rey_blanco).

obtenerContenidoCasilla(Tablero, Fila, Columna, Contenido):-
  obtenerCasilla(Tablero, Fila, Columna, Casilla),
  sign(Casilla, Contenido).

inicializarTablero(Tablero):-
Tablero = tablero(vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco,
                    peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio,
                    vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio,
                    vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro,
                    peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio).

tablero(vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, peon_negro, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, peon_negro, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, rey_blanco, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio).

tablero(vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco,
                    peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio,
                    vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco, vacio, peon_blanco,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio,
                    vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro,
                    peon_negro, vacio, peon_negro, vacio, peon_negro, vacio, peon_negro, vacio).

tablero(rey_blanco, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio).

tablero(rey_blanco, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, peon_negro, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio,
                    vacio, vacio, vacio, vacio, vacio, vacio, vacio, vacio).


% Casos borde
colocarElemento(Tablero, 8, Columna, peon_blanco, TableroNuevo):-
  colocarElemento(Tablero, 8, Columna, rey_blanco, TableroNuevo), !.

colocarElemento(Tablero, 1, Columna, peon_negro, TableroNuevo):-
  colocarElemento(Tablero, 1, Columna, rey_negro, TableroNuevo), !.

colocarElemento(Tablero, Fila, Columna, Elemento, TableroNuevo):-
  Pos is ((Fila - 1) * 8) + Columna,
  write('Coloco en la fila:  '), write(Fila), write('Coloco en la columna:  '), write(Columna),nl,
  write('Coloco en la posicion:  '), write(Pos), nl,
  Tablero =.. [tablero|Contenido],
  reemplazar(Contenido, Pos, Elemento, ContenidoNuevo),
  TableroNuevo =.. [tablero|ContenidoNuevo].


reemplazar(Lista, Posicion, Elemento, ListaNueva):-
  reemplazarAux(Lista, Posicion, Elemento, ListaNueva, 1).

%reemplazarAux([], _, _, [], _).

reemplazarAux([_|Xs], Posicion, Elemento, [Elemento|Xs], Posicion):- !.
%  ContadorNuevo is Posicion + 1, !,
%  reemplazarAux(Xs, Posicion, Elemento, Ys, ContadorNuevo).

reemplazarAux([X|Xs], Posicion, Elemento, [X|Ys], Contador):-
  ContadorNuevo is Contador + 1,
  reemplazarAux(Xs, Posicion, Elemento, Ys, ContadorNuevo).

contar(Tablero, Elemento, Cantidad):-
  Tablero =.. [tablero|Contenido],
  contarLista(Contenido, Elemento, Cantidad, 0).

contarLista([], _, Cantidad, Cantidad):- !.

contarLista([Elemento|Xs], Elemento, Cantidad, Contador):-
  !, ContadorNuevo is Contador + 1,
  contarLista(Xs, Elemento, Cantidad, ContadorNuevo).

contarLista([_| Xs], Elemento, Cantidad, Contador):-
  contarLista(Xs, Elemento, Cantidad, Contador).

% validar movimientos sin comer
validarMovimiento(Tablero, Rey, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  (Rey = rey_negro; Rey = rey_blanco),
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  (Fila_Final    is Fila_Inicial    + (Fila_Final - Fila_Inicial) ;
   Fila_Final    is Fila_Inicial    - (Fila_Final - Fila_Inicial)),
  (Columna_Final is Columna_Inicial + (Columna_Final - Columna_Inicial) ;
   Columna_Final is Columna_Inicial - (Columna_Final - Columna_Inicial)),
  obtenerCasilla(Tablero, Fila_Final, Columna_Final, vacio).

validarMovimiento(Tablero, peon_blanco, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  Fila_Final     is Fila_Inicial    + 1 ,
  (Columna_Final is Columna_Inicial + 1 ;
   Columna_Final is Columna_Inicial - 1),
  obtenerCasilla(Tablero, Fila_Final, Columna_Final, vacio).

validarMovimiento(Tablero, peon_negro, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  Fila_Final     is Fila_Inicial    - 1 ,
  (Columna_Final is Columna_Inicial + 1 ;
   Columna_Final is Columna_Inicial - 1),
  obtenerCasilla(Tablero, Fila_Final, Columna_Final, vacio).

% definimos los enemigos de cada ficha
enemigos(peon_blanco, peon_negro).
enemigos(peon_blanco, rey_negro).
enemigos(peon_negro, peon_blanco).
enemigos(peon_negro, rey_blanco).
enemigos(rey_negro, rey_blanco).
enemigos(rey_blanco, rey_negro).
enemigos(rey_negro, peon_blanco).
enemigos(rey_blanco, peon_negro).

% validar movimientos donde se come
validarComida(Tablero, Rey, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  (Rey = rey_negro; Rey = rey_blanco),
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  (Fila_Final    is Fila_Inicial    + 2 ;
   Fila_Final    is Fila_Inicial    - 2),
  (Columna_Final is Columna_Inicial + 2 ;
   Columna_Final is Columna_Inicial - 2),
  Fila_Enemigo is (Fila_Final + Fila_Inicial) / 2,
  Columna_Enemigo is (Columna_Final + Columna_Inicial)/2,
  enemigos(Rey, Enemigo),
  obtenerFicha(Tablero, Fila_Enemigo, Columna_Enemigo, Enemigo).

validarComida(Tablero, peon_blanco, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  Fila_Final    is Fila_Inicial    + 2,
  (Columna_Final is Columna_Inicial + 2 ;
   Columna_Final is Columna_Inicial - 2),
  Fila_Enemigo is (Fila_Final + Fila_Inicial) / 2,
  Columna_Enemigo is (Columna_Final + Columna_Inicial)/2,
  enemigos(peon_blanco, Enemigo),
  obtenerFicha(Tablero, Fila_Enemigo, Columna_Enemigo, Enemigo).

validarComida(Tablero, peon_negro, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final):-
  Fila_Final >= 1, Fila_Final =< 8, Columna_Final >= 1, Columna_Final =< 8,
  Fila_Inicial >= 1, Fila_Inicial =< 8, Columna_Inicial >= 1, Columna_Inicial =< 8,
  Fila_Final    is Fila_Inicial    - 2,
  (Columna_Final is Columna_Inicial + 2 ;
   Columna_Final is Columna_Inicial - 2),
  Fila_Enemigo is (Fila_Final + Fila_Inicial) / 2,
  Columna_Enemigo is (Columna_Final + Columna_Inicial)/2,
  enemigos(peon_negro, Enemigo),
  obtenerFicha(Tablero, Fila_Enemigo, Columna_Enemigo, Enemigo).

% Movida normal de una Ficha
moverFicha(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  validarMovimiento(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final),
  colocarElemento(Tablero, Fila_Inicial, Columna_Inicial, vacio, Tablero_Temporal),
  colocarElemento(Tablero_Temporal, Fila_Final, Columna_Final, Ficha, TableroNuevo).

% Movida de una ficha que va a comer recursivamente.
moverFichaComerRecursivo(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  moverFichaComer(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo).

moverFichaComerRecursivo(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  ((Ficha = peon_blanco; Ficha = rey_blanco; Ficha = rey_negro),
  Fila_Inicial1 is Fila_Inicial + 2;
  (Ficha = peon_negro; Ficha = rey_blanco; Ficha = rey_negro),
  Fila_Inicial1 is Fila_Inicial - 2),
  Columna_Inicial1 is Columna_Inicial + 2,
  Columna_Inicial2 is Columna_Inicial - 2,
  (((moverFichaComer(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Inicial1, Columna_Inicial1, TableroTemporal),
  moverFichaComerRecursivo(TableroTemporal, Ficha, Fila_Inicial1, Columna_Inicial1, Fila_Final, Columna_Final, TableroNuevo)));
  (moverFichaComer(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Inicial1, Columna_Inicial2, TableroTemporal),
  moverFichaComerRecursivo(TableroTemporal, Ficha, Fila_Inicial1, Columna_Inicial2, Fila_Final, Columna_Final, TableroNuevo))).

% Movida para comer normalmente
moverFichaComer(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  validarComida(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final),
  obtenerCasilla(Tablero, Fila_Final, Columna_Final, vacio),
  Columna_Enemigo1 is (Columna_Inicial + Columna_Final) / 2,
  Fila_Enemigo1 is (Fila_Inicial + Fila_Final) / 2,
  abs(Columna_Enemigo1, Columna_Enemigo), abs(Fila_Enemigo1, Fila_Enemigo),
  colocarElemento(Tablero, Fila_Inicial, Columna_Inicial, vacio, TableroTemporal1),
  colocarElemento(TableroTemporal1, Fila_Enemigo, Columna_Enemigo, vacio, TableroTemporal2),
  colocarElemento(TableroTemporal2, Fila_Final, Columna_Final, Ficha, TableroNuevo).

% Mover una ficha de un lugar a otro.
moverFicha(Tablero, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  obtenerCasilla(Tablero, Fila_Inicial, Fila_Final, Ficha),
  movimientoValido(Tablero, Ficha, TableroNuevo),
  (moverFichaComerRecursivo(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo);
   moverFicha(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo)).

% Buscar una ficha en el tablero, devuelve su fila y columna.
buscarFicha(Tablero, Ficha, Linea, Columna):-
  arg(Pos, Tablero, Ficha),
  Temporal is Pos / 8,
  ceiling(Temporal, Linea),
  Columna is Pos - ((Linea - 1) * 8).

% Todas los movimientos de comer validos
movimientoComerValido(Tablero, Ficha, TableroNuevo):-
  buscarFicha(Tablero, Ficha, Linea, Columna),
  buscarFicha(Tablero, vacio, LineaVacio, ColumnaVacio),
  moverFichaComerRecursivo(Tablero, Ficha, Linea, Columna, LineaVacio, ColumnaVacio, TableroNuevo).

% Todos los movimientos normales disponibles
movimientoNormalValido(Tablero, Ficha, TableroNuevo):-
  buscarFicha(Tablero, Ficha, Linea, Columna),
  buscarFicha(Tablero, vacio, LineaVacio, ColumnaVacio),
  moverFicha(Tablero, Ficha, Linea, Columna, LineaVacio, ColumnaVacio, TableroNuevo).

fichaDelTurno(negro, peon_negro).
fichaDelTurno(negro, rey_negro).
fichaDelTurno(blanco, peon_blanco).
fichaDelTurno(blanco, rey_blanco).

% Busca movimientos validos
% Falta agregar lo de los turnos.
movimientoValido(Tablero, Turno, TableroNuevo):-
  fichaDelTurno(Turno, Ficha),
  movimientoComerValido(Tablero, Ficha, TableroNuevo).

movimientoValido(Tablero, Turno, TableroNuevo):-
  not((fichaDelTurno(Turno, Ficha), movimientoComerValido(Tablero, Ficha, TableroNuevo))),
  fichaDelTurno(Turno, Ficha1),
  movimientoNormalValido(Tablero, Ficha1, TableroNuevo).

mover(Tablero, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo):-
  obtenerFicha(Tablero, Fila_Inicial, Columna_Inicial, Ficha),
  turno(Turno),
  fichaDelTurno(Turno, Ficha), !,
  movimientoValido(Tablero, Turno, TableroNuevo),
  (moverFichaComerRecursivo(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo);
  moverFicha(Tablero, Ficha, Fila_Inicial, Columna_Inicial, Fila_Final, Columna_Final, TableroNuevo)).

ganador(Tablero, blanco):-
  contar(Tablero, peon_negro, 0), contar(Tablero, rey_negro, 0),
  write('Ha ganado el jugador 1! :D'), nl.

ganador(Tablero, negro):-
  contar(Tablero, peon_blanco, 0), contar(Tablero, rey_blanco, 0),
  write('Ha ganado el jugador 2! :D'), nl.

jugada(X1,Y1,X2,Y2):-
  tablero(Tablero),
  turno(Jugador),
  %imprimirTablero(Tablero),
  mover(Tablero,X1,Y1,X2,Y2,TableroNuevo),
  retractall(tablero(Tablero)),
  assert(tablero(TableroNuevo)),
  imprimirTablero(TableroNuevo), !,
  retractall(turno(Jugador)),
  not(ganador(TableroNuevo, Jugador)),
  proximoJugador(Jugador, JugadorNuevo),
  assert(turno(JugadorNuevo)),
  imprimirJugador(JugadorNuevo).

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
  inicializarTablero(Tablero),
  assert(tablero(Tablero)),
  imprimirTablero(Tablero),
  assert(turno(blanco)),
  imprimirJugador(blanco))).
