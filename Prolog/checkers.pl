% Implementación de Checkers
%
% Autores:
% Gabriela Limonta Carnet: 10-10385.
% John Delgado     Carnet: 10-10196.

% Le indicamos a prolog que vamos a usar los siguientes predicados dinámicos para el manejo del tablero.
:- dynamic blanco/2.
:- dynamic turno/1.
:- dynamic negro/2.
:- dynamic vacio/2.
:- dynamic reyBlanco/2.
:- dynamic reyNegro/2.

% Se encarga de imprimir en pantalla el tablero actual.
imprimirTablero:-
  write('    1    2    3    4    5    6    7    8 '), nl,
  write(1), imprimirCasilla(1,1), imprimirCasilla(1,2), imprimirCasilla(1,3), imprimirCasilla(1,4), imprimirCasilla(1,5), imprimirCasilla(1,6), imprimirCasilla(1,7), imprimirCasilla(1,8), nl,
  write(2), imprimirCasilla(2,1), imprimirCasilla(2,2), imprimirCasilla(2,3), imprimirCasilla(2,4), imprimirCasilla(2,5), imprimirCasilla(2,6), imprimirCasilla(2,7), imprimirCasilla(2,8), nl,
  write(3), imprimirCasilla(3,1), imprimirCasilla(3,2), imprimirCasilla(3,3), imprimirCasilla(3,4), imprimirCasilla(3,5), imprimirCasilla(3,6), imprimirCasilla(3,7), imprimirCasilla(3,8), nl,
  write(4), imprimirCasilla(4,1), imprimirCasilla(4,2), imprimirCasilla(4,3), imprimirCasilla(4,4), imprimirCasilla(4,5), imprimirCasilla(4,6), imprimirCasilla(4,7), imprimirCasilla(4,8), nl,
  write(5), imprimirCasilla(5,1), imprimirCasilla(5,2), imprimirCasilla(5,3), imprimirCasilla(5,4), imprimirCasilla(5,5), imprimirCasilla(5,6), imprimirCasilla(5,7), imprimirCasilla(5,8), nl,
  write(6), imprimirCasilla(6,1), imprimirCasilla(6,2), imprimirCasilla(6,3), imprimirCasilla(6,4), imprimirCasilla(6,5), imprimirCasilla(6,6), imprimirCasilla(6,7), imprimirCasilla(6,8), nl,
  write(7), imprimirCasilla(7,1), imprimirCasilla(7,2), imprimirCasilla(7,3), imprimirCasilla(7,4), imprimirCasilla(7,5), imprimirCasilla(7,6), imprimirCasilla(7,7), imprimirCasilla(7,8), nl,
  write(8), imprimirCasilla(8,1), imprimirCasilla(8,2), imprimirCasilla(8,3), imprimirCasilla(8,4), imprimirCasilla(8,5), imprimirCasilla(8,6), imprimirCasilla(8,7), imprimirCasilla(8,8), nl,
  nl.

% Imprime una casilla vacia en caso de tener un vacio en la posicion X,Y
imprimirCasilla(X,Y):-
  vacio(X,Y), !,
  write(' |  |').

% Imprime una casilla negra en caso de tener un negro en la posicion X,Y
imprimirCasilla(X,Y):-
  negro(X,Y), !,
  write(' |< |').

% Imprime una casilla blanca en caso de tener un blanco en la posicion X,Y
imprimirCasilla(X,Y):-
  blanco(X,Y), !,
  write(' | >|').

% Imprime una casilla con un rey negro en caso de tener un rey negro en la posicion X,Y
imprimirCasilla(X,Y):-
  reyNegro(X,Y), !,
  write(' |<<|').

% Imprime una casilla con un rey blanco en caso de tener un rey blanco en la posicion X,Y
imprimirCasilla(X,Y):-
  reyBlanco(X,Y), !,
  write(' |>>|').

% Crea el tablero inicial agregando a la base de datos del conocimiento del programa las fichas que estan en cada posicion al iniciar el juego.
inicializarTablero:-
  assert(vacio(1,1)), assert(blanco(1,2)), assert(vacio(1,3)), assert(blanco(1,4)), assert(vacio(1,5)), assert(blanco(1,6)), assert(vacio(1,7)), assert(blanco(1,8)),
  assert(blanco(2,1)), assert(vacio(2,2)), assert(blanco(2,3)), assert(vacio(2,4)), assert(blanco(2,5)), assert(vacio(2,6)), assert(blanco(2,7)), assert(vacio(2,8)),
  assert(vacio(3,1)), assert(blanco(3,2)), assert(vacio(3,3)), assert(blanco(3,4)), assert(vacio(3,5)), assert(blanco(3,6)), assert(vacio(3,7)), assert(blanco(3,8)),
  assert(vacio(4,1)), assert(vacio(4,2)), assert(vacio(4,3)), assert(vacio(4,4)), assert(vacio(4,5)), assert(vacio(4,6)), assert(vacio(4,7)), assert(vacio(4,8)),
  assert(vacio(5,1)), assert(vacio(5,2)), assert(vacio(5,3)), assert(vacio(5,4)), assert(vacio(5,5)), assert(vacio(5,6)), assert(vacio(5,7)), assert(vacio(5,8)),
  assert(negro(6,1)), assert(vacio(6,2)), assert(negro(6,3)), assert(vacio(6,4)), assert(negro(6,5)), assert(vacio(6,6)), assert(negro(6,7)), assert(vacio(6,8)),
  assert(vacio(7,1)), assert(negro(7,2)), assert(vacio(7,3)), assert(negro(7,4)), assert(vacio(7,5)), assert(negro(7,6)), assert(vacio(7,7)), assert(negro(7,8)),
  assert(negro(8,1)), assert(vacio(8,2)), assert(negro(8,3)), assert(vacio(8,4)), assert(negro(8,5)), assert(vacio(8,6)), assert(negro(8,7)), assert(vacio(8,8)).

