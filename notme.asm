; ; NOT ME, 2024                                            ;

SETMODE             EQU #BC0E       ;Initialisation du vecteur pour set  MODE
BORDER              EQU #BC38       ; Initialisation du BORDER
PAPER               EQU #BB96
INITWINDOW          EQU #BB66
DEFCOLOR            EQU #BC32
LOCATECURSOR        EQU 0xBB75 
PRINTCHR            EQU 0xBB5A       ;Initialisation du vecteur PRINT ECRAN
CLS1                EQU 0xBC14       ;Effacement de l'écran
ADDVIDTOKENP1       EQU C5FAh
ADDVIDTOKENP2       EQU C61Ah
ADDQUITTER          EQU 2018h
ADDPRINTLETTER      EQU 9601h
CLEARKEY            EQU BB03h   
SWAPWINDOWS         EQU BBB7h
INITADDRESSWORD     EQU 0419h
WORDSNUMBER         EQU 0x26
USEPEN              EQU BB90h
E_AIGU              EQU 7Bh  
E_GRAVE             EQU 7Dh
A_ACCENT            EQU 60h   
ADDENDSCREEN        EQU C280h
TEMPO_01            EQU FFh
TEMPO_02            EQU 96h
TEMPO_03            EQU 20h

; TODO : Bug sur comptage lettre retantes si double lettre dans le mot

; SNAPINIT '../Data/basic11.sna' ; la mémoire de Rasm est initialisée avec le snapshot
; BUILDSNA
; SNASET GA_ROMCFG,%1100 ; pour être sûr de démarrer dans la mémoire, on les désactive du snapshot au cas où
; BANKSET 0 ; assembler dans les premiers 64K
; RUN #100 ; pour dire à quelle adresse le snapshot doit démarrer

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
    LD HL, 0x0D16
    LD DE, 0x2519
    CALL ShowButtonNExt
main:                       ; Boucle principale du jeu 
    CALL InitStream0          
   choosePlayerNumber:
        LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, nbrPlayerStr     ; HL pointe le début de phrase                        
        CALL BOUCLE             ; Routine affichage de la phrase
        LD A, 0x0D              ; Load OD dans A (:)
        CALL PRINTCHR           ; Affichage du caractère
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
            LD (playersNumber),A
            PUSH AF                 
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
                    CP 0x30                 ; Compare with 0
                    JR Z, goToNamePlayer2   ; If Key is 0, end player 1 and go to player 2
                    CP 0x0D
                    JR Z, goToNamePlayer2   ; Compare with Enter
                    LD (IX), A              ; set The key to adress IX, Name player 1
                    INC IX
                    CALL PRINTCHR           ; Display CHR in screen (1 or 2) 
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
                            CP 0x30                 ; Compare with 0
                            JR Z, endNamePlayer     ; If Key is 0, end player 1 and go to player 2
                            CP 0x0D
                            JR Z, endNamePlayer     ; Compare with Enter
                            LD (IX), A              ; set The key to adress IX, Name player 1
                            INC IX
                            CALL PRINTCHR  
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
                LD B, TEMPO_01
                CALL tempo
                LD A, 0x2E
                CALL PRINTCHR
                LD B, TEMPO_01
                CALL tempo
                LD A, 0x2E
                CALL PRINTCHR
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
        LD A,(HL)
        OR A                ; le chiffre 0 en hexa : 48
        JR Z, next
        PUSH HL             ; Save Add word on stack
        ; Calcul len Word
        LD A,(lenWord)
        INC A               ; Add 1 to len word
        LD (lenWord),A
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
    suite:  ; init all the variables
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
        CALL CLS1               ; Clear screen                ; Clear screen
        CALL SetColorEndScreenBad   ; Chargement de la palette    
        LD A,1                  ; Paramètre pour le choix du PEN
        CALL USEPEN             ; Utilisation du PEN 2
        LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end02            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD A, 2
        CALL USEPEN
        LD HL, 0x0103           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03.5          ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end03.1          ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD HL, 0x0106           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end04            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD HL, 0x0108           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end06            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD A, 3
        CALL USEPEN
        LD HL, 0x010C           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end08            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
        LD HL, 0x010E           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end09            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE                                                   
        LD HL, end10            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE  
        LD A, 2
        CALL USEPEN
        LD HL, 0x0112           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, end07            ; Load Adress sentence "Merci d'avoir joué."
        CALL BOUCLE 
fin:
CALL AttenteTouche      ; Attente touche
RET

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;  Game Routines                          ;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;INCLUDE "./routines.asm"
;INCLUDE "./PlayerAkg.asm"
VBL:     
    LD B,#F5         ; Attente de synchro verticale
    IN A,(C)                    
    RRA                          
    JR NC, VBL 
    RET
