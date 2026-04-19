
//Emplacement Baie de Roquebrise
//Cap Ybara

// #rbr Roquebrise Radio -> infos générales
// #rf Radio Falaise -> infos conspi
// #rre Radio Rêve Oeil -> infos ésotériques

// Lighthouse buddies
// #a Alain : Le phare Euhouet
// #b Bernard : Le phare Andol
// Nous Charles : Le phare de La Peyro

-> Day_01 ->
-> Title_Sequence ->
-> Night_01 ->
-> END



== Day_01 ==
    *   [Turn on the radio]
-   ... although several citizen groups argue against the project, officials and investors assured it would be beneficial for the whole Roquebrise region in the long run. More on that later. #rbr
    Weaving. This hobby reminiscent of ancient craft supposed to summon occult forces becomes each day more popular among teenagers. Parents are getting worried. We'll receive Dr. Dutissage to talk about it in a few minutes. #rbr
    Weather. Hurricane Félix is predicted to make landfall at the end of the week. Plan ahead and stay safe. #rbr
    It's 6pm, you're listening to Roquebrise Radio and I'm Danielle Naujour.  
-   (hub)
    *   [Switch to Radio Falaise]
        _Bonsoir Roquebrise !!_ #rf
        I'm Eric Désinfaut and you're listening to radio Falaise, _la seule radio qui raconte pas de fadaise_. #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_01
    *   {light_buddies_01} [Turn off radio]
-   ->->

= light_buddies_01
-   (intro)
    {You listening |}Charles {?|!?} #b 
    *   Hmm yes ...
        _mouais ... bon, écoutes_
    *   Sorry, just turned on the channel.
    *   [Say nothing] -> intro
-   As I was saying, dispatch wants us to open our eyes for BA45. #b
    The ship will be coming in tonight but has reported malfunctions with its localization software. #b
    Just make sure the boat doesn't run aground in the bay. #b
    *   And how am I supposed to do that ?
        Just watch for the ship with transponder code BA45 and redirect it with the radio if it ever comes too close to land. #b
        Ah ! I see what you did there, very funny. #b
    *   Okay[.], I'll keep an eye out for BA45.
        Great, <>
    *   I know my job, Bernard.
-   I know it's your last week but go easy with _l'apéro_. We still need you here, the rest can wait until _la retraite_.
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
    *   {BA45} [22h] -> call_02 ->
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
