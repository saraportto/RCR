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
    subdecision_range(GravedadMin, GravedadMax, gravedad, Destino),
    subdecision_temperatura(Temperatura, temperatura, Destino),
    subdecision_range(TiempoMin, TiempoMax, tiempo_viaje, Destino),
    subdecision_lista(CondicionAtm, condiciones_atmosfericas, Destino),
    subdecision_max(PresuMax, presupuesto, Destino),
    subdecision_max(DistMax, distancia_tierra, Destino),
    subdecision_lista(RiesgiosAmb, riesgos_ambientales, Destino),
    subdecision_lista(Habitabilidad, habitabilidad, Destino),
    subdecision_lista(Size, size, Destino),
    subdecision_lista(Luminosidad, luminosidad, Destino),
    subdecision_lista(Biodiversidad, biodiversidad, Destino),
    subdecision_lista(Composicion, composicion, Destino),
    subdecision_lista(Atmosfera, atmosfera, Destino),
    subdecision_lista(Radiacion, radiacion, Destino),
    subdecision_lista(Satelites, satelites, Destino).


% Definir subdecisiones para cada parámetro
subdecision_range(Min, Max, car, Destino) :-
    opcion(Destino, car, Car),
    (   nonvar(Min),
        Car >= Min
    ;   var(Min)
    ),
    (   nonvar(Max),
        Car =< Max
    ;   var(Max)
    ).


subdecision_max(Max, car, Destino) :-
    opcion(Destino, car, Dist),
    (   nonvar(Max),
        Dist =< Max
    ;   var(Max)
    ).


subdecision_lista(Lista, car, Destino) :-
    (   var(Lista) ->  
        opcion(Destino, car, Lista)
    ;   opcion(Destino, car, Car),
        member(Car, Lista)
    ).
