% Hechos sobre las opciones de los destinos interplanetarios
% Gravedad
opcion(luna, gravedad, 1.62).
opcion(marte, gravedad, 3.71).
opcion(saturno, gravedad, 10.44).
opcion(venus, gravedad, 8.87).

% Temperatura
opcion(luna, temperatura, mucho_frio).
opcion(marte, temperatura, frio).
opcion(saturno, temperatura, normal).
opcion(venus, temperatura, mucho_calor).

% Tiempo del viaje (en meses)
opcion(luna, tiempo_viaje, 3).
opcion(marte, tiempo_viaje, 6).
opcion(saturno, tiempo_viaje, 24).
opcion(venus, tiempo_viaje, 4).

% Condiciones atmosféricas
opcion(luna, condiciones_atmosfericas, mala).
opcion(marte, condiciones_atmosfericas, regular).
opcion(saturno, condiciones_atmosfericas, buena).
opcion(venus, condiciones_atmosfericas, muy_buena).

% Presupuesto maximo disponible (millones de dólares)
opcion(luna, presupuesto, 30000).
opcion(marte, presupuesto, 100000).
opcion(saturno, presupuesto, 3000000).
opcion(venus, presupuesto, 1500000).

% Distancia maxima de la Tierra (kilómetros)
opcion(luna, distancia_tierra, 384400).
opcion(marte, distancia_tierra, 301470000).
opcion(saturno, distancia_tierra, 1548900000).
opcion(venus, distancia_tierra, 251820000).

% Riesgos ambientales (actividad volcánica)
opcion(luna, riesgos_ambientales, sin_riesgos).
opcion(marte, riesgos_ambientales, con_riesgos).
opcion(saturno, riesgos_ambientales, con_riesgos).
opcion(venus, riesgos_ambientales, con_riesgos).

% Habitabilidad
opcion(luna, habitabilidad, nula).
opcion(marte, habitabilidad, poca).
opcion(saturno, habitabilidad, regular).
opcion(venus, habitabilidad, excelente).

% Tamaño
opcion(luna, size, pequeno).
opcion(marte, size, mediano).
opcion(saturno, size, grande).
opcion(venus, size, grande).

% Luminosidad
opcion(luna, luminosidad, totalmente_oscuro).
opcion(marte, luminosidad, un_poco_oscuro).
opcion(saturno, luminosidad, un_poco_luminoso).
opcion(venus, luminosidad, bastante_luminoso).

% Biodiversidad
opcion(luna, biodiversidad, nada_biodiverso).
opcion(marte, biodiversidad, poco_biodiverso).
opcion(saturno, biodiversidad, biodiverso).
opcion(venus, biodiversidad, muy_biodiverso).

% Composición
opcion(luna, composicion, rocoso).
opcion(marte, composicion, arenoso).
opcion(saturno, composicion, gaseoso).
opcion(venus, composicion, volcanico).

% Atmósfera
opcion(luna, atmosfera, sin_atmosfera).
opcion(marte, atmosfera, con_atmosfera).
opcion(saturno, atmosfera, con_atmosfera).
opcion(venus, atmosfera, con_atmosfera).

% Radiación
opcion(luna, radiacion, baja).
opcion(marte, radiacion, moderada).
opcion(saturno, radiacion, nula).
opcion(venus, radiacion, alta).

% Cantidad de satélites 
opcion(luna, satelites, ninguno).
opcion(marte, satelites, pocos).
opcion(saturno, satelites, muchos).
opcion(venus, satelites, ninguno).



