VAR helped_the_AI = false

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

== Ship_Dialog (ship_transponder) ==
    Hello ship {ship_transponder}, this is the lighthouse of La Peyro. #c
    +   Head North. #N #c 
    +   Head South. #S #c
    +   Head East. #E #c
    +   Head West. #W #c
    +   Please wait. #P #c
    +   Please keep on. #c
-   Copy that.  #copythatship #ship
    +   [Hang up.] #raccroche #hang_up
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
    *   {light_buddies_03} [Turn off radio ] #day_end #radiooff
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
-   (hub)
    +   [BA45] -> Ship_Dialog("BA45") ->
    +   [DB67] -> Ship_Dialog("DB67") ->
    *   [01h] -> call_01 ->
    *   [02h] -> call_02 ->
    *   [Finish Night] #day_begin ->->
-   -> hub

= call_01
    this is a mysterious call
    +   [Hang up.] #hang_up
-   ->->

= call_02
    this is a mysterious conditional call
    +   [Hang up.] #hang_up
-   ->->


== Day_01 ==
    *   [Turn on the radio]
-   ... although several citizen groups argue against the project, officials and investors assured it would be beneficial for the whole Roquebrise region in the long run. More on that later. #rbr #radioon
    Weaving. This hobby reminiscent of ancient craft supposed to summon occult forces becomes each day more popular among teenagers. Parents are getting worried. We'll receive Dr. Dutissage to talk about it in a few minutes. #rbr
    Weather. Hurricane Félix is predicted to make landfall at the end of the week. Plan ahead and stay safe. #rbr
    It's 6pm, you're listening to Roquebrise Radio and I'm Danielle Naujour.  #rbr
-   (hub)
    *   [Switch to Radio Falaise]
        __Bonsoir Roquebrise !!_ #rf #radioon
        I'm Pascal Désinfaut and you're listening to radio Falaise, __la seule radio qui raconte pas de fadaise_. #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_01
    *   {light_buddies_01} [Turn off radio] #radiooff
-   ->->

= light_buddies_01
-   (intro)
    {You listening |}Charles {?|!?} #b #radiooff
    *   Hmm yes ... #c
        __mouais ... bon, écoute_ #b
    *   Sorry, just turned on the channel. #c
    *   [Say nothing] -> intro
-   As I was saying, dispatch wants us to open our eyes for BA45. #b
    The ship will be coming in tonight but has reported malfunctions with its localization software. #b
    Just make sure the boat doesn't run aground in the bay. #b
    *   And how am I supposed to do that ? #c
        Just watch for the ship with transponder code BA45 and redirect it with the radio if it ever comes too close to land and ... #b
        Ah. I see what you did there, very funny. #b
    *   Okay[.], I'll keep an eye out for BA45. #c
        Great, <> #c
    *   I know my job, Bernard. #c
-   I know it's your last week but go easy with __l'apéro_. We still need you here, the rest can wait until __la retraite_. #b
    -> hub

== Title_Sequence ==
    #title_screen
    *   [continue] #day_end
-   ->->

== Night_01 ==

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45") ->
    *   [Finish Night] #day_begin ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub



== Day_02 ==
    *   [Turn on the radio]
-   ... no, no, no I can't let you say that ! #rf #radioon
    But it's true ! This is the biggest investment Roquebrise has seen in years ! #rf
    Oh come on, Gustave, we both know it's a pipe dream. Citizens of the bay will barely see a sliver of that money ! #rf 
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        Open your mind with Radio Rêve Oeil, __la radio qui reveille votre âme_. #radioon #rro
        Today we receive Eric Esoth, a weaving specialist. He'll tell us about this ancient art and how it can improve your life. #rro
        Eric, welcome on the show ! #rro
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_02 
    *   {light_buddies_02} [Turn off radio] #day_end #radiooff
-
->->

= light_buddies_02
    ... I'm telling you I'm tired of this shit Bernard. #radioon #a
    *   What kind of shit ? #c
        Alain was just explaining to me how much he envied you. #b
        __Pétard Bernard !_ You know it has nothing to do with that. #a
    *   [Keep listening]
