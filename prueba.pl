% Cancion, Compositores,  Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927). 
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, tangananicaTanganana).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

esHit(Cancion):-
cancion(Cancion, _, _),
topTodosLosMeses(Cancion, Mes).

topTodosLosMeses(Cancion, Mes):-
    rankingTop3(febrero, _, Cancion),
    rankingTop3(marzo, _, Cancion),
    rankingTop3(abril, _, Cancion),
    rankingTop3(mayo, _, Cancion),
    rankingTop3(junio, _, Cancion).

/*
Saber si una canción no es reconocida por los críticos, lo cual ocurre si tiene muchas reproducciones y nunca estuvo en el ranking. Una canción tiene muchas reproducciones si tiene más de 7000000 reproducciones.
*/
noReconocidaCriticos(Cancion):-
    cancion(Cancion, _, Reproducciones),
    Reproducciones > 7000000,
    not(rankingTop3(_, _, Cancion)).

%Saber si dos compositores son colaboradores, lo cual ocurre si compusieron alguna canción juntos.%
sonColaboradores(Compositor1, Compositor2):-
    cancion(_, Compositores, _),
    member(Compositor1, Compositores),
    member(Compositor2, Compositores),
    Compositor1 \= Compositor2.

trabajador(tulio, conductor(5)).
trabajador(bodoque, periodista(2, licenciatura)).
trabajador(bodoque, reportero(5, 300)).
trabajador(marioHugo, periodista(10, posgrado)).
trabajador(juanin, conductor(0)).

/*
Conocer el sueldo total de una persona, el cual está dado por la suma de los sueldos de cada uno de sus trabajos. El sueldo de cada trabajo se calcula de la siguiente forma:
El sueldo de un conductor es de 10000 por cada año de experiencia
El sueldo de un reportero también es 10000 por cada año de experiencia más  100 por cada nota que haya hecho en su carrera.
Los periodistas, por cada año de experiencia reciben 5000, pero se les aplica un porcentaje de incremento del 20% cuando tienen una licenciatura o del 35% si tienen un posgrado.
*/
sueldoTotal(Persona, SueldoTotal):-
    trabajador(Persona, _),
    findall(Sueldo, sueldoTrabajo(Persona, Sueldo), Sueldos),
    sum_list(Sueldos, SueldoTotal).

sueldoTrabajo(Persona, SueldoTrabajo):-
    trabajador(Persona, Trabajo),
    findall(Sueldo, sueldo(Trabajo, Sueldo), Sueldos),
    sumlist(Sueldos, SueldoTrabajo).
    
sueldo(conductor(AniosExperiencia), Sueldo):-
    Sueldo is AniosExperiencia * 10000.
sueldo(reportero(AniosExperiencia, Notas), Sueldo):-
    Sueldo is AniosExperiencia * 10000 + Notas * 100.
sueldo(periodista(AniosExperiencia, licenciatura), Sueldo):-
    Sueldo is AniosExperiencia * 5000 * 1.2.
sueldo(periodista(AniosExperiencia, posgrado), Sueldo):-
    Sueldo is AniosExperiencia * 5000 * 1.35.

trabajador(jose, chef([pastas, pizza, lasagna], 10000)).
sueldo(chef(Platos, _), Sueldo):-
    length(Platos, CantidadPlatos),
    Sueldo is CantidadPlatos * 1000.