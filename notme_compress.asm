; ; NOT ME, 2024                                            ;

SETMODE             EQU BC0Eh       ;Initialisation du vecteur pour set  MODE
BORDER              EQU BC38h       ; Initialisation du BORDER
PAPER               EQU BB96h
INITWINDOW          EQU BB66h
CLEARWINDOW         EQU BB6Ch
DEFCOLOR            EQU BC32h
LOCATECURSOR        EQU 0xBB75 
PRINTCHR            EQU 0xBB5A       ;Initialisation du vecteur PRINT ECRAN
CLS1                EQU 0xBC14       ;Effacement de l'écran
AJOUTSONQUEUE       EQU BCAAh
ADDVIDTOKENP1       EQU C5FAh
ADDVIDTOKENP2       EQU C61Ah
ADDQUITTER          EQU 2018h
ADDPRINTLETTER      EQU 9601h
ADDTAMPONDECOMPRESS EQU 6E90h
ADDRETURNCHR        Equ C12Eh
CLEARKEY            EQU BB03h   
SWAPWINDOWS         EQU BBB7h
INITADDRESSWORD     EQU 0419h
WORDSNUMBER         EQU 0xF2
USEPEN              EQU BB90h
E_AIGU              EQU 7Bh  
E_GRAVE             EQU 7Dh
COPYRIGHT           EQU A4h  
ADDENDSCREEN        EQU C280h
TEMPO_01            EQU FFh
TEMPO_02            EQU 96h
TEMPO_03            EQU 20h
COLONNE1CHR         EQU 0Bh

; TODO :

; SNAPINIT '../Data/basic11.sna' ; la mémoire de Rasm est initialisée avec le snapshot
; BUILDSNA
; SNASET GA_ROMCFG,%1100 ; pour être sûr de démarrer dans la mémoire, on les désactive du snapshot au cas où
; BANKSET 0 ; assembler dans les premiers 64K
; RUN #100 ; pour dire à quelle adresse le snapshot doit démarrer
BUILDCPR


ORG 4000h
debut_programme
start:
preMain:
    CALL InitStream0
    ; Load history
    CALL SetColorHistoryScreen  ; Chargement de la palette de couleur
    ;Start changement de stylo
    LD A,1                  ; Set 1 dans A
    CALL USEPEN             ; On utilise le stylo 1
    ; End changement de stylo
    LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h01              ; HL pointe le début de laphrase                        
    CALL BOUCLE             ; Routine affichage de la phrase                                          ; Fin du programme
    LD B, 0x0A              ; Definition du compteur de Tempo
    CALL Tempo              ; Appel de routine Tempo
    LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h05              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Definition du compteur de Tempo
    CALL Tempo              ; Appel de routine Tempo
    LD HL, 0x0203           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h10              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Definition du compteur de Tempo
    CALL Tempo              ; Appel de routine Tempo
    LD HL, 0x0204           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h15              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Definition du compteur de Tempo
    CALL Tempo              ; Appel de routine Tempo
    ; Start changement de stylo
    LD A,2
    CALL USEPEN             ; On utilise le stylo 2
    ; End changement de stylo
    LD HL, 0x0107           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h20              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase    
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x0208           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h22              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x0209           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h25              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x020A           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h27              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    ; Start changement de stylo
    LD A,3
    CALL USEPEN             ; On utilise le stylo 3
    ; End changement de stylo
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x010D           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h30              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x020E           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h32              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x020F           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h35              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x0210           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h40              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x0113           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h45              ; HL pointe le début de phrase                        
    CALL BOUCLE             ; Routine affichage de la phrase
    LD B, 0x0A              ; Valeur de la tempo
    CALL Tempo              ; Appel de la routine Tempo
    LD HL, 0x0A14           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, h50              ; HL pointe le début de phrase                        
    CALL BOUCLE
    ;  Affichage bouton NEXT
    LD A, 3
    LD (couleurFondNEXT), A ; Set PAPER du bouton NEXT
    LD A, 1
    LD (couleurPenNEXT), A  ; Set PEN du bouton NEXT
    LD HL, 0x0D16           ; Position X,Y debut
    LD DE, 0x2519           ; Position X, Y fin
    CALL ShowButtonNExt     ; Appel de la routine "affichager bouton NEXT"
    ; Bip si suite
    CALL 0xBCA7             ; Initialisation du son
    LD HL,SON               ; Load adreese SON
    CALL AJOUTSONQUEUE             ; Ajout SON dans la queue sonore