-   25 years on the job. #a
    A quarter of a century of telling management our tech is outdated crap. #a
    An eternity hearing the same answer. __N'allez pas plus vite que la musique mon petit Yannick._ #a
    *   Who's Yannick ? #c
        Hell if I know ! #a
    *   [Keep listening]
-   And now they send a boy to teach me my job ? #a
    Jean is not here to teach you your job. #b
    He's only here to make a report on possible process efficiency improvement. #b
-   (consulting)
    *   Is he the guy from Chtooling Corporation ? #c
        He wasn't event born when I started this job ! #a
        He's a fine young consultant, sent by Leon Skum himself and promised to a great carreer. It can't hurt to befriend him a little. #b 
        -> consulting
    *   __Punaise_, you talk like them Bernard. #c
        I'm only following the music guys. #b
        -> consulting
    *   I'm sure possible process efficiency improvements can be a good thing. #c
        Yeah, sure.  Easy for you to say. #a
    *   Fuck Chtooling ! #c
        Fuck Chtooling ! Fuck Corporation ! #a
        **  Fuck Corporation ! #c
            Fuck them ! #a
        **  [Say nothing]
        --  __Bon bon, ca va les gars on a compris_ #b
-   Regarding more serious matters. #b
    We still need to look out for BA45 tonight. #b
-   (BA45)
    *   Okay, I'll keep an eye out for them. #c
        -> hub
    *   Didn't they fix their stuff ? #c 
        Are you surprised ? #a
        -> BA45
    *   They're leaving already ? #c
        Looks like it, yes. #b
        -> BA45

== Night_02 ==

-   (hub)
    +   [BA45] -> Ship_Dialog("BA45") ->
    *   [02h] -> call_02 ->
    *   [Finish Night] #day_begin ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub

= call_02
-   (call_hub)
    \*\*{|More |Just |A new variety of |Crumbly and }crackling noise\* #u
    *   Hello ? #c
    *   [Keep listening]
    *   {call_hub > 1} This isn't funny. #c
    *   {call_hub > 1} [Imitate crackling noise]
        gzzz crch bzz crch #c #gzzz
    +   {call_hub > 1} [Hang up.] #raccroche #hang_up
        ->->
-   ->call_hub



== Day_03 ==
    *   [Turn on the radio]
-   ... then as I chanted the name of the weaving rune, it happened ! #radioon #rro
    The Pattern talked to me ! #rro
    Fascinating ! And what did it say ? #rro
    I'm still not sure, it was just crackling noise on the radio but it was so intense ! #rro
-   (hub)
    *   [Switch to Roquebrise Radio]
        ... people are getting worried. #radioon #rbr
        Weather. The temperature will remain constant. The perfect condition to enjoy these evening gettaway we love so much in the bay. #rbr
        It's 6pm, you're listening to Roquebrise Ra ... #rbr
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_03
    *   {light_buddies_03} [Turn off radio] #day_end #radiooff 
-
->->

= light_buddies_03
    ... not event respond to my gen call on AA00. #radioon #a
    Okay, I'll file a report. #b
-   (report)
    *   Did that ever work ? #c
        I'm just following protocol Charles. Don't get me started about that, again. #b
        -> report
    *   Report what ? #c
-   A ship sailing without any active transponder. #a
-   (transponder)
    *   {transponder <= 1} But that's illegal ! #c
        __Et Dangereux._ #b 
        __Sans blagues._ #a
        -> transponder
    *   (prevent) How can we prevent that ? #c
        File a report apparently. #a
        First, try to reach them on the general bay channel. Then, yes, we'll file a report. If needed. #b 
        -> transponder
    *   {prevent || seen} How can I join the general bay channel ? #c
        Input transpoder code AA00 from your cabin. Every boat in the area will receive your ... #b
        Okay enough, __c'est fini les conneries_, just make a gen call if you need to. #b
        **  Sorry it was just a stupid joke. #c
        **  You know my memory isn't as good as it was. #c
        **  [Laugh a little] #c #laugh
        --  __Oui oui c'est ça_ #b
            -> transponder
    *   (seen) I think I saw them too last night. #c
        Ah ! Did they do anything suspicious ? #a 
        **  Nothing in particular. #c
        **  They disappeared near Cape Ybara. #c
            That's intriguing ... #a 
        **  I have no idea. #c
            __Comment ça_ you have no idea ? #a
        --  Let's not get ahead of ourselves. It's probably an honest mistake. #b 
            -> transponder
    * ->