BOUCLE:
    LD A, (HL)     ;A <- caractère pointé pas HL.
    OR A           ;A <- A OU A (détection de 0)
    RET Z          ;retour de programme si A = 0
    CALL PRINTCHR     ;vecteur d’affichage d’un caractère
    INC HL         ;HL pointe le caractère suivant
    JR BOUCLE      ;revient à BOUCLE
    RET
InitStream0:
;HL = 1ere colonne, 1ere ligne, DE = Dernière colonne, Dernière ligne
; Init window, Set colors, CLS and Set PAPER
    LD HL, 0x0000
    LD DE, 0x2818
    CALL INITWINDOW
    CALL SetColorHistoryScreen  ; Chargelment de la palette de couleur
    CALL CLS1  
    LD A, 0
    CALL 0xBB96 
    RET
AttenteTouche:
    CALL 0xBB1B             ; Attente l'appui sur une touche
    RET C
    JR AttenteTouche
Tempo:
    start_tempo:
        PUSH BC             ; Save du compteur sur la pile
        CALL VBL            ; Call VLB
        POP BC              ; Load du compteur dans BC
        DJNZ start_tempo
        RET
SetColorHistoryScreen:
    LD DE, 0x0000       ; INK 0,0       STYLO 0 noir (00)
    CALL SetPen
    LD DE, 0x0119       ; INK 1,25      STYLO 1 Jaune (25)
    CALL SetPen
    LD DE, 0x0209       ; INK 2,15      STYLO 2 vert foncé (09)
    CALL SetPen         
    LD DE, 0x0305       ; INK 3,5       STYLO 3 Bleu Violet (05)
    CALL SetPen  
    RET
SetColorEndScreenBAd:
    LD DE, 0x0000       ; INK 0,0       STYLO 0 noir (00)
    CALL SetPen
    LD DE, 0x0105       ; INK 1,5       STYLO 1 Bleu (05)
    CALL SetPen
    LD DE, 0x021A       ; INK 2,26      STYLO 2  Blanc (26)
    CALL SetPen         
    LD DE, 0x0319       ; INK 3,25      STYLO 3 Jaune (11)
    CALL SetPen  
    RET
SetColorEndScreenWin:
    LD DE, 0x0000       ; INK 0,0       STYLO 0 noir (00)
    CALL SetPen
    LD DE, 0x0105       ; INK 1,5      STYLO 1 Bleu (05)
    CALL SetPen
    LD DE, 0x0319       ; INK 2,25      STYLO 2 Jaune (25)
    CALL SetPen         
    LD DE, 0x0206       ; INK 3,6       STYLO 3 Rouge (06)
    CALL SetPen  
    RET
SetPen:                 ; D = PEN; E = Color
    LD A,E
    LD B,A
    LD C,A
    LD A,D
    CALL 0xBC32         ; Set des stylos
    RET
SetPaletteMode1:
    ; HL contient l'adresse de la table des couleurs
    ; La routine va boucler 4 fois pour set les couleurs sur les 4 stylos
    LD A, 0     ; Compteur pour le stylo
    loopSetPaletteMode1:
        PUSH AF         ; Sauvegarde du compteur sur la pile
        LD A, (HL)
        LD B, A
        LD C, A
        POP AF
        PUSH AF
        PUSH HL
        CALL 0xBC32
        POP HL
        INC HL
        POP AF
        CP 3
        INC A
        JR NZ, loopSetPaletteMode1
    RET
drawRect:
    LD A, (IX+1)
    LD H, A
    LD A, (IX+2)
    LD L, A
    LD A, (IX+3)
    LD D, A
    LD A, (IX+4)
    LD E, A
    LD A, (IX+0)
    CALL 0xBC44
    CALL VBL
    RET
;Boucle d'affichage du sprite pour 8x8 pixels
boucleAffAttente:
; A = Nombre de lignes
; B = Nombre octet par ligne
    INC B
    loopBoucleAffAttente:
        PUSH AF     ; Sauv compteur Lignes
        PUSH BC     ; Sauv compteur Octets
        loopLDI:
            LDI
            PUSH AF, BC, DE, HL
            CALL VBL
            POP HL, DE, BC, AF
            LD A, B     ; LD compteur Octet dans A
            OR A        ; A = 0 ?
            DEC A       ; decrement de A
            LD B, A
            JR NZ, loopLDI
        POP BC
        POP AF
        ; Dernièrere ligne ?
        CP 0
        RET Z
        ; non ? on continu
        DEC A   ; Décrement A (nombre de lignes)
        PUSH AF
        PUSH BC
        DEC B
        loopDEC:
            DEC DE
            LD A, B     ; LD compteur Octet dans A
            DEC A       ; decrement de A
            OR A        ; A = 0 ?
            LD B, A
            JR NZ, loopDEC
        POP BC
        POP AF
        PUSH HL
        PUSH DE
        POP HL
        LD DE, 0x800
        ADD HL, DE
        PUSH HL
        POP DE
        POP HL
        JR NZ, loopBoucleAffAttente
        RET

