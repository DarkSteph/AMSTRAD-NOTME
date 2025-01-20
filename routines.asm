; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;  Game Routines                          ;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VBL:     
    LD B,#F5         ; Attente de synchro verticale
    IN A,(C)                    
    RRA                          
    JR NC, VBL 
    RET
BOUCLE:
    LD A, (HL)     ; A <- caractère pointé pas HL.
    OR A           ; A <- A OU A (détection de 0)
    RET Z          ; Retour de programme si A = 0
    CALL PRINTCHR  ; Vecteur d’affichage d’un caractère
    INC HL         ; HL pointe le caractère suivant
    JR BOUCLE      ; Revient à BOUCLE
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
    CALL PAPER 
    RET
InitStream1:
;HL = 1ere colonne, 1ere ligne, DE = Dernière colonne, Dernière ligne
; Init window, Set colors, CLS and Set PAPER
    LD HL, 0x0000
    LD DE, 0x2818
    CALL INITWINDOW
    CALL SetColorBlackScreen ; Chargelment de la palette de couleur
    LD A, 1              
    CALL PAPER
    CALL CLEARWINDOW
    CALL SetColorEndScreenBad ; Chargelment de la palette de couleur
    RET
InitStream2:
;HL = 1ere colonne, 1ere ligne, DE = Dernière colonne, Dernière ligne
; Init window, Set colors, CLS and Set PAPER
    LD HL, 0x0000
    LD DE, 0x2818
    CALL INITWINDOW
    CALL SetColorEndScreenWin ; Chargelment de la palette de couleur
    LD A, 3              
    CALL PAPER
    CALL CLEARWINDOW
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
ShowButtonNExt:
    CALL 0xBB66
    LD A, (couleurFondNEXT)              
    CALL 0xBB96
    CALL 0xBB6C
    LD A, (couleurPenNEXT)
    CALL 0xBB90
    LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, pressKeyStr              ; HL pointe le début de phrase                        
    CALL BOUCLE
    LD BC, 0x0100
    CALL 0xBBB7
    CALL CLEARKEY
    CALL AttenteTouche      ; Attente touche 
    postattentetouche:
    RET
ShowButtonHelp:
    CALL 0xBB66
    LD A, (couleurFondNEXT)              
    CALL 0xBB96
    CALL 0xBB6C
    LD A, (couleurPenNEXT)
    CALL 0xBB90
    LD HL, 0x0202           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, help              ; HL pointe le début de phrase                        
    CALL BOUCLE
    LD BC, 0x0100
    CALL 0xBBB7
    CALL CLEARKEY
    CALL AttenteTouche      ; Attente touche 
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
;#55,#54,#4B,#4A
    LD DE, 0x0002       ; INK 0,2       STYLO 0 Bleu (02)
    CALL SetPen
    LD DE, 0x0100       ; INK 1,0       STYLO 1 Noir (00)
    CALL SetPen
    LD DE, 0x021A       ; INK 2,26      STYLO 2  Blanc (26)
    CALL SetPen         
    LD DE, 0x0319       ; INK 3,25      STYLO 3 Jaune (11)
    CALL SetPen  
    RET
SetColorEndScreenWin:
 ;#55,#4C,#4A,#54
 ; 0-Bleu, 1-Rouge, 2-Jaune, 3-Noir
    LD DE, 0x0002       ; INK 0,2       STYLO 0 Bleu (00)
    CALL SetPen
    LD DE, 0x0106       ; INK 1,6       STYLO 1 Rouge (06)
    CALL SetPen
    LD DE, 0x0218       ; INK 2,24      STYLO 2 Jaune (24)
    CALL SetPen         
    LD DE, 0x0300       ; INK 3,0       STYLO 3 Noir (00)
    CALL SetPen  
    RET
