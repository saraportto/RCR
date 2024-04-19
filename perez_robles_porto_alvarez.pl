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

% Presupuesto maximo disponible
opcion(luna, presupuesto, 5000).
opcion(marte, presupuesto, 10000).
opcion(saturno, presupuesto, 30000).
opcion(venus, presupuesto, 15000).

% Distancia maximaa de la Tierra (en kilómetros)
opcion(luna, distancia_tierra, 384400).
opcion(marte, distancia_tierra, 225000000).
opcion(saturno, distancia_tierra, 1275000000).
opcion(venus, distancia_tierra, 26100000).

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
opcion(luna, tamaño, pequeño).
opcion(marte, tamaño, mediano).
opcion(saturno, tamaño, grande).
opcion(venus, tamaño, grande).

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

% Reglas de decisión
decision([[GravedadMin, GravedadMax], [Temperatura|_], [TiempoMin, TiempoMax], CondicionAtm, PresuMax, DistMax, RiesgiosAmb, Habitabilidad, Size, Luminosidad, Biodiversidad], Destino) :-
    subdecision_gravedad(GravedadMin, GravedadMax, Destino),
    subdecision_temperatura(Temperatura, Destino),
    subdecision_tiempo_viaje(TiempoMin, TiempoMax, Destino),
    subdecision_condiciones_atmosfericas(CondicionAtm, Destino),
    subdecision_presupuesto(PresuMax, Destino),
    subdecision_distancia_tierra(DistMax, Destino),
    subdecision_riesgos_ambientales(RiesgiosAmb, Destino),
    subdecision_habitabilidad(Habitabilidad, Destino),
    subdecision_tamaño(Size, Destino),
    subdecision_luminosidad(Luminosidad, Destino),
    subdecision_biodiversidad(Biodiversidad, Destino).

% Definir subdecisiones para cada parámetro
subdecision_gravedad(GravedadMin, GravedadMax, Destino) :-
    opcion(Destino, gravedad, Gravedad),
    Gravedad >= GravedadMin,
    Gravedad =< GravedadMax.

subdecision_temperatura(Temperatura, Destino) :-
    opcion(Destino, _, Temperatura).

subdecision_tiempo_viaje(TiempoMin, TiempoMax, Destino) :-
    opcion(Destino, tiempo_viaje, TiempoViaje),
    TiempoViaje >= TiempoMin,
    TiempoViaje =< TiempoMax.

subdecision_condiciones_atmosfericas(CondicionAtm, Destino) :-
    opcion(Destino, condiciones_atmosfericas, CondicionAtm).

subdecision_presupuesto(PresuMax, Destino) :-
    opcion(Destino, presupuesto, Presu),
    Presu =< PresuMax.

subdecision_distancia_tierra(DistMax, Destino) :-
    opcion(Destino, distancia_tierra, Dist),
    Dist =< DistMax.

subdecision_riesgos_ambientales(RiesgiosAmb, Destino) :-
    opcion(Destino, riesgos_ambientales, RiesgiosAmb).

subdecision_habitabilidad(Habitabilidad, Destino) :-
    opcion(Destino, habitabilidad, Habitabilidad).

subdecision_tamaño(Size, Destino) :-
    opcion(Destino, tamaño, Size).

subdecision_luminosidad(Luminosidad, Destino) :-
    opcion(Destino, luminosidad, Luminosidad).

subdecision_biodiversidad(Biodiversidad, Destino) :-
    opcion(Destino, biodiversidad, Biodiversidad).

