%guia 10
%ejercicio 1

reinas:-menu(Fila,Columna),ochoReinas(Fila,Columna).
menu(Fila,Columna):-menu1(Fila),menu2(Columna).
menu1(Fila):-repeat,write('Ingrese la fila(1-8):'),read(Fila),valido(Fila),!.
menu2(Columna):-repeat,write('Ingrese la columna(1-8)'),read(Columna),valido(Columna),!.
valido(1).
valido(2).
valido(3).
valido(4).
valido(5).
valido(6).
valido(7).
valido(8).



ochoReinas(F,C):-tablero(Tab),comeReina(F,C,Tab,Tab2),!,siguiente(Tab2,LauxReinas,1),append([[F,C]],LauxReinas,Lreinas),write(Lreinas).

tablero(L):-tablero(L,0,1).
tablero([],8,8).
tablero([[F,C1]|L],C,F):-C1 is C+1,C1<9,tablero(L,C1,F).
tablero(L,_,F):-F1 is F+1,tablero(L,0,F1).

siguiente([],[],8).
siguiente([[F,C]|R],[[F,C]|L],N):-comeReina(F,C,R,RestTab),N1 is N+1,siguiente(RestTab,L,N1).
siguiente([_|R],L,N):-siguiente(R,L,N).

comeReina(F,C,Tab,RestTab):-comeVert(C,Tab,T1),comeHor(F,T1,T2),comeDiag(F,C,T2,RestTab),!.
% prueba %
comeReina2(C,T1):-tablero(Tab),comeHor(C,Tab,T1),!.
comeReina3(F,T1):-tablero(Tab),comeVert(F,Tab,T1),!.
comeReina4(F,C,T2):-tablero(Tab),comeVert(C,Tab,T1),comeHor(F,T1,T2),!.
comeReina5(F,C,RestTab):-tablero(Tab),comeVert(C,Tab,T1),comeHor(F,T1,T2),comeDiag(F,C,T2,RestTab),!.
%%
comeVert(_,[],[]).
comeVert(C,[[_,C]|R],T1):-comeVert(C,R,T1).
comeVert(C,[[F,C1]|R],[[F,C1]|T1]):-comeVert(C,R,T1).

comeHor(_,[],[]).
comeHor(F,[[F,_]|R],T1):-comeHor(F,R,T1).
comeHor(F,[[F1,C]|R],[[F1,C]|T1]):-comeHor(F,R,T1).

comeDiag(F,C,T2,TF):-comeNE(F,C,L1),comeNO(F,C,L2),comeSE(F,C,L3),comeSO(F,C,L4),append(L1,L2,L5),append(L5,L3,L6),append(L6,L4,LF),removerDuplicados(LF,T2,TF),!.

%prueba%
comeDiag2(F,C,TF):-tablero(Tab),comeNE(F,C,L1),comeNO(F,C,L2),comeSE(F,C,L3),comeSO(F,C,L4),append(L1,L2,L5),append(L5,L3,L6),append(L6,L4,LF),removerDuplicados(LF,Tab,TF),!.

removerDuplicados([],T,T).
removerDuplicados([E|R],T2,TF):-delete(T2,E,T1),removerDuplicados(R,T1,TF).

comeNE(0,_,[]).
comeNE(_,9,[]).
comeNE(F,C,[[F,C]|L]):-C1 is C+1,C1>=0,F1 is F-1, F1=<9,comeNE(F1,C1,L),!.

comeNO(0,_,[]).
comeNO(_,0,[]).
comeNO(F,C,[[F,C]|L]):-C1 is C-1,C1>=0,F1 is F-1, F1>=0,comeNO(F1,C1,L),!.

comeSE(9,_,[]).
comeSE(_,9,[]).
comeSE(F,C,[[F,C]|L]):-C1 is C+1,C1=<9,F1 is F+1, F1=<9,comeSE(F1,C1,L),!.

comeSO(9,_,[]).
comeSO(_,0,[]).
comeSO(F,C,[[F,C]|L]):-C1 is C-1,C1>=0,F1 is F+1, F1=<9,comeSO(F1,C1,L),!.
