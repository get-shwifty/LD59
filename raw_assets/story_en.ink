
//Emplacement Baie de Roquebrise
//Cap Ybara

// #rbr Roquebrise Radio -> infos générales
// #rf Radio Falaise -> infos conspi
// #rro Radio Rêve Oeil -> infos ésotériques

// Lighthouse buddies
// #a Alain : Le phare Euhouet
// #b Bernard : Le phare Andol
// Nous Charles : Le phare de La Peyro

// mysterious calls
// #u : IA but you don't know it yet

-> Day_01 ->
-> Title_Sequence ->
-> Night_01 ->
-> Day_02 ->
-> Night_02 ->
-> Day_03 ->
-> Night_03 ->
-> END

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

== Night_Example ==
~ temp BA45 = 0
~ temp DB67 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [DB67] -> Ship_Dialog("DB67", DB67) -> 
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

== Day_Example ==
    *   [Turn on the radio]
-   ... no, no, no I can't let you say that ! #rf
    But it's true ! This is the biggest investment Roquebrise has seen in years ! #rf
    Oh come on, Gustave, we both now it's a pipe dream. Citizens of the bay will barely see a sliver of that money ! #rf 
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        Open your mind with Radio Rêve Oeil, _la radio qui reveille votre âme_. #rro
        Today we receive Eric Esoth, a weaving specialist. He'll tell us about this ancient art and how it can improve your life. #rro
        Eric, welcome on the show ! #rro
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_03
    *   {light_buddies_03} [Turn off radio ]
-
->->

= light_buddies_03
    ... I'm telling you I'm tired of this shit Bernard. #a
    *   What kind of shit ?
        Alain was just explaining to me how much he envied you. #b
        __Pétard Bernard !_ You know it has nothing to do with that. 
    *   [Keep listening]
-   25 years on the job. #a
    A quarter of a century years of telling management our tech is outdated crap. #a
    An eternity hearing the same answer. __N'allez pas plus vite que la musique mon petit Yannick._ #a
    *   Who's Yannick ?
        Hell if I know ! #a
    *   [Keep listening]
-   
    -> hub

== Day_01 ==
    *   [Turn on the radio]
-   ... although several citizen groups argue against the project, officials and investors assured it would be beneficial for the whole Roquebrise region in the long run. More on that later. #rbr
    Weaving. This hobby reminiscent of ancient craft supposed to summon occult forces becomes each day more popular among teenagers. Parents are getting worried. We'll receive Dr. Dutissage to talk about it in a few minutes. #rbr
    Weather. Hurricane Félix is predicted to make landfall at the end of the week. Plan ahead and stay safe. #rbr
    It's 6pm, you're listening to Roquebrise Radio and I'm Danielle Naujour.  #rbr
-   (hub)
    *   [Switch to Radio Falaise]
        __Bonsoir Roquebrise !!_ #rf
        I'm Eric Désinfaut and you're listening to radio Falaise, __la seule radio qui raconte pas de fadaise_. #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_01
    *   {light_buddies_01} [Turn off radio]
-   ->->

= light_buddies_01
-   (intro)
    {You listening |}Charles {?|!?} #b 
    *   Hmm yes ...
        __mouais ... bon, écoutes_
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
-   I know it's your last week but go easy with __l'apéro_. We still need you here, the rest can wait until __la retraite_. #b
    -> hub

== Title_Sequence ==
    #title_screen
    *   [continue] #day_end
-   ->->

== Night_01 ==
~ temp BA45 = 0
~ temp AE34 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [AE34] -> Ship_Dialog("AE34", AE34) -> 
    *   [Finish Night] #day_begin ->->
-   -> hub

== Day_02 ==
    *   [Turn on the radio]
-   ... no, no, no I can't let you say that ! #rf
    But it's true ! This is the biggest investment Roquebrise has seen in years ! #rf
    Oh come on, Gustave, we both now it's a pipe dream. Citizens of the bay will barely see a sliver of that money ! #rf 
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        Open your mind with Radio Rêve Oeil, _la radio qui reveille votre âme_. #rro
        Today we receive Eric Esoth, a weaving specialist. He'll tell us about this ancient art and how it can improve your life. #rro
        Eric, welcome on the show ! #rro
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_02
    *   {light_buddies_02} [Turn off radio] #day_end
-
->->

