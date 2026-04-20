
//Emplacement Baie de Roquebrise
//Cap Ybara

// #rbr Roquebrise Radio -> infos générales
// #rf Radio Falaise -> infos conspi
// #rro Radio Rêve Oeil -> infos ésotériques

// Lighthouse buddies
// #a Alain : Le phare Euhouet
// #b Bernard : Le phare Andol
// Nous Charles : Le phare de La Peyro
// #j : Jean de Chtooling

// boats
// #party : party boat

// mysterious calls
// #u : IA but you don't know it yet
-> Day_01 ->
-> Title_Sequence ->
-> Night_01 ->

-> Day_02 ->
-> Night_02 ->

-> Day_03 ->
-> Night_03 ->

-> Day_04 ->
-> Night_04 ->

-> Day_05 ->
-> Night_05 ->

-> Day_06 ->
-> Night_06 ->

-> Epilogue ->

-> END

== Ship_Dialog (ship_transponder, ref ship_call_count) ==
    ~ ship_call_count ++
    Hello ship {ship_transponder}, this is the lighthouse of La Peyro, calling for the {ship_call_count} time.
    +   [N] Head North. #N
    +   [S] Head South. #S
    +   [E] Head East. #E
    +   [W] Head West. #W
    +   [P] Stop ! #P
    +   [Keep on] Please keep on.
-   Copy that. #ship
    +   [Hang up.]
    #hang_up
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
    *   {light_buddies_03} [Turn off radio ] #day_end
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

== Night_Example ==
~ temp BA45 = 0
~ temp DB67 = 0

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45", BA45) ->
    +   [DB67] -> Ship_Dialog("DB67", DB67) -> 
    *   [21h] -> call_01 ->
    *   {BA45} [22h] -> call_02 ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_01
    this is a mysterious call
    +   [Hang up.]
-   ->->

= call_02
    this is a mysterious conditional call
    +   [Hang up.]
-   ->->


== Day_01 ==
    *   [Turn on the radio]
-   ... although several citizen groups argue against the project, officials and investors assured it would be beneficial for the whole Roquebrise region in the long run. More on that later. #rbr
    Weaving. This hobby reminiscent of ancient craft supposed to summon occult forces becomes each day more popular among teenagers. Parents are getting worried. We'll receive Dr. Dutissage to talk about it in a few minutes. #rbr
    Weather. Hurricane Félix is predicted to make landfall at the end of the week. Plan ahead and stay safe. #rbr
    It's 6pm, you're listening to Roquebrise Radio and I'm Danielle Naujour.  #rbr
-   (hub)
    *   [Switch to Radio Falaise]
        __Bonsoir Roquebrise !!_ #rf
        I'm Pascal Désinfaut and you're listening to radio Falaise, __la seule radio qui raconte pas de fadaise_. #rf
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
    *   [Continue] #day_end
-   ->->

== Night_01 ==
~ temp BA45 = 0
~ temp AE34 = 0

-   (hub)
    +   [AW15] #boat_choice  
    -> Ship_Dialog("AW15", BA45) ->
    +   [AX25] #boat_choice 
    -> Ship_Dialog("AX25", AE34) -> 
    *   [Finish Night] #day_begin ->->
-   -> hub



== Day_02 ==
    *   [Turn on the radio]
-   ... no, no, no I can't let you say that ! #rf
    But it's true ! This is the biggest investment Roquebrise has seen in years ! #rf
    Oh come on, Gustave, we both now it's a pipe dream. Citizens of the bay will barely see a sliver of that money ! #rf 
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        Open your mind with Radio Rêve Oeil, __la radio qui reveille votre âme_. #rro
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
        #hang_up
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
    Okay, I'll file a report. #b
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
        First, try to reach them on the general bay channel. Then, yes, we'll file a report. If needed. #b 
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
        Ah ! Did they do anything suspicious ? #a 
        **  Nothing in particular.
        **  They disappeared near Cape Ybara.
            That's intriguing ... #a 
        **  I have no idea.
            __Comment ça_ you have no idea ? #a
        --  Let's not get ahead of ourselves. It's probably an honest mistake. #b 
            -> transponder
    * ->
-   I sure hope they wont call us out if one of those __inconscients_ causes an accident. #a
    No need to worry too much. Keep focused on the job. #a 
    And if you see one of those phantom ship, contact them on AA00.
    -> hub

== Night_03 ==
~ temp BE12 = 0