% Imprime en pantalla que es el turno del primer jugador.
imprimirJugador(blanco):- write('Juega jugador 1'), nl, nl.

% Imprime en pantalla que es el turno del segundo jugador.
imprimirJugador(negro):-  write('Juega jugador 2'), nl, nl.

% Se encarga de iniciar el juego. Define si va a jugar jugador vs. jugador o jugador vs. maquina e inicializa el juego según la opción.
% Inicializa e imprime el tablero y establece el turno del primer jugador, agrega una regla a la base de datos del conocimiento que permite saber
% de que modo se esta jugando (contra la computadora o contra otro humano).
jugar:-
  write('Desea jugar con la máquina? (s/n)?'), nl,
  read(R),
  (((R = s,!,
  assert(juega(computadora)),
  write('Comenzó el juego'), nl,
  inicializarTablero,
  imprimirTablero,
  assert(turno(blanco)),
  imprimirJugador(blanco)));
  (R = n,
  assert(juega(humano)),
  write('Comenzó el juego'), nl,
  inicializarTablero,
  imprimirTablero,
  assert(turno(blanco)),
  imprimirJugador(blanco))).


% La computadora siempre es el jugador numero 2 (fichas negras).

% Este predicado busca hacer una jugada válida de la computadora con un reyNegro del tablero.
jugadaComputadora(X,Y):-
  reyNegro(X,Y),
  vacio(Z,W),
  jugada(X,Y,Z,W), !.

% Este predicado busca hacer una jugada válida de la computadora con una ficha negra del tablero.
jugadaComputadora(X,Y):-
  negro(X,Y),
  vacio(Z,W),
  jugada(X,Y,Z,W), !.