boucleAff:
    LD A, 8
    loopBoucleAff:
        LDI
        LDI
        DEC DE
        DEC DE
        PUSH HL
        PUSH DE
        POP HL
        LD DE, 0x800
        ADD HL, DE
        PUSH HL
        POP DE
        POP HL
        DEC A
        OR A
        JR NZ, loopBoucleAff
        RET
boucleScreen:
    REPEAT 15
    CALL affich_8       ; Affiche 8 lignes de 80 octets
    CALL VBL
    CALL ajout_50       ; Change de blob de 8 lignes
    REND
    ;CALL ajout_800     ; Change de ligne
    CALL affich_8
    RET
affich_8:   ; Affiche 8 lignes sur l'écran
    LD A, 0             ; compteur de boucle
    loopAffich_8:
        PUSH AF                 ; Sauvegarde A sur la pile
        LD BC, 80               ; BC = longueur en octet à afficher
        LDIR                    ; Copie des données sur l'écran
        postLDIR:
        CALL ajout_800          ; Ajout 800 pour passer à la ligne suivant
        POP AF                  ; Chargement A (compteur) à partir de la pile
        INC A                   ; Incrément A
        CP 8                    ; Compteur = 7 ?
        JR NZ, LoopAffich_8     ; Si oui goto finLoopAffich_8
        RET
ajout_50:   ; Ajout 50 pour changer de bloc de 8 lignes
    PUSH HL             
    LD HL, (debut_ligne)
    LD BC, 0x0050
    ADD HL,BC
    LD (debut_ligne), HL
    LD (ligne_courante), HL
    PUSH HL
    POP DE
    POP HL
    RET
ajout_800:   ; Ajout 800 pour passer à la ligne suivante
    PUSH HL
    LD HL, (ligne_courante)
    LD BC, 0x800
    ADD HL,BC
    LD (ligne_courante), HL
    PUSH HL
    POP DE
    POP HL
    RET
Random:  ; Routine de tirage d'un chiffre compris entre 0 et RandData
    PUSH HL
    PUSH DE
    LD HL,(RandData)
    LD A,R
    LD D,A
    LD E,(HL)
    ADD HL,DE
    ADD A,L
    XOR H
    LD (RandData),HL
    POP DE
    POP HL
    LD (myRandomNumber), A
    RET
CrossedPlayer:
    LD HL, CrossedPlayer
    LD DE, 0xDEB8
    REPEAT 19
    LDI
    REND
    RET
ShowLettersPlayerChoice:            ; Draw the letter instead of the dash of the word 
    LD IX, (tempAdressWord)         ; Load IX adress of the word
    LD DE, INITADDRESSWORD          ; Load DE destination adress on screen
    PUSH AF                         ; Save A = key pressed on the stack
    LD A, 0                         ; Init detectedWord
    LD (detectedWord), A            ; Init detectedWord
    LD A,3
    CALL 0xBB90 
    POP AF                          ; Load in A, key pressed to the stack
    beguinShowLettersPlayerChoice:
        PUSH AF                     ; Sauvegarde A (touche préssée) sur la pile
        ; Détection de la fin du mot (0)
        LD A, (IX+0)                 
        OR A                                ; Test si la lettre est 0
        JP Z, endShowLettersPlayerChoice    ; Si oui goto  endShowLettersPlayerChoice
        ; End detect end of word
        POP AF                      ; Load dans A, touche préssée à partir de la pile    
        CP (ix+0)                   ; Test if letter chosen is the same as letter word
        PUSH AF                     ; Save AF (A is the key pressed) on stack
        PUSH DE                     ; Save XY destination on stack
        JR NZ, increaseLetter       ; If no goto increase letter
    showLetter:
        LD HL, DE                   ; Set de la position en XY de la phrase                                                           
        PUSH AF
        CALL LOCATECURSOR           ; LOCATE du curseur                                 
        POP AF
        CALL PRINTCHR               ; PRINTCHR, print letter word instead of "tiret" 
        ; Update lenWord, each letter found = lenWord -1
        LD A, (lenWord)
        SUB 1
        LD (lenWord), A
        ; End update
        ; Change DetectedWord
        LD A, 1
        LD (detectedWord), A
    increaseLetter:
        POP DE
        POP AF
        INC IX
        INC D, D
        JP beguinShowLettersPlayerChoice:
    endShowLettersPlayerChoice:
        POP AF
        RET