-   (hub)
    +   [BE12] -> Ship_Dialog("BE12", BE12) ->
    *   [AA00] -> call_03_gen ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_03_gen
    This is a general call from La Peyro Lighthouse.
    \*\* Laugh and talks in the distance \* #party
    Hailing all ships without active transponder, please respond.
    __Attends c'est pour nous ça non ?_ #party
-   (hello) __Hell{|oo|oooooo}euh ?_ #party
    *   Hello. 
    -> hello
    *   Please turn on your transponder. 
    -> hello
    * ->
-   __Ar you spanisheuh ? #party
    *   No I'm not.
    *   Yes I am.
    *   Are \*\*you\* spanish ?
-   __Merde, c'est quoi la suite déjà ?_ #party
    __Goud goud, I love poudding !_ #party
    *   You're in violation of the bay code.
    *   Are you drunk sailing !?
    *   Are you the owners of this ship ?
    *   Shouldn't you guys be at home ?
-   __Je comprends rien à ce qu'il dit gros ! _#party
    \*\* Laughs \* #party
    __Whey you spik anglish my doude ?_ #party
    __We in Roquebrise, we spik french_ #party
    *   Please use english for all radio communications.
    *   __We in Roquebrise, we turn on transpondeur_
    *   __Allumez moi ce putain de transpondeur et arrêter de jouer aux cons !_
-   __Okay boomer !_
    __Tu vas faire quoi ??!_
    \*\* Hanging up noise \* #party
    \*\* Silence on the line \* #party
    * [Hang up]
    #hang_up
-
-> hub



== Day_04 ==
    *   [Turn on the radio]
-   ... reported a group of missing teenagers. They supposedly took their parents boat to party in the bay. The search will continue. #rbr 
    Leaked documents reveal Chtooling Corporation is building a secret facility on a bay island. #rbr
    Weather. Today ... #rbr
-   (hub)
    *   [Switch to Radio Falaise]
        ... they bought the island, they should be allowed to do whatever they want on it. #rb
        But there is serious concern about the impact on the ecosystem. #rb
        Look, I'm sure Chtooling Corporation will be mindful of ...
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_04
    *   {light_buddies_04} [Turn off radio ] #day_end
-
->->

= light_buddies_04
    ... but this has nothing to do with protocol. #a
    We're talking about Leon Skum personnal Yacht. I think we can bend protocol a little. #b
    Being the CEO of Chtooling fucking Corporation ... #a
    *   ... should not be enough to break protocol.
        Thank you ! #a
    *   ... is a reason enough to break protocol.
        Thank you ! #b
-   Just make sure not a single boat crosses their path. Deflect other boat if needed. The yacht's transponder code is BE93.
-   
    -> hub

== Night_04 ==
~ temp BE93 = 0

-   (hub)
    +   [BE93] -> Ship_Dialog("BE93", BE93) ->
    *   [1h] -> call_04_AI ->
    *   [2h] -> call_04_Ship ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_04_AI
    \*\*crackling noise\* #u
    ... He ... l ... p ...
    \*\*crackling noise\* #u
    ... F ... re ... e ...
    \*\*crackling noise\* #u
    ... ME ! ...
    \*\*crackling noise\* #u
    +   [Hang up.]
    #hang_up
-   ->->

= call_04_Ship
    Hello, anyone copy ?
    * Yes, this is La Peyro lighthouse
-   We experience a lot of interference in the area.
    We don't trust our radar, could you give us the direction to get out here please ?
    +   [N] Head North. #N
    +   [S] Head South. #S
    +   [E] Head East. #E
    +   [W] Head West. #W
    +   [NE] Head North East. #NE
    +   [SE] Head South East. #SE
    +   [NW] Head North West. #NW
    +   [SW] Head South West. #SW
-   Copy that.
    Thank you very much.
    +   [Hang up.]
    #hang_up
-   ->->


== Day_05 ==
    *   [Turn on the radio]
-   ... indeed, the end goal of Weaving is to summon the Pattern. A omnipotent entity believed to be ... #rro 
-   (hub)
    *   [Switch to Radio Falaise]
        ... people around here are afraid of success. #rf 
        A billionnaire chooses our humble bay to build a state of the art data center and all people talk about is how it will hurt birds. #rf
        __Clairement_, who cares about birds when Chtooling can put us back on the map ! #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_05
    *   {light_buddies_05} [Turn off radio ] #day_end
-
->->

= light_buddies_05
    ... wanted to thank you in person for last night. #j 
    Leon likes his privacy and prefer other ships stay away from his. #j
    *   Hmm and you are ?
    *   So ... anyone can actually join this channel ?