% Ejecuta una jugada donde se come desde una posicion X1,Y1 donde hay un rey negro a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  reyNegro(X1,Y1),
  turno(negro),
  vacio(X2,Y2),
  comerReyNegro(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 2:'), nl,
  verificarGanadorNegro.

% Ejecuta una jugada donde se mueve desde una posicion X1,Y1 donde hay un rey negro a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  reyNegro(X1,Y1),
  turno(negro),
  vacio(X2,Y2),
  moverReyNegro(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 2:'), nl,
  verificarGanadorNegro.

% Ejecuta una jugada donde se come desde una posicion X1,Y1 donde hay un rey blanco a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  reyBlanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2),
  comerReyBlanco(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 1:'), nl,
  verificarGanadorBlanco.

% Ejecuta una jugada donde se mueve desde una posicion X1,Y1 donde hay un rey blanco a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  reyBlanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2),
  moverReyBlanco(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 1:'), nl,
  verificarGanadorBlanco.

% Ejecuta una jugada donde se come desde una posicion X1,Y1 donde hay un blanco a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  blanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2),
  comerBlanco(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 1:'), nl,
  verificarGanadorBlanco.

% Ejecuta una jugada donde se mueve desde una posicion X1,Y1 donde hay un blanco a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  blanco(X1,Y1),
  turno(blanco),
  vacio(X2,Y2),
  moverBlanco(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 1:'), nl,
  verificarGanadorBlanco.

% Ejecuta una jugada donde se come desde una posicion X1,Y1 donde hay un negro a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  negro(X1,Y1),
  turno(negro),
  vacio(X2,Y2),
  comerNegro(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 2:'), nl,
  verificarGanadorNegro.

% Ejecuta una jugada donde se mueve desde una posicion X1,Y1 donde hay un negro a una X2,Y2
% donde hay un vacio y verifica si se gana con esa jugada.
jugada(X1,Y1,X2,Y2):-
  negro(X1,Y1),
  turno(negro),
  vacio(X2,Y2),
  moverNegro(X1,Y1,X2,Y2), !,
  write('Movimiento jugador 2:'), nl,
  verificarGanadorNegro.

% Si esta jugando la computadora este predicado va a ejecutar una jugada de la computadora.
jugadaComp:-
  juega(computadora),
  jugadaComputadora(_X,_Y).

% Si se esta jugando jugador vs. jugador no se ejecuta una jugada de la computadora.
jugadaComp:-
  juega(humano).

% Verifica si el jugador 2 (negras) ha ganado. Si se esta jugando jugador vs. jugador
% y no cumple la condición para ganar el jugador 2, se cambia el turno al jugador 1
% y se imprime el tablero.
verificarGanadorNegro:-
  not(juega(computadora)),
  noGanador(negro), !,
  retract(turno(negro)),
  assert(turno(blanco)),
  imprimirTablero,
  imprimirJugador(blanco).

% Verifica si el jugador 2 (negras) ha ganado. Si se esta jugando contra la computadora
% y no se cumple la condición para ganar el jugador 2, se cambia el turno al jugador 1
% y se imprime el tablero.
verificarGanadorNegro:-
  juega(computadora),
  noGanador(negro), !,
  retract(turno(negro)),
  assert(turno(blanco)),
  imprimirTablero,
  imprimirJugador(blanco).

% Verifica si el jugador 2 (negras) ha ganado. Si se llega hasta aca es porque se cumple
% la condición para ganar en cuyo caso se imprime un mensaje para el jugador 2.
verificarGanadorNegro:-
  imprimirTablero,
  write('Ha ganado el jugador 2!').

% Verifica si el jugador 1 (blancas) ha ganado. Si se esta jugando jugador vs. jugador
% y no cumple la condición para ganar el jugador 1, se cambia el turno al jugador 2
% y se imprime el tablero.
verificarGanadorBlanco:-
  not(juega(computadora)),
  noGanador(blanco), !,
  retract(turno(blanco)),
  assert(turno(negro)),
  imprimirTablero,
  imprimirJugador(negro).

% Verifica si el jugador 1 (blancas) ha ganado. Si se esta jugando contra la computadora
% y no se cumple la condición para ganar el jugador 1, se cambia el turno al jugador 2
% y se imprime el tablero.
verificarGanadorBlanco:-
  juega(computadora),
  noGanador(blanco), !,
  retract(turno(blanco)),
  assert(turno(negro)),
  imprimirTablero,
  imprimirJugador(negro),
  jugadaComp, !.

% Verifica si el jugador 1 (blancas) ha ganado. Si se llega hasta aca es porque se cumple
% la condición para ganar en cuyo caso se imprime un mensaje para el jugador 1.
verificarGanadorBlanco:-
  imprimirTablero,
  write('Ha ganado el jugador 1!').

% El jugador 2 (negras) no ha ganado si aun existen en el tablero fichas blancas o reyes blancos.
noGanador(negro):-
  (blanco(_X,_Y); reyBlanco(_Z,_W)).

% El jugador 1 (blancas) no ha ganado si aun existen en el tablero fichas negras o reyes negros.
noGanador(blanco):-
  (negro(_X,_Y); reyBlanco(_Z,_W)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Movimientos de comida de los Reyes %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si se puede seguir comiendo con el rey blanco al estar jugando contra la computadora y es el
% turno del jugador 1 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoReyBlanco(X,Y):-
  juega(computadora),
  turno(blanco),
  imprimirTablero,
  puedoSeguirComiendoReyBlanco(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y'), nl,
  read(YN),
  comerReyBlanco(X,Y,XN,YN), !.

% Si se puede seguir comiendo con el rey blanco al estar jugando contra otro jugador y es el
% turno del jugador 1 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoReyBlanco(X,Y):-
  juega(humano),
  turno(blanco),
  imprimirTablero,
  puedoSeguirComiendoReyBlanco(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y'), nl,
  read(YN),
  comerReyBlanco(X,Y,XN,YN), !.

% Si se llega hasta acá es porque ya no se puede seguir comiendo.
seguirComiendoReyBlanco(_X,_Y):- !.

% Se puede seguir comiendo con el rey blanco si es valido comer a otro rey en dirección arriba y a la izquierda.
puedoSeguirComiendoReyBlanco(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerReyBlancoReyAD(X,Y,XA,YD).

% Se puede seguir comiendo con el rey blanco si es valido comer a otro rey en dirección arriba y a la derecha.
puedoSeguirComiendoReyBlanco(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerReyBlancoReyAI(X,Y,XA,YI).

% Se puede seguir comiendo con el rey blanco si es valido comer a otro rey en dirección abajo y a la izquierda.
puedoSeguirComiendoReyBlanco(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerReyBlancoReyDD(X,Y,XD,YD).

% Se puede seguir comiendo con el rey blanco si es valido comer a otro rey en dirección abajo y a la derecha.
puedoSeguirComiendoReyBlanco(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerReyBlancoReyDI(X,Y,XD,YI).

% Se puede seguir comiendo con el rey blanco si es valido comer a un peon en dirección arriba y a la izquierda.
puedoSeguirComiendoReyBlanco(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerReyBlancoPeonAD(X,Y,XA,YD).

% Se puede seguir comiendo con el rey blanco si es valido comer a un peon en dirección arriba y a la derecha.
puedoSeguirComiendoReyBlanco(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerReyBlancoPeonAI(X,Y,XA,YI).

% Se puede seguir comiendo con el rey blanco si es valido comer a un peon en dirección abajo y a la izquierda.
puedoSeguirComiendoReyBlanco(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerReyBlancoPeonDD(X,Y,XD,YD).

% Se puede seguir comiendo con el rey blanco si es valido comer a un peon en dirección abajo y a la derecha.
puedoSeguirComiendoReyBlanco(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerReyBlancoPeonDI(X,Y,XD,YI).

% Si es valido comer con el rey blanco a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoReyDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido comer con el rey blanco a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey blanco.
comerReyBlanco(X1,Y1,X2,Y2):-
  validoComerReyBlancoPeonDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyBlanco(X2,Y2).

% Si se puede seguir comiendo con el rey negro al estar jugando contra la computadora y es el
% turno del jugador 2 se ejecuta una jugada de comer de la computadora.
seguirComiendoReyNegro(X,Y):-
  juega(computadora),
  turno(negro),
  vacio(Z,W),
  comerReyNegro(X,Y,Z,W), !.

% Si se puede seguir comiendo con el rey negro al estar jugando contra otro jugador y es el
% turno del jugador 2 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoReyNegro(X,Y):-
  juega(humano),
  imprimirTablero,
  puedoSeguirComiendoReyNegro(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y ='), nl,
  read(YN),
  comerReyNegro(X,Y,XN,YN), !.

% Si se llega hasta acá es porque ya no se puede seguir comiendo.
seguirComiendoReyNegro(_X,_Y):- !.

% Se puede seguir comiendo con el rey negro si es valido comer a otro rey en dirección arriba y a la izquierda.
puedoSeguirComiendoReyNegro(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerReynegroReyAD(X,Y,XA,YD).

% Se puede seguir comiendo con el rey negro si es valido comer a otro rey en dirección arriba y a la derecha.
puedoSeguirComiendoReyNegro(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerReynegroReyAI(X,Y,XA,YI).

% Se puede seguir comiendo con el rey negro si es valido comer a otro rey en dirección abajo y a la izquierda.
puedoSeguirComiendoReyNegro(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerReynegroReyDD(X,Y,XD,YD).

% Se puede seguir comiendo con el rey negro si es valido comer a otro rey en dirección abajo y a la derecha.
puedoSeguirComiendoReyNegro(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerReynegroReyDI(X,Y,XD,YI).

% Se puede seguir comiendo con el rey negro si es valido comer a un peon en dirección arriba y a la izquierda.
puedoSeguirComiendoReyNegro(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerReynegroPeonAD(X,Y,XA,YD).

% Se puede seguir comiendo con el rey negro si es valido comer a un peon en dirección arriba y a la derecha.
puedoSeguirComiendoReyNegro(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerReynegroPeonAI(X,Y,XA,YI).

% Se puede seguir comiendo con el rey negro si es valido comer a un peon en dirección abajo y a la izquierda.
puedoSeguirComiendoReyNegro(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerReynegroPeonDD(X,Y,XD,YD).

% Se puede seguir comiendo con el rey negro si es valido comer a un peon en dirección abajo y a la derecha.
puedoSeguirComiendoReyNegro(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerReynegroPeonDI(X,Y,XD,YI).

% Si es valido comer con el rey negro a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroReyDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido comer con el rey negro a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)).

% Si es valido comer con el rey negro a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el rey negro.
comerReyNegro(X1,Y1,X2,Y2):-
  validoComerReyNegroPeonDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoReyNegro(X2,Y2).

% Es valido que un rey blanco coma en direccion arriba y a la derecha si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerReyBlancoReyAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un rey blanco coma en direccion arriba y a la derecha si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerReyBlancoPeonAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un rey blanco coma en direccion arriba y a la izquierda si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerReyBlancoReyAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un rey blanco coma en direccion arriba y a la izquieda si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerReyBlancoPeonAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un rey blanco coma en direccion abajo y a la derecha si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerReyBlancoReyDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un rey blanco coma en direccion abajo y a la derecha si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerReyBlancoPeonDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un rey blanco coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerReyBlancoReyDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un rey blanco coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerReyBlancoPeonDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un rey negro coma en direccion arriba y a la derecha si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerReyNegroReyAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un rey negro coma en direccion arriba y a la derecha si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerReyNegroPeonAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un rey negro coma en direccion arriba y a la izquierda si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerReyNegroReyAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un rey negro coma en direccion arriba y a la izquieda si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerReyNegroPeonAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un rey negro coma en direccion abajo y a la derecha si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerReyNegroReyDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un rey negro coma en direccion abajo y a la derecha si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerReyNegroPeonDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un rey negro coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerReyNegroReyDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un rey negro coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerReyNegroPeonDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  blanco(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Movimientos de los Reyes %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si es valido moverse con el rey blanco en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoAD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido moverse con el rey blanco en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoAI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido moverse con el rey blanco en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoDD(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido moverse con el rey blanco en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyBlanco(X1,Y1,X2,Y2):-
  validoMoverReyBlancoDI(X1,Y1,X2,Y2), !,
  retract(reyBlanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(X2,Y2)),
  seguirComiendoReyBlanco(X2,Y2).

% Si es valido moverse con el rey negro en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroAD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido moverse con el rey negro en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroAI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido moverse con el rey negro en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroDD(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  seguirComiendoReyNegro(X2,Y2).

% Si es valido moverse con el rey negro en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
% Se busca a ver si el rey puede comer desde esta posicion.
moverReyNegro(X1,Y1,X2,Y2):-
  validoMoverReyNegroDI(X1,Y1,X2,Y2), !,
  retract(reyNegro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(X2,Y2)),
  seguirComiendoReyNegro(X2,Y2).

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la derecha.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyBlancoAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la derecha.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyBlancoAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  DesdeY =\= HastaY,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalReyBlancoAD(NuevoX, NuevoY, HastaX, HastaY).

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la izquierda.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyBlancoAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la izquierda.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyBlancoAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  DesdeY =\= HastaY,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalReyBlancoAI(NuevoX, NuevoY, HastaX, HastaY).

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la derecha.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyBlancoDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la derecha.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyBlancoDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalReyBlancoDD(NuevoX, NuevoY, HastaX, HastaY).

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la izquierda.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyBlancoDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la izquierda.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyBlancoDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalReyBlancoDI(NuevoX, NuevoY, HastaX, HastaY).


% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la derecha.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyNegroAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la derecha.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyNegroAD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  DesdeY =\= HastaY,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalReyNegroAD(NuevoX, NuevoY, HastaX, HastaY).


% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la izquierda.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyNegroAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion arriba y a la izquierda.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyNegroAI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  DesdeY =\= HastaY,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX - 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalReyNegroAI(NuevoX, NuevoY, HastaX, HastaY).


% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la derecha.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyNegroDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la derecha.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyNegroDD(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY + 1,
  vaciosDiagonalReyNegroDD(NuevoX, NuevoY, HastaX, HastaY).


% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la izquierda.
% Si X final e inicial son iguales es suficiente con verificar que haya un vacio en esa posicion.
vaciosDiagonalReyNegroDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX is HastaX,
  DesdeY is HastaY,
  vacio(DesdeX, DesdeY), !.

% Verifica que hayan vacios desde una posicion X,Y a otra. En direccion abajo y a la izquierda.
% Si X final e inicial son diferentes entonces verificamos que la posicion inicial sea vacio y
% se llama recursivamente con un nuevo X e Y que son la proxima casilla en la diagonal.
vaciosDiagonalReyNegroDI(DesdeX, DesdeY, HastaX, HastaY):-
  DesdeX =\= HastaX,
  vacio(DesdeX,DesdeY),
  NuevoX is DesdeX + 1,
  NuevoY is DesdeY - 1,
  vaciosDiagonalReyNegroDI(NuevoX, NuevoY, HastaX, HastaY).

% Es valido mover a un rey blanco si la diagonal entre el inicio y final solo tiene vacios.
% Aqui están variaciones del predicado segun la direccion del movimiento.
% (arriba y a la derecha, arriba y a la izquierda, abajo y a la derecha, abajo y a la izquierda).
validoMoverReyBlancoAD(X1,Y1,X2,Y2):-
  X2 is X1 - (X1 - X2),
  Y2 is Y1 + (Y2 - Y1),
  X is X1 - 1, Y is Y1 + 1,
  vaciosDiagonalReyBlancoAD(X,Y,X2,Y2).

validoMoverReyBlancoAI(X1,Y1,X2,Y2):-
  X2 is X1 - (X1 - X2),
  Y2 is Y1 - (Y1 - Y2),
  X is X1 - 1, Y is Y1 - 1,
  vaciosDiagonalReyBlancoAI(X,Y,X2,Y2).

validoMoverReyBlancoDD(X1,Y1,X2,Y2):-
  X2 is X1 + (X2 - X1),
  Y2 is Y1 + (Y2 - Y1),
  X is X1 + 1, Y is Y1 + 1,
  vaciosDiagonalReyBlancoDD(X,Y,X2,Y2).

validoMoverReyBlancoDI(X1,Y1,X2,Y2):-
  X2 is X1 + (X2 - X1),
  Y2 is Y1 - (Y1 - Y2),
  X is X1 + 1, Y is Y1 - 1,
  vaciosDiagonalReyBlancoDI(X,Y,X2,Y2).


% Es valido mover a un rey negro si la diagonal entre el inicio y final solo tiene vacios.
% Aqui están variaciones del predicado segun la direccion del movimiento.
% (arriba y a la derecha, arriba y a la izquierda, abajo y a la derecha, abajo y a la izquierda).

validoMoverReyNegroAD(X1,Y1,X2,Y2):-
  X2 is X1 - (X1 - X2),
  Y2 is Y1 + (Y2 - Y1),
  X is X1 - 1, Y is Y1 + 1,
  vaciosDiagonalReyNegroAD(X,Y,X2,Y2).

validoMoverReyNegroAI(X1,Y1,X2,Y2):-
  X2 is X1 - (X1 - X2),
  Y2 is Y1 - (Y1 - Y2),
  X is X1 - 1, Y is Y1 - 1,
  vaciosDiagonalReyNegroAI(X,Y,X2,Y2).

validoMoverReyNegroDD(X1,Y1,X2,Y2):-
  X2 is X1 + (X2 - X1),
  Y2 is Y1 + (Y2 - Y1),
  X is X1 + 1, Y is Y1 + 1,
  vaciosDiagonalReyNegroDD(X,Y,X2,Y2).

validoMoverReyNegroDI(X1,Y1,X2,Y2):-
  X2 is X1 + (X2 - X1),
  Y2 is Y1 - (Y1 - Y2),
  X is X1 + 1, Y is Y1 - 1,
  vaciosDiagonalReyNegroDI(X,Y,X2,Y2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Movimientos de comida de los Peones %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si se puede seguir comiendo con el blanco al estar jugando contra la computadora y es el
% turno del jugador 1 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoBlanco(X,Y):-
  juega(computadora),
  turno(blanco),
  imprimirTablero,
  puedoSeguirComiendoBlanco(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y ='), nl,
  read(YN),
  comerBlanco(X,Y,XN,YN), !.

% Si se puede seguir comiendo con el  blanco al estar jugando contra otro jugador y es el
% turno del jugador 1 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoBlanco(X,Y):-
  juega(humano),
  imprimirTablero,
  puedoSeguirComiendoBlanco(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y ='), nl,
  read(YN),
  comerBlanco(X,Y,XN,YN), !.

% Si se llega hasta acá es porque ya no se puede seguir comiendo.
seguirComiendoBlanco(_X,_Y):- !.

% Se puede seguir comiendo con el blanco si es valido comer a otro rey en dirección arriba y a la izquierda.
puedoSeguirComiendoBlanco(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerBlancoReyAD(X,Y,XA,YD).

% Se puede seguir comiendo con el blanco si es valido comer a otro rey en dirección arriba y a la derecha.
puedoSeguirComiendoBlanco(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerBlancoReyAI(X,Y,XA,YI).

% Se puede seguir comiendo con el blanco si es valido comer a otro rey en dirección abajo y a la izquierda.
puedoSeguirComiendoBlanco(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerBlancoReyDD(X,Y,XD,YD).

% Se puede seguir comiendo con el blanco si es valido comer a otro rey en dirección abajo y a la derecha.
puedoSeguirComiendoBlanco(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerBlancoReyDI(X,Y,XD,YI).

% Se puede seguir comiendo con el blanco si es valido comer a un peon en dirección arriba y a la izquierda.
puedoSeguirComiendoBlanco(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerBlancoPeonAD(X,Y,XA,YD).

% Se puede seguir comiendo con el blanco si es valido comer a un peon en dirección arriba y a la derecha.
puedoSeguirComiendoBlanco(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerBlancoPeonAI(X,Y,XA,YI).

% Se puede seguir comiendo con el blanco si es valido comer a un peon en dirección abajo y a la izquierda.
puedoSeguirComiendoBlanco(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerBlancoPeonDD(X,Y,XD,YD).

% Se puede seguir comiendo con el blanco si es valido comer a un peon en dirección abajo y a la derecha.
puedoSeguirComiendoBlanco(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerBlancoPeonDI(X,Y,XD,YI).

% Si es valido comer con el blanco a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca un rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoReyAD(X1,Y1,8,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoReyAI(X1,Y1,8,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoReyDD(X1,Y1,8,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoReyDI(X1,Y1,8,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).


% Si es valido comer con el blanco a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoPeonAD(X1,Y1,8,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoPeonAI(X1,Y1,8,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoPeonDD(X1,Y1,8,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,8,Y2):-
  validoComerBlancoPeonDI(X1,Y1,8,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(8,Y2).

% Si es valido comer con el blanco a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoReyDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyNegro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).


% Si es valido comer con el blanco a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).

% Si es valido comer con el blanco a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el blanco en la posicion final.
% Se busca a ver si se puede continuar comiendo con el blanco.
comerBlanco(X1,Y1,X2,Y2):-
  validoComerBlancoPeonDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(negro(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoBlanco(X2,Y2).


% Si se puede seguir comiendo con el  negro al estar jugando contra la computadora y es el
% turno del jugador 2 se ejecuta una jugada de la computadora.
seguirComiendoNegro(X,Y):-
  juega(computadora),
  turno(negro),
  vacio(Z,W),
  comerNegro(X,Y,Z,W), !.

% Si se puede seguir comiendo con el  negro al estar jugando contra otro jugador y es el
% turno del jugador 2 se le pregunta al usuario a donde quiere mover su ficha para continuar comiendo.
seguirComiendoNegro(X,Y):-
  juega(humano),
  imprimirTablero,
  puedoSeguirComiendoNegro(X,Y), !,
  write('A que posición desea moverse?'), nl,
  write('X ='), nl,
  read(XN),
  write('Y ='), nl,
  read(YN),
  comerNegro(X,Y,XN,YN), !.

% Si se llega hasta acá es porque ya no se puede seguir comiendo.
seguirComiendoNegro(_X,_Y):- !.

% Se puede seguir comiendo con el negro si es valido comer a otro rey en dirección arriba y a la izquierda.
puedoSeguirComiendoNegro(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerNegroReyAD(X,Y,XA,YD).

% Se puede seguir comiendo con el negro si es valido comer a otro rey en dirección arriba y a la derecha.
puedoSeguirComiendoNegro(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerNegroReyAI(X,Y,XA,YI).

% Se puede seguir comiendo con el negro si es valido comer a otro rey en dirección abajo y a la izquierda.
puedoSeguirComiendoNegro(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerNegroReyDD(X,Y,XD,YD).

% Se puede seguir comiendo con el negro si es valido comer a otro rey en dirección abajo y a la derecha.
puedoSeguirComiendoNegro(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerNegroReyDI(X,Y,XD,YI).

% Se puede seguir comiendo con el negro si es valido comer a otro rey en dirección abajo y a la derecha.
puedoSeguirComiendoNegro(X,Y):-
  XA is X - 2,
  YD is Y + 2,
  validoComerNegroPeonAD(X,Y,XA,YD).

% Se puede seguir comiendo con el negro si es valido comer a un peon en dirección arriba y a la izquierda.
puedoSeguirComiendoNegro(X,Y):-
  XA is X - 2,
  YI is Y - 2,
  validoComerNegroPeonAI(X,Y,XA,YI).

% Se puede seguir comiendo con el negro si es valido comer a un peon en dirección arriba y a la derecha.
puedoSeguirComiendoNegro(X,Y):-
  XD is X + 2,
  YD is Y + 2,
  validoComerNegroPeonDD(X,Y,XD,YD).

% Se puede seguir comiendo con el negro si es valido comer a un peon en dirección abajo y a la izquierda.
puedoSeguirComiendoNegro(X,Y):-
  XD is X + 2,
  YI is Y - 2,
  validoComerNegroPeonDI(X,Y,XD,YI).

% Si es valido comer con el negro a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca un rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroReyAD(X1,Y1,1,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroReyAI(X1,Y1,1,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroReyDD(X1,Y1,1,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroReyDI(X1,Y1,1,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).


% Si es valido comer con el negro a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroPeonAD(X1,Y1,1,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroPeonAI(X1,Y1,1,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroPeonDD(X1,Y1,1,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).

% Si es valido comer con el negro a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca al rey en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,1,Y2):-
  validoComerNegroPeonDI(X1,Y1,1,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(1,Y2).


% Si es valido comer con el negro a otro rey en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a otro rey en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a otro rey en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a otro rey en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroReyDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(reyBlanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).


% Si es valido comer con el negro a un peon en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonAD(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a un peon en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonAI(X1,Y1,X2,Y2), !,
  XE is X1 - 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a un peon en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonDD(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 + 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).

% Si es valido comer con el negro a un peon en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial y en la posicion del enemigo se colocan vacios y se coloca el negro en la posicion final.
% Se busca a ver si se puede continuar comiendo con el negro.
comerNegro(X1,Y1,X2,Y2):-
  validoComerNegroPeonDI(X1,Y1,X2,Y2), !,
  XE is X1 + 1, YE is Y1 - 1,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  retract(blanco(XE,YE)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)),
  assert(vacio(XE,YE)),
  seguirComiendoNegro(X2,Y2).


% Es valido que un blanco coma en direccion arriba y a la derecha si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerBlancoReyAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un blanco coma en direccion arriba y a la derecha si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerBlancoPeonAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un blanco coma en direccion arriba y a la izquierda si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerBlancoReyAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un blanco coma en direccion arriba y a la izquieda si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerBlancoPeonAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un blanco coma en direccion abajo y a la derecha si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerBlancoReyDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un blanco coma en direccion abajo y a la derecha si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerBlancoPeonDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un blanco coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un rey negro y en la posicion final un vacio.
validoComerBlancoReyDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyNegro(X,Y).

% Es valido que un blanco coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un peon negro y en la posicion final un vacio.
validoComerBlancoPeonDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  negro(X,Y).

% Es valido que un negro coma en direccion arriba y a la derecha si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerNegroReyAD(X1,Y1,X2,Y2):-
  2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un negro coma en direccion arriba y a la derecha si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerNegroPeonAD(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 + 2,
  X is X1 - 1, Y is Y1 + 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un negro coma en direccion arriba y a la izquierda si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerNegroReyAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un negro coma en direccion arriba y a la izquieda si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerNegroPeonAI(X1,Y1,X2,Y2):-
  X2 is X1 - 2,
  Y2 is Y1 - 2,
  X is X1 - 1, Y is Y1 - 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un negro coma en direccion abajo y a la derecha si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerNegroReyDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un negro coma en direccion abajo y a la derecha si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerNegroPeonDD(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 + 2,
  X is X1 + 1, Y is Y1 + 1,
  vacio(X2,Y2),
  blanco(X,Y).

% Es valido que un negro coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un rey blanco y en la posicion final un vacio.
validoComerNegroReyDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  reyBlanco(X,Y).

% Es valido que un negro coma en direccion abajo y a la izquierda si en la posicion del enemigo hay un peon blanco y en la posicion final un vacio.
validoComerNegroPeonDI(X1,Y1,X2,Y2):-
  X2 is X1 + 2,
  Y2 is Y1 - 2,
  X is X1 + 1, Y is Y1 - 1,
  vacio(X2,Y2),
  blanco(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Movimientos de los Peones %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si es valido moverse con el blanco en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverBlanco(X1,Y1,8,Y2):-
  validoMoverBlancoAD(X1,Y1,8,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)).

% Si es valido moverse con el blanco en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverBlanco(X1,Y1,8,Y2):-
  validoMoverBlancoAI(X1,Y1,8,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)).

% Si es valido moverse con el blanco en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverBlanco(X1,Y1,8,Y2):-
  validoMoverBlancoDD(X1,Y1,8,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)).

% Si es valido moverse con el blanco en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverBlanco(X1,Y1,8,Y2):-
  validoMoverBlancoDI(X1,Y1,8,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(8,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyBlanco(8,Y2)).

% Si es valido moverse con el blanco en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al blanco.
moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoAD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)).

% Si es valido moverse con el blanco en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al blanco.
moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoAI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)).

% Si es valido moverse con el blanco en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al blanco.
moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoDD(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)).

% Si es valido moverse con el blanco en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al blanco.
moverBlanco(X1,Y1,X2,Y2):-
  validoMoverBlancoDI(X1,Y1,X2,Y2), !,
  retract(blanco(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(blanco(X2,Y2)).


% Si es valido moverse con el negro en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverNegro(X1,Y1,1,Y2):-
  validoMoverNegroAD(X1,Y1,1,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)).

% Si es valido moverse con el negro en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverNegro(X1,Y1,1,Y2):-
  validoMoverNegroAI(X1,Y1,1,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)).

% Si es valido moverse con el negro en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverNegro(X1,Y1,1,Y2):-
  validoMoverNegroDD(X1,Y1,1,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)).

% Si es valido moverse con el negro en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% Aqui ademas se cumple que estamos llegando al final del tablero y "coronando".
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al rey.
moverNegro(X1,Y1,1,Y2):-
  validoMoverNegroDI(X1,Y1,1,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(1,Y2)),
  assert(vacio(X1,Y1)),
  assert(reyNegro(1,Y2)).

% Si es valido moverse con el negro en direccion arriba y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al negro.
moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroAD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)).

% Si es valido moverse con el negro en direccion arriba y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al negro.
moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroAI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)).

% Si es valido moverse con el negro en direccion abajo y a la derecha, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al negro.
moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroDD(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)).

% Si es valido moverse con el negro en direccion abajo y a la izquierda, se cambian los hechos en la base de datos del conocimiento.
% En la posicion inicial se coloca un vacio y en la posicion final se coloca al negro.
moverNegro(X1,Y1,X2,Y2):-
  validoMoverNegroDI(X1,Y1,X2,Y2), !,
  retract(negro(X1,Y1)),
  retract(vacio(X2,Y2)),
  assert(vacio(X1,Y1)),
  assert(negro(X2,Y2)).


% Es valido mover a un blanco si en la posicion final hay un vacio.
% Aqui están variaciones del predicado segun la direccion del movimiento.
% (arriba y a la derecha, arriba y a la izquierda, abajo y a la derecha, abajo y a la izquierda).

validoMoverBlancoAD(X1,Y1,X2,Y2):-
  X2 is X1 - 1,
  Y2 is Y1 + 1,
  vacio(X2,Y2).

validoMoverBlancoAI(X1,Y1,X2,Y2):-
  X2 is X1 - 1,
  Y2 is Y1 - 1,
  vacio(X2,Y2).

validoMoverBlancoDD(X1,Y1,X2,Y2):-
  X2 is X1 + 1,
  Y2 is Y1 + 1,
  vacio(X2,Y2).

validoMoverBlancoDI(X1,Y1,X2,Y2):-
  X2 is X1 + 1,
  Y2 is Y1 - 1,
  vacio(X2,Y2).


% Es valido mover a un negro si en la posicion final hay un vacio.
% Aqui están variaciones del predicado segun la direccion del movimiento.
% (arriba y a la derecha, arriba y a la izquierda, abajo y a la derecha, abajo y a la izquierda).

validoMoverNegroAD(X1,Y1,X2,Y2):-
  X2 is X1 - 1,
  Y2 is Y1 + 1,
  vacio(X2,Y2).

validoMoverNegroAI(X1,Y1,X2,Y2):-
  X2 is X1 - 1,
  Y2 is Y1 - 1,
  vacio(X2,Y2).

validoMoverNegroDD(X1,Y1,X2,Y2):-
  X2 is X1 + 1,
  Y2 is Y1 + 1,
  vacio(X2,Y2).

validoMoverNegroDI(X1,Y1,X2,Y2):-
  X2 is X1 + 1,
  Y2 is Y1 - 1,
  vacio(X2,Y2).