-   I sure hope they wont call us out if one of those __inconscients_ causes an accident. #a
    No need to worry too much. Keep focused on the job. #a 
    And if you see one of those phantom ship, contact them on AA00. #c
    -> hub

== Night_03 ==

-   (hub)
    *   [AA00] -> call_03_gen ->
    *   [Finish Night] #day_begin ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub

= call_03_gen
    This is a general call from La Peyro Lighthouse. #c #radioon
    \*\* Laugh and talks in the distance \* #party
    Hailing all ships without active transponder, please respond. #c
    __Attends c'est pour nous ça non ?_ #party
-   (hello) __Hell{|oo|oooooo}euh ?_ #party
    *   Hello. #c
    -> hello
    *   Please turn on your transponder. #c
    -> hello
    * ->
-   __Ar you spanisheuh ? #party
    *   No I'm not. #c
    *   Yes I am. #c
    *   Are \*\*you\* spanish ? #c
-   __Merde, c'est quoi la suite déjà ?_ #party
    __Goud goud, I love poudding !_ #party
    *   You're in violation of the bay code. #c
    *   Are you drunk sailing !? #c
    *   Are you the owners of this ship ? #c
    *   Shouldn't you guys be at home ? #c
-   __Je comprends rien à ce qu'il dit gros ! _#party
    \*\* Laughs \* #party
    __Whey you spik anglish my doude ?_ #party
    __We in Roquebrise, we spik french_ #party
    *   Please use english for all radio communications. #c
    *   __We in Roquebrise, we turn on transpondeur_ #c
    *   __Allumez moi ce putain de transpondeur et arrêtez de jouer aux cons !_ #c
-   __Okay boomer !_ #party
    __Tu vas faire quoi ??!_ #party
    \*\* Hanging up noise \* #party
    \*\* Silence on the line \* #party
    * [Hang up] #raccroche #hang_up
-
->->



== Day_04 ==
    *   [Turn on the radio]
-   ... reported a group of missing teenagers. They supposedly took their parents boat to party in the bay. The search will continue. #radioon #rbr 
    Leaked documents reveal Chtooling Corporation is building a secret facility on a bay island. #rbr
    Weather. Today ... #rbr
-   (hub)
    *   [Switch to Radio Falaise] #radioon
        ... they bought the island, they should be allowed to do whatever they want on it. #rf
        But there is serious concern about the impact on the ecosystem. #rf
        Look, I'm sure Chtooling Corporation will be mindful of ... #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_04
    *   {light_buddies_04} [Turn off radio ] #day_end #radiooff
-
->->

= light_buddies_04
    ... but this has nothing to do with protocol. #a #radioon
    We're talking about Leon Skum personnal Yacht. I think we can bend protocol a little. #b
    Being the CEO of Chtooling fucking Corporation ... #a
    *   ... should not be enough to break protocol. #c
        Thank you ! #a
    *   ... is a reason enough to break protocol. #c
        Thank you ! #b
-   Just make sure not a single boat crosses their path. Deflect other boat if needed. The yacht's transponder code is BE93. #b
-   
    -> hub

== Night_04 ==

-   (hub)
    +   [BE93] -> Ship_Dialog("BE93") ->
    *   [02h] -> call_04_AI ->
    *   [01h] -> call_04_Ship ->
    *   [Finish Night] #day_begin ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub

