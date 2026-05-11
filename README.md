
Ceci est un document résumant notre expérience avec avantages et inconvénients, et parle aussi de ce qui peut nous avoir plu dans d'autres jeux sur lesquels nous aimerions prendre exemple.



### Equipe

   * Félix
   * Damien
   * David
   * Edouard
   * Marie-Andréa
   * puis plus tard: Cyril, Alexis
### Idées proposées

   * jeu de gestion de phare
   * jeu de platformer avec un robot à controler à distance avec du lag permettant de créer plusieurs robots lorsque le lag est résolu (cf serveurs online multijoueurs)
   * jeu d'exploration de planètes en mode In other waters
   * jeu de battles médiévaux où on doit envoyer les bons signaux à faire pour que notre armée prenne de bonnes positions
### Idée choisie

   * Idée du phare, jeu narratif alternant phases de jour et phase de nuit en mode un peu plus gameplay.
   * **Décision :** faire une vue spéciale pour la nuit en mode première personne -> **après la ludum peut être que ça n'était pas une si bonne idée vu le taff en plus que ça a demandé: plus d'assets graphiques + synchronisation des bateaux dans un espace 3d alors que le jeu est en 2d.**
### Musique

   * La musique est très réussie (comme presque à chaque fois ?), et cette ludum particulièrement les bruitages sont biens et nombreux, c'est vraiment plaisant (même dans les dialogues etc.) 
### Graphisme

   * Recherche graphique avec Damien pour les couleurs et l'ambiance de jour: ça a plutôt bien marché permet de se renouveller
   * Choix de ne pas faire de pixel art: on itère plus vite et on peut donner des styles différents mais par contre on ne peut pas vraiment faire d'animation
   * Faire des premiers assets rapidement pour voir le jeu puis refaire, c'est ce qui avait été fait pour the weaver, c'est long et un peu chiant mais assez utile pour voir le jeu avancé et se faire une idée. 
   * Faire les graphismes pour deux vues différentes, avec en plus du jour / nuit donc des palettes différentes c'est assez dur de garder une vraie cohérence visuelle, peut être à l'avenir garder un truc plus simple, une seule vue ? Là où c'était vraimetn dur c'était pour la rotation des bateaux en fonction de l'angle de vue dans la vue 3D.
   * Faire des shaders dont on maitrise les implications : j'ai jamais réussi à intégrer correctement mes POC de shaders de vagues (pourtant c'était joli). J'aurais pu aider sur autre chose j'y ai bien passé 10-15H. A côté la radio c'était facile. 
### Gameplay

   * C'est clairement l'histoire qui fait tenir tout le jeu, niveau gameplay c'est assez pauvre, malgré quelques défis techniques plutôt réussis (mini map 2D avec pathfinding, vue 1ère personne). Mais ça fait que le "mood" et l'immersion sont réussis, accentués par la musique et les bruitages très réussis et bien intégrés.
   * Je prône toujours l'idée de partir d'un gameplay **existant** (ou un mix entre 2 gameplays) et de caler par dessus l'idée du jeu (avec si possible avec un twist sur le gameplay). Ca permet à minima d'espérer avoir un gameplay intéressant (sans toutefois le garantir).
   * => Pour palier à **beaucoup **de nos problèmes habituels, je propose la chose suivante : on créé à l'avance des templates de jeux Godot. Des prototypes sans vrai gameplay, sans concept innovant, sans graphismes travaillés et sans musique/son. Ils serviront de point de départ. Une fois l'idée propre à la ludum trouvée, on prend le prototype qui s'en rapproche le plus et on peut dès le début itérer sur le gameplay, sans avoir même besoin de graphismes ou autres. C'est les 1-2 jours qui nous tuent à chaque fois. Changer de gameplay à chaque ludum n'aide pas non plus.


### Organisation générale

### Résultat

### Jeux inspirants

