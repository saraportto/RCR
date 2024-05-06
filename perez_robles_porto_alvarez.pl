% BASE DE HECHOS SOBE LOS DESTINOS INTERPLANETARIOS DEL SISTEMA SOLAR
opcion(luna, 1.62, frio, 3, mala, 30000, 384400, sin_riesgos, nula, pequeno, totalmente_oscuro, poco_biodiverso, rocoso, sin_atmosfera, baja, ninguno).
opcion(mercurio, 3.7, mucho_calor, 7, muy_mala, 5000000, 77000000, con_riesgos, nula, pequeno, bastante_luminoso, nada_biodiverso, rocoso, con_atmosfera, alta, ninguno).
opcion(venus, 8.87, mucho_calor, 5, muy_buena, 1500000, 42000000, con_riesgos, excelente, mediano, totalmente_oscuro, nada_biodiverso, volcanico, con_atmosfera, alta, ninguno).
opcion(marte, 3.71, frio, 6, regular, 100000, 225000000, con_riesgos, poca, mediano, un_poco_luminoso, poco_biodiverso, arenoso, con_atmosfera, moderada, pocos).
opcion(jupiter, 24.79, mucho_frio, 30, regular, 50000000, 628743036, sin_riesgos, nula, grande, bastante_luminoso, nada_biodiverso, gaseoso, con_atmosfera, muy_alta, muchos).
opcion(europa, 1.31, mucho_frio, 24, regular, 10000000, 628743036, con_riesgos, buena, pequeno, un_poco_oscuro, poco_biodiverso, helado, sin_atmosfera, baja, ninguno).
opcion(saturno, 10.44, mucho_frio, 40, buena, 3000000, 1257783943, con_riesgos, regular, grande, bastante_luminoso, nada_biodiverso, gaseoso, con_atmosfera, nula, muchos).
opcion(urano, 8.87, frio, 80, muy_mala, 60000000, 2724295564, sin_riesgos, nula, grande, un_poco_oscuro, nada_biodiverso, gaseoso, sin_atmosfera, moderada, algunos).
opcion(neptuno, 11.15, frio, 90, mala, 70000000, 4350000000, sin_riesgos, nula, mediano, un_poco_oscuro, nada_biodiverso, gaseoso, sin_atmosfera, moderada, algunos).
opcion(pluton, 0.62, mucho_frio, 110, muy_mala, 50000000, 4740000000, sin_riesgos, nula, pequeno, totalmente_oscuro, poco_biodiverso, rocoso, sin_atmosfera, baja, pocos).


% REGLAS DE DECISIÓN
decision([[GravedadMin, GravedadMax], Temperatura, [TiempoMin, TiempoMax], CondicionAtm, PresuMax, DistMax, RiesgiosAmb, Habitabilidad, Size, Luminosidad, Biodiversidad, Composicion, Atmosfera, Radiacion, Satelites], Destino, Score) :-
    
    subdecision_gravedad(Destino, [GravedadMin, GravedadMax], ScoreGrav),
    subdecision_temperatura(Destino, Temperatura, ScoreTemp),
    subdecision_tiempo_de_viaje(Destino, [TiempoMin, TiempoMax], ScoreTiempo),
    subdecision_condiciones_atmosfericas(Destino, CondicionAtm, ScoreAtm),
    subdecision_presu(Destino, PresuMax, ScorePresu),
    subdecision_distancia(Destino, DistMax, ScoreDist),
    subdecision_riesgos_ambientales(Destino, RiesgiosAmb, ScoreRiesgos),
    subdecision_habitabilidad(Destino, Habitabilidad, ScoreHab),
    subdecision_size(Destino, Size, ScoreSize),
    subdecision_luminosidad(Destino, Luminosidad, ScoreLum),
    subdecision_biodiversidad(Destino, Biodiversidad, ScoreBio),
    subdecision_composicion(Destino, Composicion, ScoreComp),
    subdecision_atmosfera(Destino, Atmosfera, ScoreAtmos),
    subdecision_radiacion(Destino, Radiacion, ScoreRad),
    subdecision_satelites(Destino, Satelites, ScoreSat),
    Score is ((ScoreGrav + ScoreTemp + ScoreTiempo + ScoreAtm + ScorePresu + ScoreDist + ScoreRiesgos + ScoreHab + ScoreSize + ScoreLum + ScoreBio + ScoreComp + ScoreAtmos + ScoreRad + ScoreSat)/15)*100.


% GRAVEDAD
subdecision_gravedad(Destino, [LimiteInf, LimiteSup], 1) :-
    opcion(Destino, Gravedad, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),
        Gravedad >= LimiteInf
    ;   var(LimiteInf)
    ),
    
    (   nonvar(LimiteSup),
        Gravedad =< LimiteSup
    ;   var(LimiteSup)
    ).

subdecision_gravedad(Destino, [LimiteInf, LimiteSup], 0) :-
    opcion(Destino, Gravedad, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),

        Gravedad =< LimiteInf
    
    ;   nonvar(LimiteSup),

        Gravedad >= LimiteSup
    ).


