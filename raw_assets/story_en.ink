
// #r1 Radio lambda
// #r2 Radio beta

// Lighthouse buddies
// #a Annie
// #b Bob

-> Day_01 ->
-> Title_Sequence ->
-> Night_01 ->
-> END



== Day_01 ==
    *   [Turn on the radio]
-   Good morning #r1
    Lorem ipsum #r1 
    blabla #r1
-   (hub)
    *   [Switch radio channel]
        This is radio 2 #r2
        hello from radio 2 #r2
        -> hub
    *   [Switch to the lighthouse channel] -> light_buddies_01
    *   {light_buddies_01} [Turn off radio]
-   ->->

= light_buddies_01
    Hello #a 
    Ho yeahhh #b
    *   Hiyaa 
    *   bloup
-   hey #a
    -> hub

== Title_Sequence ==
    GAME TITLE
    *   [continue]
-   ->->

== Night_01 ==
~ temp BA45 = 0
~ temp AE34 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [AE34] -> Ship_Dialog("AE34", AE34) -> 
    *   [21h] -> call_01 ->
    *   [22h] -> call_02 ->
    *   [Finish Night] ->->
-   -> hub

= call_01
    this is a mysterious call
    +   [Hang up.]
-   ->->

= call_02
    this is a mysterious conditional call
    +   [Hang up.]
-   ->->

== Ship_Dialog (ship_transponder, ref ship_call_count) ==
    ~ ship_call_count ++
    Hello ship {ship_transponder}, this is lighthouse Peruchet, calling for the {ship_call_count} time.
    +   [N] Head North.
    +   [S] Head South.
    +   [E] Head East.
    +   [W] Head West.
    +   [NE] Head North East.
    +   [SE] Head South East.
    +   [NW] Head North West.
    +   [SW] Head South West.
    +   [Keep on] Please keep on.
-   Copy that. 
    +   [Hang up.]
-   ->->