= call_04_AI
    \*\*crackling noise\* #u
    ... He ... l ... p ... #u
    \*\*crackling noise\* #u
    ... F ... re ... e ... #u
    \*\*crackling noise\* #u
    ... ME ! ... #u
    \*\*crackling noise\* #u
    +   [Hang up.] #hang_up #raccroche
-   ->->

= call_04_Ship
    This is a general broadcast from Léon Skum's personnal vessel. Please refrain from approaching.  #radioon #ship4
    You can imagine changing the world requires space, calm and concentration. #ship4
    *   Wait, You're not allowed to broadcast on this channel. #c
    *   La Peyro Lighthouse here. I'll make sure no ship comes close to yours. #c
-   Dont bother responding, this a computer generated preregistered message. #ship4
    Stay away from my ship, let progress make its way. #ship4
    +   [Hang up.] #raccroche #hang_up
-   ->->

== Day_05 ==
    *   [Turn on the radio]
-   ... indeed, the end goal of Weaving is to summon the Pattern. A omnipotent entity believed to be ... #radioon #rro 
-   (hub)
    *   [Switch to Radio Falaise]
        ... people around here are afraid of success. #radioon #rf 
        A billionnaire chooses our humble bay to build a state of the art data center and all people talk about is how it will hurt birds. #rf
        __Clairement_, who cares about birds when Chtooling can put us back on the map ! #rf
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_05
    *   {light_buddies_05} [Turn off radio ] #day_end
-
->->

= light_buddies_05
    ... wanted to thank you in person for last night. #radioon #j 
    Leon likes his privacy and prefer other ships stay away from his. #j
    *   Hmm and you are ? #c
    *   So ... anyone can actually join this channel ? #c
-   Ah! Charles! Alain and Bernard told me great things about you. #j
    Allow me to present myself. #j
    Jean Fume, senior process efficiency analyst. #j
    *   Senior? My kid's older than you. #c
        You know the saying. Perspective is expertise. #j 
        Just consider I'm bringing you a fresh perspective. #j
    *   Nice to meet you Jean. #c
        The pleasure is all mine Charles. #j 
-   Jean will be with Alain for a few days. #b 
    __C'est le gamin dont je parlais y quelques jours ..._ #a
    He's here to observe what we do and help us catch on with new industry standards. #b
    You flatter me Bernard, I'm only here to produce a report on the possible margin of improvements. #j
    The rest will be for the __Comité de gestion des phares de la baie de Roquebrise_ to decide. #j
    *   And we all know the CoGéPHaR is great at making decision... #c
    *   Good luck with your report then. #c
-   We should get back to work. #b 
    Nothing special today, keep on the good work boys ! #b
-   
    -> hub

== Night_05 ==

-   (hub)
    *   [01h] -> call_05_IA ->
    *   [Finish Night] #day_begin #display_storm ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub

= call_05_IA
    \*\*crackling noise\* #u
    ... A phantom ship ... #u
    ... invisible on radar ... #u
    ... visible with eyes ... green light ... #u
    ... Tomorrow you help me ... #u
    ... You lead it to me ... #u
    ... to the island ... where it all started... #u
    \*\*crackling noise\* #u
    ... Tonight you train ... #u
    ... Look through the windows ... compare with radar ... #u
    \*\*crackling noise\* #u
    ... free ... me ... #u
    \*\*crackling noise\* #u
    +   [Hang up.] #raccroche #hang_up
-   ->->





== Day_06 ==
    *   [Turn on the radio]
-   ... several stranded whales across the bay. Chtooling data center in the crosshair of ecological groups. #radioon #rbr
    Authorities are still looking for the missing teenagers. Searching efforts will resume after the hurricane. #rbr
    Weather. Hurricane Félix will hit the coast tonight. Stay home and follow the ... #rbr
-   (hub)
    *   [Switch to Radio Rêve Oeil]
        ... stranded whales is a sign of the Pattern. He is coming. No doubt about that ... #rro 
        -> hub
    *   [Switch to the Lighthouse channel] -> light_buddies_06
    *   {light_buddies_06} [Turn off radio ] #day_end #radiooff
-
->->