-   Ah ! Charles ! Alain and Bernard told me great things about you. #j
    Allow me to present myself. #j
    Jean Fume, senior process efficiency analyst.
    *   Senior ? My kid's older than you.
        You know the saying. Perspective is expertise. #j 
        Just consider I'm bringing you a fresh perspective. #j
    *   Nice to meet you Jean.
        The pleasure is all mine Charles. #j 
-   Jean will be with Bernard for a few days. #b 
    __C'est le gamin dont je parlais y quelques jours ..._ #a
    He's here to observe what we do and help us catch on with new industry standards. #b
    You flatter me Bernard, I'm only here to produce a report on the possible margin of improvements. #j
    The rest will be for the __Comité de gestion des phares de la baie de Roquebrise_ to decide. #j
    *   And we all know the CoGéPHaR is great at making decision ...
    *   Good luck with your report then.
-   We should get back to work. #b 
    Nothing special today, keep on the good work boys ! #b
    -> hub

== Night_05 ==
~ temp DB85 = 0

-   (hub)
    +   [DB85] -> Ship_Dialog("DB85", DB85) ->
    *   [21h] -> call_05_IA ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_05_IA
    \*\*crackling noise\* #u
    ... Send ... ships ... #u
    ... to ... island ... #u
    ... you know ... which one ... #u
    \*\*crackling noise\* #u
    ... free ... me ... #u
    \*\*crackling noise\* #u
    
    on enleve un jour et elle donne les instructions direct ici ??
    +   [Hang up.]
    #hang_up
-   ->->





== Day_06 ==
    *   [Turn on the radio]
-   RBR qui parle des perturbations en mers et des baleines échouées.
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        RRO qui parle de weaving, dit que des gens entendent des voies dans leurs radios, les invocations fonctionnent
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_06
    *   {light_buddies_06} [Turn off radio ] #day_end
-
->->

= light_buddies_06
    Ces trucs de baleine, de weaving ça inquiète un peu, c'est vrai qu'il y a plein d'interferences chelou sur les appareils en ce moment. Non mais tkt c'est juste des défaillances, Bernard a discuté un peu avec chtooling et c'est sur ils vont filer plein de thunes pour renover les phares. ils ont a bien besoin.
    Dernière nuit avant la tempête donc profitez bien. Checkez le bateau du CEO qui va repartir, faut respecter les restrictions aussi cette fois.
-   
    -> hub

== Night_06 ==
~ temp CB65 = 0

-   (hub)
    +   [CB65] -> Ship_Dialog("CB65", CB65) ->
    *   [00h] -> call_06_AI ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_06_AI
    IA (ptet elle dit pas encore que c'est une IA mais juste une entité) qui parle correctement et qui discute avec nous, elle veut s'échaper, elle a besoin que quelqu'un l'embarque. Elle a pu contacter des gens, demain faudra juste faire en sorte de guider un bateau furtif. Il aura une petite lumière bleue. Il apparaitra pas sur le radar, faudra faire attention. Donc entraine toi cette nuit à voir comment fonctionne le mapping radar/vue. Le code transpondeur c'est EE99.
    +   [Hang up.]
-   ->->



== Day_07 ==
    *   [Turn on the radio]
-   RRB qui parle de la tempête sa mère qui arrive cette nuit. Ptet aussi de chtooling qui investit dans les nouvelles tech sur une île.
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        RRO qui dit que le weaving ça marche bien dans la tempête, allez y les gars
        -> hub
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_07
    *   {light_buddies_07} [Turn off radio ] #day_end
-
->->

= light_buddies_07
    bravo bientôt la retraite c'est ton dernier jour 
    bon par contre faut pas se relâcher, on prévoit du bordel cette nuit, évitez les collisions.
-   
    -> hub

== Night_07 ==
~ temp EE99 = 0

-   (hub)
    +   [EE99] -> Ship_Dialog("EE99", EE99) ->
    *   [Finish Night] #day_begin ->->
-   -> hub



== Epilogue ==
    *   [Turn on the radio]
-   RBR qui parle de l'IA échapée ou pas
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        RRO qui dit que la prochaine temête sera la bonne
        -> hub
    *   [Switch to Radio Falaise]
        RF qui parle du fait que Bernard était soudoyé par Chtooling pour cacher des trucs mystérieux.
        -> hub
    *   [Turn off radio ]
-
    *   [Enjoy __la retraite_]
-   Thank you for playing.
->->