### Choses dont on aimerait se souvenir ?

   * Réussir à restreindre plus le scope, à chaque on se dit qu'on le réduit mais c'est rarement assez, avoir un scope simple ne veut pas forcément dire avoir un jeu basique.  cf. mon point Gameplay
   * Réussir à accélérer plus la création d'un proto, essayer de cibler tôt dans la ludum ce qui doit être mis en place comme minimum syndical pour commencer à tester le jeu cf. mon point Gameplay
   * Implémenter un jeu narratif avec le moteur ink c'est pas gratuit, y a plein de branchements à faire qui ne sont pas forcément triviaux
   * => A voir si y'a pas une solution plus native à Godot et/ou à créer notre propre système ? J'ai l'impression que même bien intégré ça bride souvent les possibilités ou faut des hacks (sans compter les bugs)
   * Ecrire une histoire en un weekend c'est fastidieux: Damien était un peu épuisé de l'écriture à la fin 
   * => Peut être qu'il faudrait moins centrer le jeu sur l'histoire (donc pas de "jeu narratif") mais plutôt faire comme la plupart des jeux et donc produire moins de dialogues ? Même si je comprends l'envie de faire des embranchements etc. Pas vraiment de solution à ça, c'est un choix en début de ludum.
   * Garder une connexion entre gameplay et graphisme. Le mini-jeu qui consistait à guider les bateaux se passait au final majoritairement dans le radar alors que la vue depuis le phare a demandé bien plus de travail. Au final un joueur lambda un peu perdu ne regarde quasiment que le radar.
   * Se forcer à simuler le gameplay pourrait peut-être permettre de voir plus rapidement qu'un jeu va être nul. Quand j'ai testé pour la première fois de guider un bateau avec la radio, ça m'a paru super nul de suite. C'est long et chiant. Juste pour changer la direction on devait cliquer une fois sur la radio, passer des dialogues, choisir une direction avec du texte, cliquer pour passer le dialogue. Le problème c'est que j'ai découvert ça dimanche soir parce que je ne me suis pas posé la question avant, ou plutôt que j'espérais que ça allait juste bien fonctionner de base. Le gameplay ne doit pas être la poussière qu'on met sous le tapis : une idée sans gameplay concret ou testable rapidement devrait être rejetée à mon avis.
   * Penser la map pour le gameplay. Quand on guide les bateaux on se retrouve à faire des lignes droites sur une map ronde, ce qui fait que les chemins ne sont jamais faciles, toujours un peu foireux. si y'a du level design, il faut un prototype assez tôt sinon oui on passe à côté et c'est trop tard pour corriger oui
   * Un jeu narratif ne veut pas dire qu'on peut juste ignorer le gameplay pendant 80% de la ludum.
   * Un jeu narratif sans fin bien travaillée donne l'impression que toute l'histoire disparaît d'un coup. Ce qui est dommage vu le travail fourni.
   * J'aime faire du pathfinding mais on est là pour faire un jeu. Il faut mettre le gameplay avant les défis/délires de code personnel.
   * Le pathfinding est toujours plus compliqué que prévu dans des environnements dynamiques et au final n'est pas assez parfait en quelques jours pour vraiment permettre toutes les interactions imaginées au début.
   * Vu le résultat final, le pathfinding semblait totalement overkill oui. C'est facile à dire après coup mais selon moi ça aurait pu se faire ainsi :
   * 1) les bateaux suivent des paths/scénarios prédéfinis : scope réduit par rapport à des idées que vous auriez eues liés à des déplacements dynamiques
   * 2) fin de la ludum (pas eu le temps de faire le pathfiding)
   * Au final on a fait le 1) mais avec du pathfinding (et encore fallait mettre point de départ, d'arrivée et des fois point de passage quand même).
   * Même si la leçon est peut être déjà "apprise" pour du pathfiding, il faudrait la généraliser pour tout concept avancé (comme tu dis "défis/délires").
   * Mélanger Ink et gameplay est compliqué vu que les actions du gameplay doivent être écrites au lieu de laisser la liberté au code. J'ai trouvé ça très limitant au moment de vouloir voir si on pouvait améliorer le gameplay. L'erreur ici c'est d'avoir eu un tunnel vision de ma part sur le pathfinding au lieu d'avoir focalisé sur le jeu même. Heureusement que MA a fait tout le reste sinon on n'avait rien.
   * Il faut mettre en place dès le début un système qui permet de jouer l'histoire depuis n'importe quel point, ou au moins depuis un chapitre. Devoir lancer le jeu depuis le début à chaque fois fait que personne ne teste vraiment la totalité, ou alors cette personne perd un temps fou à le faire. Ink c'est bien mais il faut qu'on maîtrise mieux l'intégration. cf. ce que j'ai dit au dessus, si on veut remettre la narration dans un prochain jeu faut anticiper et trouver en amont un système qui nous convient pour la programmation et pour Godot.
   * C'est dommage de faire un jeu auquel on ne joue pas au final. Deja parce qu'on connais l'histoire après avoir débuggé le jeu, et aussi parce qu'il est raté. Et en 3 jours impossible de faire une histoire assez complexe pour avoir envie de la joueur plusieurs fois, meme si je le jeux est réussi..
   * Ca me choque pas, les jeux à histoire c'est souvent ça. Là le problème c'est que sans l'histoire y'a pas de jeu, c'est pas tant que l'histoire ne soit pas assez complexe.