ShowLettersPlayer:
    ; Show any letters on screen choosen by players
    ; in WHITE if letter is in word
    ; in RED if letter is not in word
    PUSH AF, BC, DE         ; Save registres to Stack
    LD A, (detectedWord)    ; Load detectedWord 0=not find, 1=find
    CP 0                    ; Compare with 0
    JR Z, showletternotfind ; If 0, go to showletternotfind
    LD A,1
    CALL 0xBB90             ; Use PEN 0   
    JR showLettersPlayerNext           
    showletternotfind:      
        LD A,2
        CALL 0xBB90                 ; ON UTILISE LE SYLO 2
    showLettersPlayerNext:          ; Draw letter on screen
        LD HL, (adressLetterChoice)
        PUSH HL
        CALL LOCATECURSOR 
        LD A, (lastLetterChooseCHR)     ; Put C (CHR value) to C (param)
        CALL PRINTCHR               ; PRINTCHR, print letter word instead of "tiret"
        POP HL
        INC L
        LD (adressLetterChoice), HL
        POP DE, BC, AF
        RET       
ChangeActivePlayer:      
    ; Routine for change active player           
    LD A, (activePlayer)    ; Load active player
    CP 1                    ; Compare with 1
    JR NZ, player2to1       ; If no, active player is player 2, go to player2to1
    ; Active player is player 1
    INC A                   ; Increase A (A=1 to 2)
    LD (activePlayer), A    ; Store A in activePlayer variable
    RET                     ; End routine
    player2to1:                 
        DEC A                   ; Decrease A (A=2 to 1)
        LD (activePlayer), A    ; Store A in activePlayer variable       
        RET                 ; End routine                 
ChangeTokenPlayer:
    ; Change sprite token to another player
    ; Player 1 to Player 2 or Player 2 to Player 1
    LD A, (activePlayer)        ; Load active player value
    CP 1                        ; Compare with 1
    JR Z, toPlayer2             ; If not, goto player 2
    toPlayer1:                  ; If yes, player active is Player 1
        LD IX, tokenMaskPlayer
        LD (IX+1), 0x15
        LD (IX+3), 0x15
        CALL DrawRect
        LD HL, tokenSprite
        LD DE, ADDVIDTOKENP1
        CALL boucleAff
        CALL VBL
        RET
    toPlayer2:
        LD IX, tokenMaskPlayer
        LD (IX+1), 0x5
        LD (IX+3), 0x5
        CALL DrawRect
        LD HL, tokenSprite
        LD DE, ADDVIDTOKENP2
        CALL boucleAff
        CALL VBL
        RET
LetterWasInWord:
    LD A, (detectedWord)
    LD (detectedWordTemp), A
    OR A
    JR Z, noLetterInWord
    LD A, 0
    LD (detectedWord), A    ; Reinit detectedWord 0
    RET NZ
    noletterInWord:
        LD A, (activePlayer)
        CALL DecreaseScorePlayer
        CALL PrintPendu
    RET
DecreaseScorePlayer:        ; Reg A = Active Player  
    CP 1                    ; Detect player active
    JR Z, nextDecreaseScorePlayer
    LD A, (player2Score)
    DEC A
    LD (player2Score), A
    RET
    nextDecreaseScorePlayer:
        LD A, (player1Score)
        DEC A
        LD (player1Score), A
    RET
PrintPendu:
    LD A, (activePlayer)            ; Load in A the active player (1 or 2)
    CP 1                            ; Compare with 1
    JR NZ, printPenduPlayer2        ; If no, goto to printPenduPlayer2
    ; test leg start
    LD BC,(player1OffsetPendu)      ; Load l'adresse de la partie du pendu a afficher
    LD A,(BC)                       ; Load premier octet du tableau
    CP 1                            ; Si 1 alors c'est une jambe à afficher
    CALL Z, DrawLeg                 ; Go to drawLeg fonction
    ; Test callback Drawleg function. If 1 ret, however continu
    CP 1
    RET Z
    ; Test leg end
    ; Start Maj address player1OffsetPendu
    LD BC, (player1OffsetPendu)     ; Load adress of offsetPendu
    INC BC                          ; INC address for escape octet 1 (leg or not leg)
    LD (player1OffsetPendu), BC     ; Save address of offsetPendui
    ; End Maj address player1OffsetPendu
    LD IX, BC
    ixdebug:
    CALL drawRect ; Draw rect          ; Draw on screen
    LD HL, (player1OffsetPendu)     ; Add for arrive on next thing of pendu
    INC HL, HL, HL, HL, HL
    LD (player1OffsetPendu), HL
    RET
    printPenduPlayer2:
        ; test leg start
        LD BC,(player2OffsetPendu)      ; Load l'adresse de la partie du pendu a afficher
        LD A,(BC)                       ; Load premier octet du tableau
        CP 1                            ; Si 1 alors c'est une jambe à afficher
        CALL Z, DrawLeg                 ; Go to drawLeg fonction
        ; Test callback Drawleg function. If 1 ret, however continu
        CP 1
        RET Z
        ; Test leg end
        ; Start Maj address player2OffsetPendu
        LD BC,(player2OffsetPendu)
        INC BC                          ; INC address for escape octet 1 (leg or not leg)
        LD (player2OffsetPendu), BC         ; Save address of offsetPendui
        ; End Maj address player1OffsetPendu
        LD IX, BC
        LD A, (IX+1)
        ADD 0x10
        LD (IX+1), A
        LD A, (IX+3)
        ADD 0x10
        LD (IX+3), A
        CALL drawRect          ; Draw on screen
        LD A, (IX+1)
        ADD -0x10
        LD (IX+1), A
        LD A, (IX+3)
        ADD -0x10
        LD (IX+3), A
        INC IX, IX, IX, IX, IX
        LD (player2OffsetPendu), IX
        RET