% Reglas de decisión
decision([[GravedadMin, GravedadMax], Temperatura, [TiempoMin, TiempoMax], CondicionAtm, PresuMax, DistMax, RiesgiosAmb, Habitabilidad, Size, Luminosidad, Biodiversidad, Composicion, Atmosfera, Radiacion, Satelites], Destino) :-
    subdecision_gravedad(GravedadMin, GravedadMax, Destino),
    subdecision_temperatura(Temperatura, Destino),
    subdecision_tiempo_viaje(TiempoMin, TiempoMax, Destino),
    subdecision_condiciones_atmosfericas(CondicionAtm, Destino),
    subdecision_presupuesto(PresuMax, Destino),
    subdecision_distancia_tierra(DistMax, Destino),
    subdecision_riesgos_ambientales(RiesgiosAmb, Destino),
    subdecision_habitabilidad(Habitabilidad, Destino),
    subdecision_size(Size, Destino),
    subdecision_luminosidad(Luminosidad, Destino),
    subdecision_biodiversidad(Biodiversidad, Destino),
    subdecision_composicion(Composicion, Destino),
    subdecision_atmosfera(Atmosfera, Destino),
    subdecision_radiacion(Radiacion, Destino),
    subdecision_satelites(Satelites, Destino).

% Definir subdecisiones para cada parámetro
subdecision_gravedad(GravedadMin, GravedadMax, Destino) :-
    opcion(Destino, gravedad, Gravedad),
    (   nonvar(GravedadMin),
        Gravedad >= GravedadMin

    ;   var(GravedadMin)
    ),
    (   nonvar(GravedadMax),
        Gravedad =< GravedadMax

    ;   var(GravedadMax)
    ).


subdecision_temperatura(Lista, Destino) :-
    opcion(Destino, temperatura, Temperatura),
    (   var(Lista)
    ;   member(Temperatura, Lista)
    ).


subdecision_tiempo_viaje(TiempoMin, TiempoMax, Destino) :-
    opcion(Destino, tiempo_viaje, TiempoViaje),
    (   nonvar(TiempoMin),
        TiempoViaje >= TiempoMin

    ;   var(TiempoMin)
    ),
    (   nonvar(TiempoMax),
        TiempoViaje =< TiempoMax

    ;   var(TiempoMax)
    ).


subdecision_condiciones_atmosfericas(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, condiciones_atmosfericas, Lista)

    ;   opcion(Destino, condiciones_atmosfericas, CondicionAtm),
        member(CondicionAtm, Lista)
    ).


subdecision_presupuesto(PresuMax, Destino) :-
    opcion(Destino, presupuesto, Presu),
    (   nonvar(PresuMax),
        Presu =< PresuMax

    ;   var(PresuMax)
    ).


subdecision_distancia_tierra(DistMax, Destino) :-
    opcion(Destino, distancia_tierra, Dist),
    (   nonvar(DistMax),
        Dist =< DistMax

    ;   var(DistMax)
    ).


subdecision_riesgos_ambientales(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, riesgos_ambientales, Lista)

    ;   opcion(Destino, riesgos_ambientales, RiesgiosAmb),
        member(RiesgiosAmb, Lista)
    ).


subdecision_habitabilidad(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, habitabilidad, Lista)

    ;   opcion(Destino, habitabilidad, Habitabilidad),
        member(Habitabilidad, Lista)
    ).


subdecision_size(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, size, Lista)

    ;   opcion(Destino, size, Size),
        member(Size, Lista)
    ).


subdecision_luminosidad(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, luminosidad, Lista)

    ;   opcion(Destino, luminosidad, Luminosidad),
        member(Luminosidad, Lista)
    ).


subdecision_biodiversidad(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, biodiversidad, Lista)

    ;   opcion(Destino, biodiversidad, Biodiversidad),
        member(Biodiversidad, Lista)
    ).


subdecision_composicion(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, composicion, Lista)

    ;   opcion(Destino, composicion, Composicion),
        member(Composicion, Lista)
    ).


subdecision_atmosfera(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, atmosfera, Lista)
        
    ;   opcion(Destino, atmosfera, Atmosfera),
        member(Atmosfera, Lista)
    ).


subdecision_radiacion(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, radiacion, Lista)

    ;   opcion(Destino, radiacion, Radiacion),
        member(Radiacion, Lista)
    ).


subdecision_satelites(Lista, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, satelites, Lista)

    ;   opcion(Destino, satelites, Satelites),
        member(Satelites, Lista)
    ).