% TIEMPO DE VIAJE
subdecision_tiempo_de_viaje(Destino, [LimiteInf, LimiteSup], 1) :-
    opcion(Destino, Tiempo, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),
        Tiempo >= LimiteInf
    ;   var(LimiteInf)
    ),
    
    (   nonvar(LimiteSup),
        Tiempo =< LimiteSup
    ;   var(LimiteSup)
    ).

subdecision_tiempo_de_viaje(Destino, [LimiteInf, LimiteSup], 0) :-
    opcion(Destino, Tiempo, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),

        Tiempo =< LimiteInf
    
    ;   nonvar(LimiteSup),
    
        Tiempo >= LimiteSup
    ).


% PRESUPUESTO MÁXIMO
subdecision_presu(Destino, PresuMax, 1) :-
    opcion(Destino, _, _, _, _, Presu, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(PresuMax),
        Presu =< PresuMax
    ;   var(PresuMax)
    ).

subdecision_presu(Destino, PresuMax, 0) :-
    opcion(Destino, _, _, _, _, Presu, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(PresuMax),
        Presu >= PresuMax
    ).


% DISTANCIA MÁXIMA A LA TIERRA
subdecision_distancia(Destino, DistMax, 1) :-
    opcion(Destino, _, _, _, _, _, DistTierra, _, _, _, _, _, _, _, _, _),
    (   nonvar(DistMax),
        DistTierra =< DistMax
    ;   var(DistMax)
    ).

subdecision_distancia(Destino, DistMax, 0) :-
    opcion(Destino, _, _, _, _, _, DistTierra, _, _, _, _, _, _, _, _, _),
    (   nonvar(DistMax),
        DistTierra >= DistMax
    ).


% RIESGOS AMBIENTALES
subdecision_riesgos_ambientales(Destino, Riesgos, 1) :-
    opcion(Destino, _, _, _, _, _, _, RiesgiosAmb, _, _, _, _, _, _, _, _),
    (   nonvar(Riesgos),
        RiesgiosAmb = Riesgos
    ;   var(Riesgos)
    ).

subdecision_riesgos_ambientales(Destino, Riesgos, 0) :-
    opcion(Destino, _, _, _, _, _, _, RiesgiosAmb, _, _, _, _, _, _, _, _),
    (   nonvar(Riesgos),
        RiesgiosAmb \= Riesgos
    ).


% ATMOSFERA
subdecision_atmosfera(Destino, Atm, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, Atmosfera, _, _),
    (   nonvar(Atm),
        Atmosfera = Atm
    ;   var(Atm)
    ).

subdecision_atmosfera(Destino, Atm, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, Atmosfera, _, _),
    (   nonvar(Atm),
        Atmosfera \= Atm
    ).


% TEMPERATURA 
subdecision_temperatura(Destino, Lista, 1) :-
    opcion(Destino, _, Temperatura, _, _, _, _, _, _, _, _, _, _, _, _, _),
    member(Temperatura, Lista).

subdecision_temperatura(Destino, Lista, 0) :-
    opcion(Destino, _, Temperatura, _, _, _, _, _, _, _, _, _, _, _, _, _),
    \+ member(Temperatura, Lista).


% CONDICIONES ATMOSFÉRICAS
subdecision_condiciones_atmosfericas(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, CondicionAtm, _, _, _, _, _, _, _, _, _, _, _),
    member(CondicionAtm, Lista).

subdecision_condiciones_atmosfericas(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, CondicionAtm, _, _, _, _, _, _, _, _, _, _, _),
    \+ member(CondicionAtm, Lista).


% HABITABILIDAD
subdecision_habitabilidad(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, Habitabilidad, _, _, _, _, _, _, _),
    member(Habitabilidad, Lista).

subdecision_habitabilidad(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, Habitabilidad, _, _, _, _, _, _, _),
    \+ member(Habitabilidad, Lista).


% TAMAÑO
subdecision_size(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, Size, _, _, _, _, _, _),
    member(Size, Lista).

subdecision_size(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, Size, _, _, _, _, _, _),
    \+ member(Size, Lista).


% LUMINOSIDAD
subdecision_luminosidad(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, Luminosidad, _, _, _, _, _),
    member(Luminosidad, Lista).

subdecision_luminosidad(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, Luminosidad, _, _, _, _, _),
    \+ member(Luminosidad, Lista).


% BIODIVERSIDAD
subdecision_biodiversidad(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, Biodiversidad, _, _, _, _),
    member(Biodiversidad, Lista).

subdecision_biodiversidad(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, Biodiversidad, _, _, _, _),
    \+ member(Biodiversidad, Lista).


% COMPOSICIÓN
subdecision_composicion(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, Composicion, _, _, _),
    member(Composicion, Lista).

subdecision_composicion(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, Composicion, _, _, _),
    \+ member(Composicion, Lista).


% RADIACIÓN
subdecision_radiacion(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, Radiacion, _),
    member(Radiacion, Lista).

subdecision_radiacion(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, Radiacion, _),
    \+ member(Radiacion, Lista).


% CANTIDAD DE SATÉLITES
subdecision_satelites(Destino, Lista, 1) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Satelites),
    member(Satelites, Lista).

subdecision_satelites(Destino, Lista, 0) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Satelites),
    \+ member(Satelites, Lista).