DrawLeg:
    ; Determine if left leg or right leg
    LD A, (activePlayer)            ; Load activePlayer (1 or 2)
    CP 1                            ; Compare with 1
    JR Z, determinePlayer1Leg       ; If so, jump to detereminePlayer1Leg
    ; If not, determinePlayer2leg
    LD A, (player2Leg)              ; Load player2Leg (0 = left leg, 1 = right leg)
    OR A                            ; Compare with 0
    CALL Z, DrawLeftLeg             ; If yes call DrawLefLeg
    CP 2                            ; Test the calback of DrawLefLeg function
    JR Z, endLeg                    ; If yes, jump to endLeg
    CALL DrawRightLeg               ; If no, call DrawrightLeg
    CP 2                            ; CallBack DrawRightLeg 2 = OK, go to end
    JR Z, endLeg                    ; jump to endLeg
    determinePlayer1Leg:
        LD A, (player1Leg)          ; Load player1Leg (0 = left leg, 1 = right leg)
        CP 0                        ; Compare with 0
        CALL Z, DrawLeftLeg         ; If yes call DrawLefLeg
        CP 2                        ; Test the calback of DrawLefLeg function
        JR Z, endLeg                ; If yes, jump to endLeg
        CALL DrawRightLeg            ; If no, call DrawrightLeg
    endLeg:
    LD A,1
    RET
DrawLeftLeg:
    ; Draw the leg from one square that shifts 7 times
    LD B, 0x4       ; Set counter value
    LD A, (activePlayer)
    CP 1
    JR Z, drawLeftLegLoop
    LD IX, penduPlayerLeftLeg
    INC IX
    LD A, (IX+1)
    ADD 0x10
    LD (IX+1), A
    LD A, (IX+3)
    ADD 0x10
    LD (IX+3), A
    drawLeftLegLoop:
        PUSH BC                 ; Save compteur on the stack
        LD BC, penduPlayerLeftleg   ; Load adrees of penduPlayerLeg
        INC BC                  ; INC address to escape octet 1 (leg or not leg)
        ;PUSH BC                 ; Save BC on stack befor CALL 0D5D
        LD IX, BC
        CALL DrawRect              ; Draw on screen
        debug001:
        ;POP IX                  ; Load IX (adress of penduPlayerLeg) with stack
        LD A, (IX+1)            ; Load in A the value of Y coordinate of penduPlayerLeg
        SUB 1                   ; Add 4 
        LD (IX+1), A            ; Save new value of Y coordinate
        LD (IX+3), A
        LD A, (IX+2)            ; Load in A the value of X coordinate of penduPlayerLeg
        ADD 1                   ; Sub 2 
        LD (IX+2), A            ; Save new value of X coordinate
        LD (IX+4), A            
        POP BC                  ; Load in BC the value of counter form stack
        DJNZ drawLeftLegLoop        ; Loop
        finloop:
        ; At the end of loop
        LD IX, penduPlayerLeftLeg   ; Load in IX the adress of penduPlayerLeg
        LD (IX+2), 0xA         ; Set the Y value to initial
        LD (IX+4), 0xA         ; Set the Y value to initialLD (IX+5), 0x4C         ; Set the X value to initial
        LD (IX+3), 0xC         ; Set the Y value to initial
        LD (IX+5), 0xC         ; Set the Y value to initialLD A, 1                 ; Set A to 1 -> return of function
        setLeg:
            ; Set leftleg to 1 (next will be rightLeg)
            LD A,(activePlayer)
            CP 1
            JR Z, setLegPlayer1
            LD A, 1
            LD (player2Leg), A
            LD A, 2
            RET
            setLegPlayer1:
                LD A, 1
                LD (player1Leg), A
                LD A, 2
                RET