= light_buddies_02
    ... I'm telling you I'm tired of this shit Bernard. #a
    *   What kind of shit ?
        Alain was just explaining to me how much he envied you. #b
        __Pétard Bernard !_ You know it has nothing to do with that. 
    *   [Keep listening]
-   25 years on the job. #a
    A quarter of a century of telling management our tech is outdated crap. #a
    An eternity hearing the same answer. __N'allez pas plus vite que la musique mon petit Yannick._ #a
    *   Who's Yannick ?
        Hell if I know ! #a
    *   [Keep listening]
-   And now they send a boy to teach me my job ? #a
    Jean is not here to teach you your job. #b
    He's only here to make a report on possible process efficiency improvement. #b
-   (consulting)
    *   Is he the guy from Chtooling Consulting ?
        He wasn't event born when I started this job ! #a
        He's a fine young consultant, sent by Leon Skum himself and promised to a great carreer. It can't hurt to befriend him a little. #b 
        -> consulting
    *   __Punaise_, you talk like them Bernard.
        I'm only following the music guys. #b
        -> consulting
    *   I'm sure possible process efficiency improvements can be a good thing.
        Yeah, sure.  Easy for you to say. #a
    *   Fuck Chtooling !
        Fuck Chtooling ! Fuck Consulting ! #a
        **  Fuck Consulting !
            Fuck them ! #b
        **  [Say nothing]
        --  __Bon bon, ca va les gars on a compris_ #b
-   Regarding more serious matters. #b
    We still need to look out for BA45 tonight. #b
-   (BA45)
    *   Okay[.], I'll keep an eye out.
        -> hub
    *   Didn't they fix their stuff ?
        Are you surprised ? #a
        -> BA45
    *   They're leaving already ?
        Looks like it, yes. #b
        -> BA45

== Night_02 ==
~ temp BA45 = 0
~ temp DB67 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [DB67] -> Ship_Dialog("DB67", DB67) ->
    *   [22h] -> call_02 ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_02
-   (call_hub)
    \*\*{|More |Just |A new variaty of |Crumbly and }crackling noise\* #u
    *   Hello ?
    *   [Keep listening]
    *   {call_hub > 1} This isn't funny.
    *   {call_hub > 1} [Imitate crackling noise]
        gzzz crch bzz crch
    +   {call_hub > 1} [Hang up.]
        ->->
-   ->call_hub

== Day_03 ==
    *   [Turn on the radio]
-   ... then as I chanted the name of the weaving rune, it happened ! #rro
    The Pattern talked to me ! #rro
    Fascinating ! And what did it say ? #rro
    I'm still not sure, it was just crackling noise on the radio but it was so intense ! #rro
-   (hub)
    *   [Switch to Roquebrise Radio]
        ... people are getting worried. #rbr
        Weather. The temperature will remain constant. The perfect condition to enjoy these evening gettaway we love so much in the bay. #rbr
        It's 6pm, you're listening to Roquebrise Ra ...
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_03
    *   {light_buddies_03} [Turn off radio] #day_end
-
->->

= light_buddies_03
    ... not event respond to my gen call on AA00. #a
    Okay, I'll file a report immediately. #b
-   (report)
    *   Did that ever work ?
        I'm just following protocol Charles. Don't get me started about that, again. #b
        -> report
    *   Report what ?
-   A ship sailing without any active transponder. #a
-   (transponder)
    *   {transponder <= 1} But that's illegal !
        __Et Dangereux._ #b 
        __Sans blagues._ #a
        -> transponder
    *   (prevent) How can we prevent that ?
        File a report apparently. #a
        First, try to reach them on the general bay channel. Then we'll file a report. If needed. #b
        -> transponder
    *   {prevent || seen} How can I join the general bay channel ?
        Input transpoder code AAOO from your cabin. Every boat in the area will receive your ... #b
        Okay enough, __c'est fini les conneries_, just make a gen call if you need to. #b
        **  Sorry it was just a stupid joke.
        **  You know my memory isn't as good as it was.
        **  [Laugh a little]
        --  __Oui oui c'est ça_ #b
            -> transponder
    *   (seen) I think I saw them too last night.
        
    
    
        

-   
    -> hub


== Night_03 ==
~ temp BA45 = 0
~ temp DB67 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [DB67] -> Ship_Dialog("DB67", DB67) -> 
    *   [Finish Night] #day_begin ->->
-   -> hub