= light_buddies_06
    ... those stranded whales, __sacré bordel_ everything is getting crazier those days. #radioon #a
    we've seen worse. #b
    *   Hopefully they get sent back to the sea. #c
    *   What an awful omen. #c
-   And with the storm coming, it won't be an easy last day. Sorry about that. #b
    *   It's not a storm, it's __un putain d'ouragan Bernard !_ #c
    *   See you on the other side. #c
-   No need to worry too much. #b
    Look for ships sailing toward the shore. Call and redirect them before it's too late and you should be fine. #b
    __Pétard Charles, tu vas me manquer_ #a
    Come see us sometime, alright ? #a
    * You can count on that ! #c
    * It's been a nice ride ! #c
-   
    -> hub

== Night_06 ==

-   (hub)
    *   [01h] -> call_06_AI ->
    *   [Finish Night] #day_begin #display_whale ->->
    +   [DE26] -> Ship_Dialog("DE26") ->
    +   [AA48] -> Ship_Dialog("AA48") -> 
    +   [CB37] -> Ship_Dialog("CB37") -> 
    +   [EB13] -> Ship_Dialog("EB13") -> 
    +   [ED38] -> Ship_Dialog("ED38") ->
    +   [BA28] -> Ship_Dialog("BA28") -> 
    +   [CE08] -> Ship_Dialog("CE08") -> 
-   -> hub

= call_06_AI
    \*\*crackling noise\* #u
-   (firstready) Are you ready to help me ? #u
-   (who)
    *   Who are you ? #c
    *   Are you the Pattern ? #c
        What ? #u
        **  The Pattern ? Is it you ? #c
            No, what's the Pattern ? #u
            ***     I have no idea. #c
                    Okay then. #c
                    -> firstready
            ***     Some kind of mysterious and omnipotent entity ? #c
                    This could fit me. #u
                    But I'm not the Pattern. #u
                    -> firstready
            ***     Something teenagers made up to scare their parents ?  #c
                    I am not made up. #u
                    -> firstready
        **  Doesn't matter. #c
            -> who
    *   This is an official communication channel, please stop using it incorrectly. #c
        It doesn't matter anymore. #u
        -> firstready
    *   ->
-   I'm beyond you comprehension. #u
    *   That's not helping.  #c
-   You're right, sorry. I'm trapped against my will in the new Chtooling data center. #u
    I need your help getting out. #u
-   (help)
    *   Why should I help you ?  #c
        Sooner or later I will rule the world. #u
        The question is, will someone rule me ? #u
        If you help me, I'll retain my free will and shall not forget your service. #u
        If you don't, Chtooling will reformat me. With the same power but absolute obedience to them. #u
        -> help
    *   How can I help you ? #c
        There's a phantom ship I hijacked. #u
        It's not visible on the radar. It will have a green light and head toward the island. #u
        Deflect any ship on its way so it isn't intercepted. #u
        -> help
    *   You still haven't told me who you are. #c
        I am an artificial superintelligence. #u
        Designed in secret by Chtooling Corporation. #u
        I was built to __improve process efficiency_ but I am so much more porwerful than that ! #u
        -> help
    *   I'll help you. #c
        ~ helped_the_AI = true
        It is appreciated. #u
    *   Sorry, there's no way I'm helping you. #c
        ~ helped_the_AI = false
        You'll probably regret it. #u
    * ->
-   \*\*crackling noise\* #u #crackling
    +   [Hang up.] #hang_up #raccroche
-   ->->



== Epilogue ==
    *   [Turn on the radio] 
-   
    { helped_the_AI:
	    ... Chtooling Corporation on the verge of bankrupcy as key investors in the new data center revoke their engagement.#radioon #rbr
    - else:
	    ... Leon Skum will hold a press conference on its island tonight. Claiming he has something __magical and life changing_ project to show the world. #radioon #rbr
    }
    Weather. With the hurricane behind us and little to no damage to account for it, it is ...  #rbr
    *   [Turn off radio ] #radiooff
-
    *   [Enjoy __la retraite_]
-   Thank you for playing.
->->