DrawRightLeg:
    ; Draw the leg from one square that shifts 7 times
    LD B, 0x4       ; Set counter value
    LD A, (activePlayer)
    CP 1
    JR Z, drawRightLegLoop
    LD IX, penduPlayerRightLeg
    LD A, (IX+2)
    ADD 0x10
    LD (IX+2), A
    LD A, (IX+4)
    ADD 0x10
    LD (IX+4), A
    drawRightLegLoop:
        PUSH BC                     ; Save compteur on the stack
        LD BC, penduPlayerRightleg  ; Load adrees of penduPlayerLeg
        INC BC                      ; INC address to escape octet 1 (leg or not leg)
        LD IX, BC
        CALL DrawRect              ; Draw on screen
        CALL VBL                ; Attente VBL pour affichage
        debug002:
        LD A, (IX+1)            ; Load in A the value of Y coordinate of penduPlayerLeg
        ADD 1                   ; Add 4 
        LD (IX+1), A            ; Save new value of Y coordinate
        LD (IX+3), A
        LD A, (IX+2)            ; Load in A the value of X coordinate of penduPlayerLeg
        ADD 1                   ; Sub 2 
        LD (IX+2), A            ; Save new value of X coordinate
        LD (IX+4), A
        POP BC                  ; Load in BC the value of counter form stack
        DJNZ drawRightLegLoop        ; Loop
        ; At the end of loop
        LD IX, penduPlayerRightLeg   ; Load in IX the adress of penduPlayerLeg
        INC IX
        LD (IX+1), 0xA         ; Set the Y value to initial
        LD (IX+3), 0xA         ; Set the Y value to initialLD (IX+5), 0x4C         ; Set the X value to initial
        LD (IX+2), 0xC         ; Set the Y value to initial
        LD (IX+4), 0xC         ; Set the Y value to initial
        LD A, 2                 ; Set A to 1 -> return of function
    RET
PlayerWin:
    LD A, (lenWord)         ; Load lenword (each letter found = -1 lenword)
    CP 0                    ; Compare to 0
    RET NZ                  ; if yes, RET
    LD HL, 0x0908
    LD DE, 0x200A
    CALL ShowButtonNExt
    CALL CLS1
    LD A, (activePlayer)
    CP 1
    JR Z, playerWinEndPlayer1
    CALL EndPlayer1
    LD A, 0
    RET
    playerWinEndPlayer1:
        CALL EndPlayer2
        LD A, 0
        RET
PlayerLost:
    LD HL, player1Score     ; Adress player 1 score
    LD A, (activePlayer)    ; Detect active player
    CP 1                    ; if player 1
    JR Z, nextPlayerLost    ; next
    INC HL                  ; if player 2, increase adresse score (player 2)
    nextPlayerLost:
        LD A,(HL)
        CP 0x30
        JR Z,endPlayerLost
        LD A, 1                 ; Player not lost
        RET
        endPlayerLost:
            CALL ShowWordifLostOrWin
            CALL CLS1
            ; test if one player, if so go to enPlayer2Lost
            LD A, (playersNumber)
            CP 0x31
            LD A, 0
            CALL Z, OnePlayerLost
            CP 1
            JR Z, finEndPlayer
            LD A, (activePlayer)
            CP 1
            JR NZ, endPlayer2Lost   ; If player 1 loose, player 2 win
            CALL EndPlayer1
            JR finEndPlayer
            endPlayer2Lost:         ; If player 2 loose, player 1 win
                CALL EndPlayer2
    finEndPlayer:
    LD A,0
    RET
OnePlayerLost:
        CALL InitStream0
        CALL SetColorEndScreenBad   ; 
        LD A,3                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1          ; HL pointe le début de phrase "Player 1"                      
        CALL BOUCLE             ; Routine affichage de la phrase
        LD A,2                  ; On va utiliser le PEN 2
        CALL USEPEN             ; On utilise le stylo 2                                                    
        LD HL, player1Lost01    ; HL pointe le début de phrase "Tu as perdu..."           
        CALL BOUCLE             ; Routine affichage de la phrase
        LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player2Win03     ; HL pointe le début de phrase "Bourreau, exécutez"                     
        CALL BOUCLE             ; Routine affichage de la phrase
        LD A,3                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, 0x1404           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1          ; HL pointe le début de phrase "Player 1"                      
        CALL BOUCLE             ; Routine affichage de la phrase
        LD A,2                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, Player2Win04     ; HL pointe le début de phrase "MAINTENANT !!!!!"                      
        CALL BOUCLE             ; Routine affichage de la phrase
        ;Show end screen
        LD HL, imageFinBad     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD (debut_ligne), DE
        CALL boucleScreen
        ; Affichage bouton NEXT
        LD HL, 0x0D16           ; Coin supérieur gauche du cadre
        LD DE, 0x2519           ; Coin inférieur droit du cadre
        CALL ShowButtonNExt
        LD A, 1
        RET