SetColorBlackScreen:
 ;#55,#4C,#4A,#54
 ; 0-Bleu, 1-Rouge, 2-Jaune, 3-Noir
    LD DE, 0x0000       ; INK 0,2       STYLO 0 Bleu (00)
    CALL SetPen
    LD DE, 0x0100       ; INK 1,6       STYLO 1 Rouge (06)
    CALL SetPen
    LD DE, 0x0200       ; INK 2,24      STYLO 2 Jaune (24)
    CALL SetPen         
    LD DE, 0x0300       ; INK 3,0       STYLO 3 Noir (00)
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
DeleteCHR:
; Routine permettant d'effacer un cartère à l'écran
; de mettre dans le caratère par défaut dans la variable nomPlayer
; de relocaliser le curseur au bon endroit
    CALL 0xBB78         ; Routine pour savoir la position X, Y du curseur
    LD A, H
    CP COLONNE1CHR
    RET Z
    DEC IX              ; IX contient l'adresse de la variable du nom du joueur
    LD (IX), 0x78       ; set du chr par defaut (x) dans le nom du player
    CALL 0xBB78         ; Routine pour savoir la position X, Y du curseur
    DEC H               ; On bouge le curseur d'une colonne vers la gauche
    PUSH HL             ; Sauvegarde de la position du curseur sur la pile
    CALL LOCATECURSOR   ; Relocalisation du curseur (1 volonne en moins)
    LD A, 0x20          ; Set A avec le chr "ESPACE"
    CALL PRINTCHR       ; Affichage sur l'écran
    POP HL              ; Pop HL (position curseur)
    CALL LOCATECURSOR   ; Relocalisation du curseur car PRINTCHR fait avancer auto la position du curseur
    XOR A               ; Set du flag Z pour le retour de la fonction
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
    REPEAT 13
    CALL affich_8       ; Affiche 8 lignes de 80 octets
    CALL ajout_50       ; Change de bloc de 8 lignes
    REND
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
        LIRECHR:
        CALL 0xBB60
        CP 0xD2                               
        JR NZ, preIncreaseLetter    ; il va falloir pop af et set detectword à 1
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
        JR increaseLetter
        preIncreaseLetter:
        POP AF
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
    LD DE, TIC
    CALL PlaySound          ; DE = Adresse du son  
    LD A,1
    CALL 0xBB90             ; Use PEN 0   
    JR showLettersPlayerNext           
    showletternotfind:
        LD DE, SON2
        CALL PlaySound          ; DE = Adresse du son        
        LD A,2
        CALL 0xBB90                 ; ON UTILISE LE SYLO 2
    showLettersPlayerNext:          ; Draw letter on screen
        LD HL, (adressLetterChoice)
         ; Test si la ligne = 1A, si oui on inc colonne et ligne = 0
        LD A, L
        CP 0x1A
        JR NZ, afficheLetter:
        INC H
        LD A, 1
        LD L, A
        afficheLetter:
        PUSH HL
        CALL LOCATECURSOR 
        LD A, (lastLetterChooseCHR)     ; Put C (CHR value) to C (param)
        CALL PRINTCHR               ; PRINTCHR, print letter word instead of "tiret"
        POP HL
        INC L
        suiteShowLetter:
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
    LD A, (lenWord)         ; Load nombre de lettres restantes du mot à trouver
    CP 0                    ; Comparaison avec 0
    RET NZ                  ; Si non, fin de la routine
    ; Si oui
    LD A, 3
    LD (couleurFondNEXT), A
    LD A, 1
    LD (couleurPenNEXT), A
    LD HL, 0x0908           ; Colonne, Ligne début de la fenêtre           
    LD DE, 0x200A           ; Colonne, Ligne fin de la fenêtre
    CALL ShowButtonNExt     ; Création de la fenêtre
    CALL CLS1               ; CLS
    CALL PlayerWinEnd
    LD A, 0         ; Chargement retour de la routine
    RET             ; Retour
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
        CALL InitStream1
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
        LD HL, imageFinBadCompress     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD DE, ADDTAMPONDECOMPRESS
        CALL decompress         ; Affichage bouton NEXT
        LD HL, ADDTAMPONDECOMPRESS     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD (debut_ligne), DE
        CALL boucleScreen
        ; Afficher Boutton NEXT
        LD A, 0
        LD (couleurFondNEXT), A
        LD A, 3
        LD (couleurPenNEXT), A
        LD HL, 0x0D16           ; Coin supérieur gauche du cadre
        LD DE, 0x2519           ; Coin inférieur droit du cadre
        CALL ShowButtonNExt
        LD A, 1
        RET
EndPlayer1:
    CALL InitStream1
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
   ;Show end screen
    LD HL, imageFinBadCompress     ; Pointeur vers les données de l'image
    LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
    LD DE, ADDTAMPONDECOMPRESS
    CALL decompress         ; Affichage bouton NEXT
    LD HL, ADDTAMPONDECOMPRESS     ; Pointeur vers les données de l'image
    LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
    LD (debut_ligne), DE
    CALL boucleScreen
    ; Affichage bouton NEXT
    LD A, 0
    LD (couleurFondNEXT), A
    LD A, 3
    LD (couleurPenNEXT), A
    LD HL, 0x0D16           ; Coin supérieur gauche du cadre
    LD DE, 0x2519           ; Coin inférieur droit du cadre
    CALL ShowButtonNExt         
    LD A, 0                 ; Player 1 lost
    RET
