% Hechos sobre las opciones de los destinos interplanetarios
opcion(luna, 1.62, mucho_frio, 3, mala, 30000, 384400, sin_riesgos, nula, pequeno, totalmente_oscuro, nada_biodiverso, rocoso, sin_atmosfera, baja, ninguno).
opcion(marte, 3.71, frio, 6, regular, 100000, 301470000, con_riesgos, poca, mediano, un_poco_oscuro, poco_biodiverso, arenoso, con_atmosfera, moderada, pocos).
opcion(saturno, 10.44, normal, 24, buena, 3000000, 1548900000, con_riesgos, regular, grande, un_poco_luminoso, biodiverso, gaseoso, con_atmosfera, nula, muchos).
opcion(venus, 8.87, mucho_calor, 4, muy_buena, 1500000, 251820000, con_riesgos, excelente, grande, bastante_luminoso, muy_biodiverso, volcanico, con_atmosfera, alta, ninguno).


% Reglas de decisión
decision([[GravedadMin, GravedadMax], Temperatura, [TiempoMin, TiempoMax], CondicionAtm, PresuMax, DistMax, RiesgiosAmb, Habitabilidad, Size, Luminosidad, Biodiversidad, Composicion, Atmosfera, Radiacion, Satelites], Destino) :-
    subdecision_gravedad(Destino, [GravedadMin, GravedadMax]),
    subdecision_temperatura(Destino, Temperatura),
    subdecision_tiempo_de_viaje(Destino, [TiempoMin, TiempoMax]),
    subdecision_condiciones_atmosfericas(Destino, CondicionAtm),
    subdecision_presu(Destino, PresuMax),
    subdecision_distancia(Destino, DistMax),
    subdecision_riesgos_ambientales(Destino, RiesgiosAmb),
    subdecision_habitabilidad(Destino, Habitabilidad),
    subdecision_size(Destino, Size),
    subdecision_luminosidad(Destino, Luminosidad),
    subdecision_biodiversidad(Destino, Biodiversidad),
    subdecision_composicion(Destino, Composicion),
    subdecision_atmosfera(Destino, Atmosfera),
    subdecision_radiacion(Destino, Radiacion),
    subdecision_satelites(Destino, Satelites).


% Gravedad
subdecision_gravedad(Destino, [LimiteInf, LimiteSup]) :-
    opcion(Destino, Gravedad, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),
        Gravedad >= LimiteInf

    ;   var(LimiteInf)
    ),
    (   nonvar(LimiteSup),
        Gravedad =< LimiteSup

    ;   var(LimiteSup)
    ).


% Temperatura 
subdecision_temperatura(Destino, Lista) :-
    opcion(Destino, _, Temperatura, _, _, _, _, _, _, _, _, _, _, _, _, _),
    member(Temperatura, Lista).


% Tiempo de viaje 
subdecision_tiempo_de_viaje(Destino, [LimiteInf, LimiteSup]) :-
    opcion(Destino, _, _, TiempoViaje, _, _, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(LimiteInf),
        TiempoViaje >= LimiteInf

    ;   var(LimiteInf)
    ),
    (   nonvar(LimiteSup),
        TiempoViaje =< LimiteSup

    ;   var(LimiteSup)
    ).


% Condiciones atmosféricas
subdecision_condiciones_atmosfericas(Destino, Lista) :-
    opcion(Destino, _, _, _, CondicionAtm, _, _, _, _, _, _, _, _, _, _, _),
    member(CondicionAtm, Lista).


% Presupuesto maximo
subdecision_presu(Destino, PresuMax) :-
    opcion(Destino, _, _, _, _, Presu, _, _, _, _, _, _, _, _, _, _),
    (   nonvar(PresuMax),
        Presu =< PresuMax

    ;   var(PresuMax)
    ).


% Distancia maxima a la Tierrra
subdecision_distancia(Destino, DistMax) :-
    opcion(Destino, _, _, _, _, _, DistTierra, _, _, _, _, _, _, _, _, _),
    (   nonvar(DistMax),
        DistTierra =< DistMax

    ;   var(DistMax)
    ).


% Riesgos ambientales
subdecision_riesgos_ambientales(Destino, Riesgos) :-
    opcion(Destino, _, _, _, _, _, _, RiesgiosAmb, _, _, _, _, _, _, _, _),
    RiesgiosAmb = Riesgos.


% Habitabilidad
subdecision_habitabilidad(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, Habitabilidad, _, _, _, _, _, _, _),
    member(Habitabilidad, Lista).


% Tamaño
subdecision_size(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, Size, _, _, _, _, _, _),
    member(Size, Lista).


% Luminosidad
subdecision_luminosidad(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, Luminosidad, _, _, _, _, _),
    member(Luminosidad, Lista).


% Biodiversidad
subdecision_biodiversidad(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, Biodiversidad, _, _, _, _),
    member(Biodiversidad, Lista).


% Composicion
subdecision_composicion(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, Composicion, _, _, _),
    member(Composicion, Lista).


% Atmosfera
subdecision_atmosfera(Destino, Atm) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, Atmosfera, _, _),
    Atmosfera = Atm.


% Radiacion
subdecision_radiacion(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, Radiacion, _),
    member(Radiacion, Lista).


% Cantidad de satelites
subdecision_satelites(Destino, Lista) :-
    opcion(Destino, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Satelites),
    member(Satelites, Lista).