EndPlayer1:
    CALL InitStream0
    CALL SetColorEndScreenBad  ; Chargement de la palette  
    LD A,3                  ; Paramètre pour le choix du PEN
    CALL USEPEN             ; Utilisation du PEN 2
    LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player1          ; HL pointe le début de phrase  "player 1"                      
    CALL BOUCLE             ; Routine affichage de la phrase 
    LD A,2                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3                                                       
    LD HL, player1Lost01    ; HL pointe le début de phrase ", tu as perdu..."                     
    CALL BOUCLE             ; Routine affichage de la phrase
    LD A,3                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3
    LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player2          ; HL pointe le début de phrase "Player 2"                       
    CALL BOUCLE             ; Routine affichage de la phrase   
    LD A,2                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3                                                 
    LD HL, player2Win01     ; HL pointe le début de phrase "Tu as gagné, je te libère..."                       
    CALL BOUCLE             ; Routine affichage de la phrase
    LD HL, 0x0106           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player2Win02     ; HL pointe le début de phrase "Ne t'avise plus a me voler"                     
    CALL BOUCLE             ; Routine affichage de la phrase
    LD HL, 0x0107           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player2Win03     ; HL pointe le début de phrase "Bourreau, exécutez"                      
    CALL BOUCLE             ; Routine affichage de la phrase   
    LD A,3                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3                        
    LD HL, player1          ; HL pointe le début de phrase "Player 1"                   
    CALL BOUCLE             ; Routine affichage de la phrase
    ; Show end screen
    LD HL, imageFinBad       ; Pointeur vers les données de l'image       
    LD DE,ADDENDSCREEN       ; Adresse mémoire vidéo de départ
    LD (debut_ligne), DE
    CALL boucleScreen
    ; Affichage bouton NEXT
    LD HL, 0x0D16           ; Coin supérieur gauche du cadre
    LD DE, 0x2519           ; Coin inférieur droit du cadre
    CALL ShowButtonNExt         
    LD A, 0                 ; Player 1 lost
    RET
EndPlayer2:
    CALL InitStream0
    CALL SetColorEndScreenBad  ; Chargement de la palette    
    LD A, (playersNumber)
    CP 0x31
    JR Z, nextEndPlayer2
    LD A,3                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3
    LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player2          ; HL pointe le début de phrase "player 2"                      
    CALL BOUCLE  
    LD A,2                  ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3                                                      
    LD HL, player1Lost01    ; HL pointe le début de phrase  "Tu as perdu..."                      
    CALL BOUCLE     
    nextEndPlayer2:
        LD A,3                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1          ; HL pointe le début de phrase  "Player 1"                      
        CALL BOUCLE             ; Routine affichage de la phrase
        LD A, (playersNumber)
        CP 2
        JR Z, suiteNextEndPlayer2
        LD A,1                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        JR suiteNextEndPlayer2
        suiteColorsPlayer2:
        LD A,2                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        ; LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        ; CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        suiteNextEndPlayer2:
        LD HL, player1Win01     ; HL pointe le début de phrase   "Tu as gagné, je te libère..."                     
        CALL BOUCLE             ; Routine affichage de la phrase
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1Win02     ; HL pointe le début de phrase : "Mais ne t'approche plus de ma femme"                     
        CALL BOUCLE   
        ; Test du nombre de joueurs
        LD A, (playersNumber)
        CP 0x31
        JR Z, showRectEndPlayer2
        LD HL, 0x0106           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player2Win03     ; HL pointe le début de phrase "Bourreau, exécutez"                    
        CALL BOUCLE   
        LD A,3                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3                                                      
        LD HL, player2          ; HL pointe le début de phrase "Player 2"                     
        CALL BOUCLE  
        LD A,2                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3   
        LD HL, 0x0107           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player2Win04     ; HL pointe le début de phrase "MAINTENANT!!!!!"                       
        CALL BOUCLE                                                        
        ; Show end screen
        LD HL, imageFinBad       ; Pointeur vers les données de l'image       
        LD DE,ADDENDSCREEN       ; Adresse mémoire vidéo de départ
        LD (debut_ligne), DE
        CALL boucleScreen
        ; Affichage bouton NEXT
        LD HL, 0x0D16           ; Coin supérieur gauche du cadre
        LD DE, 0x2519           ; Coin inférieur droit du cadre
        CALL ShowButtonNExt    
        JR endPlayer2KeyDetection
        showRectEndPlayer2:
            CALL SetColorEndScreenWin   ; Chargement de la palette
            ;Show end screen
            LD HL, imageFinWin          ; Pointeur vers les données de l'image       
            LD DE,ADDENDSCREEN          ; Adresse mémoire vidéo
            LD (debut_ligne), DE
            CALL boucleScreen
            ; Affichage bouton NEXT
            LD HL, 0x0D16
            LD DE, 0x2519
            CALL ShowButtonNExt 
            LD A,0                  ; Player 2 lost
            endPlayer2KeyDetection:
                RET