main:                       ; Boucle principale du jeu 
    CALL InitStream0          
   choosePlayerNumber:
        LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, nbrPlayerStr     ; HL pointe le début de phrase                        
        CALL BOUCLE             ; Routine affichage de la phrase
       choosePlayerKeyDetection:
            CALL AttenteTouche          ; Attente touche 
            Oneplayer:                  ; Capture du nom du premier joueur    
                CP 0x31                 ; Test si 1 est appuyé
                JR Z, storePlayers      ; Si oui go to storPlayer
                CP 0x26                 ; Test si & est appuyé
                JR Z, preStorePlayer1   ; Si oui goto preStorePlayer1
            Twoplayers:                 ; Capture du nom du deuxième joueur
                CP 0x32                 ; Test if key 2 is pressed
                JR Z, storePlayers      ; Si oui goto storPlayers
                CP 0x7B                 ; Test si { est appuyé
                JR Z, preStorePlayer2   ; Si oui preStorePlayer2
                JR choosePlayerKeyDetection ; Si aucunes des touches est présseés retour au début de la boucle
            preStorePlayer1:
                LD A, 0x31          ; Stockage du caractère 1 (1 joueur) au cas ou & à été appuyé
                JR storeplayers     
            preStorePlayer2:
                LD A, 0x32          ; Stockage du caractère 2 (2 joueur) au cas ou { à été appuyé
            storeplayers:
            LD (playersNumber),A        ; Sauvegarde du nombre de joueurs dans "playersNumber"
            PUSH AF                     ; Sauvegarde AF à partir de la pile. A = nombre de joueurs
            LD HL, 0x2002               ; Set de la position en XY de la phrase                                                           
            CALL LOCATECURSOR           ; LOCATE du curseur        
            ; Start changement de stylo
            LD A,3
            CALL USEPEN             ; On utilise le stylo 3
            ; End changement de stylo
            POP AF                      ; Sauvegarde du nombre de joueurs dans playerNumber
            CALL PRINTCHR               ; Affichage du nombre de joueur (1 or 2) 
            ; Beguin Name of players
            debugrecupchr:
                ; Start changement de stylo
                LD A,1
                CALL USEPEN             ; On utilise le stylo 3
                ; End changement de stylo
                LD HL, 0x0204           ; Set de la position en XY de la phrase                                                           
                CALL LOCATECURSOR       ; LOCATE du curseur                                                      
                LD HL, namePlayer       ; Load Adress sentence "Entrez votre pseudo, fin avec ENTER"
                CALL BOUCLE   
                LD HL, ReturnCHR          ; Affichage du sprite sur le joueur 1
                LD DE, ADDRETURNCHR
                CALL boucleAff
                LD HL, 0x0205           ; Set de la position en XY de la phrase                                                           
                CALL LOCATECURSOR       ; LOCATE du curseur                                                      
                LD HL, backSpace       ; Load Adress sentence "Entrez votre pseudo, fin avec ENTER"
                CALL BOUCLE   
                LD IX, player1          ; Load adress of player name
                LD HL, 0x020A           ; Set de la position en XY du nom du player 1                                                          
                CALL LOCATECURSOR       ; LOCATE du curseur  
                LD HL, player1Temp
                CALL BOUCLE
                LD HL, deuxpoints       ; Load Adress sentence "Entrez votre pseudo, fin avec ENTER"
                CALL BOUCLE   
                preDebugCHR:
                    LD A, 3
                    CALL USEPEN
                    CALL AttenteTouche      ; Test if a key is pressed
                    CP 0x7F                 ; Compare with 0
                    CALL Z, DeleteCHR   ; If Key is 0, end player 1 and go to player 2
                    JR Z, preDebugCHR
                    CP 0x0D
                    JR Z, goToNamePlayer2   ; Compare with Enter
                    LD (IX), A              ; set The key to adress IX, Name player 1
                    INC IX
                    CALL PRINTCHR           ; Display CHR in screen (1 or 2) 
                    LD DE, SON1
                    CALL PlaySound          ; DE = Adresse du son
                    JR preDebugCHR
                    goToNamePlayer2:
                        LD A, 1
                        CALL USEPEN
                        LD (IX), 0
                        ;Test si 1 joueur
                        LD A, (playersNumber)
                        CP 0x31
                        CALL Z, ChangeNamePlayer2
                        ;JP Z, wordChoose
                        JP Z, quiVacommencer
                        LD HL, 0x020C           ; Set de la position en XY du nom du player 1                                                          
                        CALL LOCATECURSOR       ; LOCATE du curseur  
                        LD HL, player2Temp
                        CALL BOUCLE
                        LD HL, deuxpoints       ; Load Adress sentence "Entrez votre pseudo, fin avec ENTER"
                        CALL BOUCLE
                        LD IX, player2
                        namePlayer2:
                            LD A, 3
                            CALL USEPEN
                            CALL AttenteTouche      ; Test if a key is pressed
                            CP 0x7F                 ; Compare with 0
                            CALL Z, DeleteCHR   ; If Key is 0, end player 1 and go to player 2
                            JR Z, namePlayer2
                            CP 0x0D
                            JR Z, endNamePlayer     ; Compare with Enter
                            LD (IX), A              ; set The key to adress IX, Name player 1
                            INC IX
                            CALL PRINTCHR
                            LD DE, SON1
                            CALL PlaySound          ; DE = Adresse du son  
                            JR namePlayer2
                            endNamePlayer:
                                LD (IX), 0
    quiVacommencer:
        LD A, (playersNumber)       ; Load Nombre de joueurs dans A
        CP 0x32                     ; Test si 2
        JP Z, quiRandomLoop         ; Si Oui saut vers quiRandomLoop
        LD (playerWhoBeguin), A     ; Si Non playerWhoBeguin = 0x31
        JP wordChoose               ; Si Non pas de tirage au sort
        quiRandomLoop:          ; Choose number for determine word to play
            CALL random                 ; 
            OR A                        ;
            JR Z, quiRandomLoop         ; 
            CP 0x31                     ;
            JR Z, exitQuiRandomLoop     ;
            CP 0x32                     ;
            JR NZ, quiRandomLoop        ;
            exitQuiRandomLoop:
                LD (playerWhoBeguin), A ;
                LD HL, 0x020E           ; Set de la position en XY de la phrase                                                           
                CALL LOCATECURSOR       ; LOCATE du curseur                                                      
                LD HL, quiVacommencerstr; HL pointe le début de phrase                        
                CALL BOUCLE
                LD B, TEMPO_02
                CALL tempo
                LD HL, 0x020F           ; Set de la position en XY de la phrase                                                           
                CALL LOCATECURSOR       ; LOCATE du curseur                                                      
                LD HL, tirageAuSort     ; HL pointe le début de phrase                        
                CALL BOUCLE
                LD B, TEMPO_02
                CALL tempo
                LD A, 0x2E
                CALL PRINTCHR
                LD DE, TIC
                CALL PlaySound          ; DE = Adresse du son  
                LD B, TEMPO_01
                CALL tempo
                LD A, 0x2E
                CALL PRINTCHR
                LD DE, TIC
                CALL PlaySound          ; DE = Adresse du son 
                LD B, TEMPO_01
                CALL tempo
                LD A, 0x2E
                CALL PRINTCHR
                LD DE, TIC
                CALL PlaySound          ; DE = Adresse du son 
                LD HL, 0x0A12           ; Set de la position en XY de la phrase                                                           
                CALL LOCATECURSOR       ; LOCATE du curseur          
                LD A, 0x50              ; Lettre P
                CALL PRINTCHR
                LD B,TEMPO_03
                CALL tempo
                LD HL, 0x0C12
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, 0x41
                CALL PRINTCHR
                LD B, TEMPO_03
                CALL tempo
                LD HL, 0x0E12
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, 0x45
                CALL PRINTCHR
                LD B, TEMPO_03
                CALL tempo
                LD HL, 0x0D12
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, 0x59
                CALL PRINTCHR
                LD B, TEMPO_03
                CALL tempo
                LD HL, 0x0F12
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, 0x52
                CALL PRINTCHR
                LD B, TEMPO_03
                CALL tempo
                LD HL, 0x0B12
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, 0x4C
                CALL PRINTCHR
                LD B, TEMPO_03
                CALL tempo
                LD HL, 0x1212
                CALL LOCATECURSOR       ; LOCATE du curseur        
                LD A, (playerWhoBeguin)
                CALL PRINTCHR
                LD B, TEMPO_01
                CALL tempo
                ;  Affichage bouton NEXT
                LD A, 3
                LD (couleurFondNEXT), A
                LD A, 1
                LD (couleurPenNEXT), A
                LD HL, 0x0D16
                LD DE, 0x2519
                CALL ShowButtonNExt
    wordChoose:
        CALL InitStream0
        randomLoop: ; Choose number for determine word to play
            CALL random             ; 
            OR A
            JR Z, randomLoop        ; 
            CP WORDSNUMBER
            JR NC, randomLoop
        storeWordAdress:            ; With word number, determine word adress
            LD HL,firstWord         ; Load adress of first word
            LD B, A                 ; Load word number
            PUSH HL
            loopStoreWordAdress:    ; For each word
                LD A, (HL)
                INC HL
                OR A
                JR NZ, loopStoreWordAdress
                POP IX
                PUSH HL
                DJNZ loopStoreWordAdress:       ; Until B = 0, INC adress word (in foction of len word)
                POP HL
                LD (tempAdressWord), HL
                LD DE,  0x0419                    ; Adresse X et Y du premier tiret
    printWordTiret:
        LD A,(HL)           ; Load la lettre du mot
        OR A                ; Est-ce que c'est un zéro ?
        JR Z, next          ; Si oui goto next
        PUSH HL             ; Sauvegarde HL sur la pile
        ; Calcul len Word
        LD A,(lenWord)      ; Load lenWord dans A (longueur du mot)
        INC A               ; Ajout de 1 sur la longueur du mot
        LD (lenWord),A      ; Sauvegarde de la nouvelle valeur dans lenWord
        ; End Calcul len Word
        ; Draw Tiret
        PUSH DE
        LD HL, DE           ;                                                        
        CALL LOCATECURSOR       ; LOCATE du curseur  
        LD A, 0xD2
        CALL PRINTCHR 
        ; End Draw Tiret
        POP DE
        INC D
        INC D
        POP HL
        INC HL
        JR printWordTiret
    next:
        drawBackground:
            LD IX, background00     ; Adress for rec01 table
            CALL DrawRect           ; Draw rect
            LD IX, background01     ; Adress for rec01 table
            CALL DrawRect           ; Draw rect
            LD IX, background02     ; Adress for rec01 table
            CALL DrawRect           ; Draw rect
            LD IX, background03     ; Adress for rec01 table
            CALL DrawRect 
            LD IX, rope01     ; Adress for rec01 table
            CALL DrawRect
            ; Test if One or two players in game 
            ; If 2, draw rope02
            LD A, (playersNumber)
            CP 0x32
            JR NZ, nextDrawBackground
            LD A, 2
            CALL 0xBB90 
            LD IX, rope02     ; Adress for rec01 table
            CALL DrawRect
            nextDrawBackground:
                ; Show player 1 name 
                LD HL, 0x0516           ; Set de la position en XY du nom du player 1                                                          
                CALL LOCATECURSOR       ; LOCATE du curseur  
                LD HL, player1
                CALL BOUCLE
                ;Show player 2 name
                LD HL, 0x01616           ; Set de la position en XY du nom du player 1                                                          
                CALL LOCATECURSOR       ; LOCATE du curseur  
                LD HL, player2
                CALL BOUCLE
                affichageToken:
                ; Affichager du token
                LD A, (playerWhoBeguin)     ; Load numéro du joueur qui commence
                CP 0x31                     ; Comparaison avec 31 (1)
                JR Z, suiteBackground       ; Si oui, saut vers suiteBackground
                LD HL, tokenSprite          ; Si non affichage du sprite sur le joueur 2
                LD DE, ADDVIDTOKENP2
                CALL boucleAff
                CALL ChangeActivePlayer     ; et on change le player actif car joueur 1 par défaut
                JR suiteCrossedOut          ; Saut vers suiteCrossedOut
                suiteBackground:
                LD HL, tokenSprite          ; Affichage du sprite sur le joueur 1
                LD DE, ADDVIDTOKENP1
                CALL boucleAff
                suiteCrossedOut:
                ; player 2 crossed out if one player chooses
                LD A, (playersNumber)
                CP 0x31
                CALL Z, CrossedPlayer
                ; Affichage help espace
                LD HL, 0x0508           ; Colonne, Ligne début de la fenêtre           
                LD DE, 0x260A           ; Colonne, Ligne fin de la fenêtre
                CALL ShowButtonHelp
                ; Effacement de la fentre
                LD HL, 0x0508           ; Colonne, Ligne début de la fenêtre           
                LD DE, 0x260A 
                LD A, 0x0
                CALL 0xBC44
                ; Changement de stream
                LD HL, 0x0000
                LD DE, 0x2818
                CALL INITWINDOW
                LD A, 0
                CALL 0xBB96 
    initVariables:                      ; Init variables
        LD HL, penduPlayer1Tete         ; Load adresse of pendu player 1 head
        LD (player1OffsetPendu), HL     ; Save Offset(HL) in player1OffsetPendu variable
        LD (player2OffsetPendu), HL     ; Save Offset(HL) in player2OffsetPendu variable
        LD HL, ADDPRINTLETTER           ; Load adress of first tiret (letter to find)
        LD (tempPrintLetter), HL        ; Save adress of first tiret in tempPrintLetter variable
        LD HL, ADDENDSCREEN
        LD (debut_ligne), HL
        LD (ligne_courante), HL
    mainLoop:
        CALL AttenteTouche              ; Test if a key is pressed
        mainLoopDebug:
            PUSH AF
            LD (lastLetterChooseCHR), A     ; Store the letter chosen by player
            POP AF
            ; Start convert letter in maj
            CP 0x5B                         ; Test if A > 4A
            JR C, nextLoop                  ; if yes go to nextLoop
            ADD -0x20                       ; if no sub 20 to A (for have maj letter)
            LD (lastLetterChooseCHR), A
            ; End convert letter in maj
        nextLoop:
            CALL ShowLettersPlayerChoice        ; Detect if letter is in word and show it if so 
            CALL ShowLettersPlayer              ; Draw letter in the right screen (in white if not in word or green if so)
            ; Detect if player letter was in word
            CALL LetterWasInWord
            CALL PlayerLost                     ; The routine LetterWasInWord return 0 (player loose) or 1 (player not loose) in reg A
            OR A                                ; CP 0
            JR Z, Exit
            CALL PlayerWin
            OR A                                ; CP 0
            JR Z, Exit
            ; Start : If one player in game goto mainLoopNext
            LD A, (playersNumber)
            CP 0x31
            JR Z,  mainloopNext
            ; End
            ; Start : If letter choosen was in word, no change player
            LD A, (detectedWordTemp)
            CP 1
            JR Z,  mainloopNext
            ; End
            CALL ChangeTokenPlayer              ; Change token to another player
            CALL ChangeActivePlayer             ; Change active player
        mainloopNext: 
            JP mainLoop
    Exit:
        CALL InitStream0
        LD A,1                  ; Paramètre pour le choix du PEN
        CALL USEPEN             ; Utilisation du PEN 2
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end01            ; HL pointe le début de phrase "Voulez-vous rejouer une partie (O/N) ?"                       
        CALL BOUCLE             ; Routine affichage de la phrase
        chooseYesOrNoLoop:
            CALL AttenteTouche
            ; Si une touche est préssée
            CP 0x4F                 ; Comparaison avec "O"
            JP Z, suite             ; If "O" goto "ExitOK"
            CP 0x6F                 ; Comparaison avec "o"
            JP Z, suite             ; If "o" goto "ExitOK"
            CP 0x4E                 ; Comparaison avec "N"
            JR Z, exitOK            ; If "N", goto "suite"
            CP 0x6E                 ; Comparaison avec "n"
            JR Z, exitOK            ; If "n", goto "suite"
            JP  chooseYesOrNoLoop   ; If not O and not N goto start loop
    suite:  ; init de toutes les variables pour recommencer le jeu clean
        LD A, 0x36
        LD (player1Score), A
        LD (player2Score), A
        LD HL, 0x0
        LD (player1OffsetPendu), HL
        LD (player2OffsetPendu), HL
        LD (tempPrintLetter), HL
        LD A, 1
        LD (activePlayer), A
        LD A, 0
        LD (detectedWord), A
        LD HL, 0x21C3
        LD (tempAdressWord), HL
        LD HL, 0x2101
        LD (adressLetterChoice), HL
        LD A, 1
        LD (reboot), A
        LD A, 0
        LD (player1Leg), A
        LD (player2Leg), A
        LD (lenWord), A
        JP main    ; Goto main to start a new game
    exitOK:
        CALL InitStream1        ; Initialisation de la fenetre
        LD A,0                  ; Paramètre pour le choix du PEN
        CALL USEPEN             ; Utilisation du PEN 2
        LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end02            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD A, 2
        CALL USEPEN
        LD HL, 0x0103           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03            ; Load Adress sentence "Conversion du jeu HECTOR NotMe!"
        CALL BOUCLE 
        LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03.5          ; Load Adress sentence "pour AMSTRAD"
        CALL BOUCLE 
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03.1          ; Load Adress sentence "De la GamJam du 10/2024:"
        CALL BOUCLE 
        LD HL, 0x0106           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end04            ; Load Adress sentence "Retro Programmers United For Obscurs Systemes"
        CALL BOUCLE 
        LD HL, 0x0108           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end06            ; Load Adress sentence "Code assembleur : DarkSteph"
        CALL BOUCLE 
        LD A, 3
        CALL USEPEN
        LD HL, 0x010C           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end08            ; Load Adress sentence "Special thanks"
        CALL BOUCLE 
        LD HL, 0x010D           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end08.5            ; Load Adress sentence "Special thanks"
        CALL BOUCLE 
        LD HL, 0x010E           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end09            ; Load Adress sentence "BDCIron, CheshireCat, Redbug, ricolaoz, "
        CALL BOUCLE                                                   
        LD HL, end10            ; Load Adress sentence "Roudoudou, DeadSystem, LordHeavy, gurneyh et Ayor61"
        CALL BOUCLE  
        LD A, 2
        CALL USEPEN
        LD HL, 0x0112           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end07            ; Load Adress sentence "A bientot"
        CALL BOUCLE 
        LD A, 0
        CALL USEPEN
        LD HL, 0x1514           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end11            ; Load Adress sentence "A bientot"
        CALL BOUCLE 
fin:
CALL AttenteTouche      ; Attente touche
RET
routines:
    INCLUDE "./routines.asm"
decompress:
    INCLUDE "./lz48decrunch_v006b.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  DATA                                   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imageFinBadCompress:
    INCL48 './Data/ecranFinBad.bin'
imageFinWinCompress:
    INCL48 './Data/ecranFinWin.bin'
histoire:
    h01:    db "Ann", E_AIGU, "e 1473, les temps sont durs.",0
    h05:    db "Le maire de la ville d'Hectorland",0
    h10:    db "vous a trouv", E_AIGU, " chez lui, dans son lit.",0
    h15:    db "Et pas tout seul, avec sa femme.",0
    h20:    db "Ni une, ni deux, ni trois d'ailleurs,", 0
    h22:    db "Vous voila arret", E_AIGU, " pour etre pendu.", 0
    h25:    db "Et oui,",0
    h27:    db "pas touche a la femme du Maire!", 0 
    h30:    db "Vous voici au bout d'une corde,",0
    h32:    db "avec un compagnon d'infortune.",0
    h35:    db "Le premier qui trouvera",0
    h40:    db "la bonne r", E_AIGU, "ponse aura la vie sauve.",0
    h45:    db "Bonne chance,",0
    h50:    db "telle est la vie en 1473.",0
myRandomNumber:         db 0x0
reboot                  db 0x0
playersNumber:          db 0x0
playerWhoBeguin         db 0x1
player1Score:           db 0x36
player2Score:           db 0x36
player1OffsetPendu:     dw 0x0
player2OffsetPendu:     dw 0x0
player1Leg:             db 0x0  ; 0 = left leg, 1 = right
player2Leg:             db 0x0  ; 0 = left leg, 1 = right
activePlayer:           db 0x01
detectedWord:           db 0x0
detectedWordTemp:       db 0x0
tempAdressWord:         dw 0x21C3
tempPrintLetter:        dw 0x0
adressLetterChoice:     dw 0x2101
lastLetterChooseCHR:    db 0x0
couleurFondNEXT         db 0x0
couleurPenNEXT          db 0x0
; textToScroll db "A"
lenWord:        db  0x0
lettersFound    db 0x0
pressKeyStr:    db "Appuyez sur une touche",0
player1:        db "xxxxxxxxxxxxxxx", 0
player2:        db "yyyyyyyyyyyyyyy", 0
player1Temp:    db "Player 1", 0
player2Temp:    db "Player 2", 0
player1Lost01:  db ", tu as perdu...", 0
player1Win01:   db ", tu as gagn", E_AIGU, ", je te lib",E_GRAVE,"re...", 0
player1Win02:   db "Mais ne t'approche plus de ma femme.", 0
Player1Win03:   db "Bourreau, ex",E_AIGU,"cutez",0
Player1Win04:   db "MAINTENANT!!!!!",0
player2Win01:   db ", tu as gagn",E_AIGU,", je te lib",E_GRAVE,"re...", 0
player2Win02:   db "Ne t'avise plus a me voler", 0
Player2Win03:   db "Bourreau, ex",E_AIGU,"cutez ",0
Player2Win04:   db "MAINTENANT !!!!!",0
end01:          db "Voulez-vous rejouer une partie (O/N) ?",0
end02:          db "Merci d'avoir jou", E_AIGU, ".", 0
end03           db "Conversion du jeu HECTOR NotMe!", 0
end03.5:        db "pour AMSTRAD",0
end03.1:        db "De la GamJam du 10/2024:", 0
end04:          db "Retro Programmers United For Obscurs Systemes", 0
end06:          db "Code assembleur : DarkSteph", 0
end07:          db "A bientot", 0
end08:          db "Special thanks", 0
end08.5:        db  "(pour m'avoir bien aid",E_AIGU," sur le code) :", 0
end09:          db "BDCIron, CheshireCat, Redbug, ricolaoz, ", 0
end10:          db "Roudoudou, DeadSystem, LordHeavy, gurneyh et Ayor61", 0
end11:          db COPYRIGHT, " DarkSteph 2025", 0
namePlayer      db "Entrez votre pseudo, fin avec ", 0
backSpace       db "Correction possible avec DEL", 0
deuxpoints      db  ":",0
nbrPlayerStr:   db "Nombre de joueur(s) (1 ou 2):", 0
quiVacommencerstr: db "Qui va commencer ?", 0
tirageAuSort    db "Tirage au sort en cours ", 0
help            db "L'ESPACE peut etre un caratere !", 0
point          db  0x2E
;A=color mask, H = left column, L = upper line, D=Right column, E=bottom line
background00:       db 0xF, 0x0, 0x0, 0x1, 0x19
background01:       db 0xF, 0x0, 0x0, 0x2, 0xC
background02:       db 0xF, 0x3, 0x1, 0xA, 0x1
background03:       db 0xF, 0x3, 0x2, 0x1B, 0x2
rope01:             db 0xFF, 0xA, 0x3, 0xA, 0x3
rope02:             db 0xFF, 0x1A, 0x3, 0x1A, 0x3
penduPlayer1Tete:   db 0, 0xF0, 0x09, 0x04, 0x0B, 0x06
penduPlayer1Tronc:  db 0, 0xF0, 0xA, 0x5, 0xA, 0xB 
penduPlayer1BrasGauche: db 0, 0xF0, 0x7, 0x8, 0x9, 0x8 
enduPlayer1BrasDroite:  db 0, 0xF0, 0xB, 0x8, 0xD, 0x8 
penduPlayerLeftLeg:     db  1, 0xF0, 0xA, 0xC, 0xA, 0xC
penduPlayerRightLeg:    db  1, 0xF0, 0xA, 0xC, 0xA, 0xC
tokenMaskPlayer:        db 0x00, 0x5, 0x13, 0x5, 0x13
tokenSprite:            db 0x6, 0x6, 0x6, 0x6, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x7, 0xE, 0x3, 0xC, 0x1, 0x8
CrossPlayer:            db 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
ReturnCHR:              DB 0x00, 0x06, 0x00, 0x06, 0x02, 0x06, 0x06, 0x06, 0x0F, 0x0E, 0x0F, 0x0E, 0x06, 0x00, 0x02, 0x00
randData:               db 230
debut_ligne     dw 0x0000
fin_ligne       db 0x0
ligne_courante  dw 0x0000
SON:    DB 1 ;canal
        DB 2 ;env
        DB 3 ;ent
        DW 470 ;fréquence
        DB 0 ;bruit
        DB 60 ;volume
        DW 100 ;durée
SON1:    DB 129 ;canal
        DB 3 ;env
        DB 30 ;ent
        DW 478 ;fréquence
        DB 0 ;bruit
        DB 60 ;volume
        DW 10 ;durée
SON2:   DB 129 ;canal
        DB 15 ;env
        DB 0 ;ent
        DW 511 ;fréquence
        DB 1 ;bruit
        DB 60 ;volume
        DW 20 ;durée
SON3:   DB 129 ;canal
        DB 0 ;env
        DB 0 ;ent
        DW 143 ;fréquence
        DB 0 ;bruit
        DB 60 ;volume
        DW 30 ;durée
TIC:   DB 129 ;canal
        DB 15 ;env
        DB 0 ;ent
        DW 20 ;fréquence
        DB 0 ;bruit
        DB 60 ;volume
        DW 10 ;durée
ORG 9870h
firstWord:
    INCLUDE "./Data/words.asm"
ENDDATA:
fin_programme
SAVE 'notme.bin',debut_programme, fin_programme - debut_programme, DSK, 'notme.dsk'