EndPlayer2:
    CALL InitStream1            ; Initialisation de la fenetre
    ;CALL SetColorEndScreenBad  ; Chargement de la palette    
    LD A, (playersNumber)       ; Load nombre de joueurs
    CP 0x31                     ; Comparaison avec 1
    JR Z, nextEndPlayer2        ; Si oui goto nextPlayer2
    ; Si non
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
        LD A,2                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        JR suiteNextEndPlayer2
        suiteColorsPlayer2:
        LD A,2                  ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
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
        ;Show end screen
        LD HL, imageFinBadCompress     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD DE, ADDTAMPONDECOMPRESS
        CALL decompress         ; Affichage bouton NEXT
        LD HL, ADDTAMPONDECOMPRESS     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD (debut_ligne), DE
        CALL boucleScreen
        ; Affichage bouton NEXT
        LD A, 0
        LD (couleurFondNEXT), A
        LD A, 3
        LD (couleurPenNEXT), A
        LD HL, 0x0D16           ; Coin supérieur gauche du cadre
        LD DE, 0x2519           ; Coin inférieur droit du cadre
        CALL ShowButtonNExt    
        JR endPlayer2KeyDetection
        showRectEndPlayer2:
            LD A,0                  ; Player 2 lost
            endPlayer2KeyDetection:
                RET
PlayerWinEnd:
     ; 0-Bleu, 1-Rouge, 2-Jaune, 3-Noir
    CALL InitStream2 
    LD A,2                 ; On va utiliser le PEN 3
    CALL USEPEN             ; On utilise le stylo 3
    LD A, (activePlayer)
    CP 0x1
    JR Z, afficheNamePlayer1Win
    ; Si non
    ; Affichage nom player 2
    LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
    CALL LOCATECURSOR       ; LOCATE du curseur                                                      
    LD HL, player2          ; HL pointe le début de phrase "player 2"                      
    CALL BOUCLE  
    JR suitePlayer2Win
    afficheNamePlayer1Win:
        ; Affichage nom player 1
        LD HL, 0x0101           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1          ; HL pointe le début de phrase "player 2"                      
        CALL BOUCLE  
    SuitePlayer1Win:
        LD A,0                 ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, player1Win01     ; HL pointe le début de phrase   "Tu as gagné, je te libère..."                     
        CALL BOUCLE             ; Routine affichage de la phrase
        LD HL, 0x0104           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player1Win02     ; HL pointe le début de phrase : "Mais ne t'approche plus de ma femme"                     
        CALL BOUCLE
        JR afficheScreenWin
    SuitePlayer2Win:
        LD A,0                 ; On va utiliser le PEN 3
        CALL USEPEN             ; On utilise le stylo 3
        LD HL, player1Win01     ; HL pointe le début de phrase   "Tu as gagné, je te libère..."                     
        CALL BOUCLE             ; Routine affichage de la phrase
        LD HL, 0x0105           ; Set de la position en XY de la phrase                                                           
        CALL LOCATECURSOR       ; LOCATE du curseur                                                      
        LD HL, player2Win02     ; HL pointe le début de phrase : "Mais ne t'approche plus de ma femme"                     
        CALL BOUCLE
    afficheScreenWin:
        ;Show end screen
        LD HL, imageFinWinCompress          ; Pointeur vers les données de l'image       
        LD DE,ADDENDSCREEN          ; Adresse mémoire vidéo
        LD DE, ADDTAMPONDECOMPRESS
        CALL decompress         ; Affichage bouton NEXT
        LD HL, ADDTAMPONDECOMPRESS     ; Pointeur vers les données de l'image
        LD DE, ADDENDSCREEN            ; Adresse mémoire vidéo
        LD (debut_ligne), DE
        CALL boucleScreen
        ; Affichage bouton NEXT
        LD A, 0
        LD (couleurFondNEXT), A
        LD A, 2
        LD (couleurPenNEXT), A
        LD HL, 0x0D16
        LD DE, 0x2519
        CALL ShowButtonNExt 
        LD A,0                  ; Player 2 lost
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
PlaySound:
    PUSH HL                 ; Sauvegarde HL car BCAA peut l'altérer
    PUSH IX                 ; Sauvegarde IX car BCAA peut l'altérer
    LD HL, DE
    CALL 0xBCAA
    POP IX                  ; Load IX à partir de la pile
    POP HL                  ; Load HL à partir de la pile
    RET