ShowButtonNExt:
    CALL 0xBB66
    LD A, 3              
    CALL 0xBB96
    CALL 0xBB6C
    LD A,1
    CALL 0xBB90
    LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, pressKeyStr              ; HL pointe le début de phrase                        
    CALL BOUCLE
    LD BC, 0x0100
    CALL 0xBBB7
    CALL CLEARKEY
    CALL AttenteTouche      ; Attente touche 
    RET
ChangeNamePlayer2:  ; Change name player 2 yyyyyyyyyyyy to Player 2, 0
    LD IX, player2          ; Adresse du player 2
    LD (IX+0), 0x50         ; Put Ox50(P) in first octet
    LD (IX+1), 0x6C         ; Put 0x6C(l) in next octet
    LD (IX+2), 0x61         ; Put 0x61(a) in next octet         
    LD (IX+3), 0x79         ; Put 0x79(y) in next octet
    LD (IX+4), 0x65         ; Put 0x65(e) in next octet
    LD (IX+5), 0x72         ; Put 0x72(r) in next octet
    LD (IX+6), 0x20         ; Put 0x20( ) in next octet
    LD (IX+7), 0x32         ; Put 0x32(2) in next octet
    LD (IX+8), 0            ; Put 0x0(0) in last octet
    RET
ShowWordifLostOrWin:
    LD IX, (tempAdressWord)         ; Load IX adress of the word
    LD DE, INITADDRESSWORD          ; Load DE destination adress on screen
    loopShowWordifLostOrWin:
        LD A, (IX+0)
        OR A
        JR Z, endloopShowWordifLostOrWin
        LD HL, DE           ;                                                        
        CALL LOCATECURSOR       ; LOCATE du curseur  
        LD A, (IX+0)
        CALL PRINTCHR 
        INC IX
        INC D, D
        JP loopShowWordifLostOrWin
    endloopShowWordifLostOrWin:
        ; test window
        LD HL, 0x0908
        LD DE, 0x200A
        CALL 0xBB66
        LD A, 3              
        CALL 0xBB96
        CALL 0xBB6C
        LD A,1
        CALL 0xBB90
        LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, pressKeyStr              ; HL pointe le début de phrase                        
        CALL BOUCLE
        LD BC, 0x0100
        CALL 0xBBB7
        CALL AttenteTouche      ; Attente touche JR C,  endloopShowWordifLostOrWin                   ; Loop if key not pressed
        RET
ENDCODE4200:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  DATA                                   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ORG 6000h
; BEGINDATA6000:
; xWord:              db 0x0
; ; 0=black(0)(00), 1=yellow(3)(01), 2=blue(4)(10), 3=white(7)(11), 4=half light = false
imageFinBad:
    INCLUDE "./Data/endScreenBad.asm"
imageFinWin:
    INCLUDE "./Data/endScreenWin.asm"
imageAppuyez:
    INCLUDE "./Data/appuyez.asm"
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
firstWord:
    INCLUDE "./Data/words.asm"
; textToScroll db "A"
lenWord:        db  0x0
lettersFound    db 0x0
pressKeyStr:    db "Appuyez sur une touche",0
exitMessage01:    db "Espace:", 0
exitMessage02:    db "QUITTER", 0
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
end04:           db "Retro Programmers United For Obscurs Systemes", 0
end06:           db "Code assembleur : DarkSteph", 0
end07:           db "A bientot", 0
end08:          db "Special thanks (pour m'avoir bien aid",E_AIGU,"    sur le code) a :", 0
end09:          db "BDCIron, CheshireCat, Redbug, ricolaoz, ", 0
end10:          db "Roudoudou, DeadSystem, LordHeavy, gurneyh et Ayor61", 0
namePlayer      db "Entrez votre pseudo, fin avec ", 0
deuxpoints      db  ":",0
nbrPlayerStr:   db "Nombre de joueur(s) (1 ou 2):", 0
quiVacommencerstr: db "Qui va commencer ?", 0
tirageAuSort    db "Tirage au sort en cours ", 0
point          db  0x2E
;A=color mask, H = left column, L = upper line, D=Right column, E=bottom line
background01:       db 0xF, 0x0, 0x0, 0x2, 0x19
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
CrossPlayer:            db 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF
randData:               db 100
debut_ligne     dw 0x0000
fin_ligne       db 0x0
ligne_courante  dw 0x0000
ENDDATA:
fin_programme
SAVE 'notme.bin',debut_programme, fin_programme - debut_programme, DSK, 'notme.dsk'