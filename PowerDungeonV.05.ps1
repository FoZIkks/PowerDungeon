# ------------------------------------------------------ PowerDungeon ------------------------------------------------------

# Bievenue dans PowerDungeon
# Un mini jeu de rôle développé par Eazon
# J'espère que ca vous plaira!

# ------------------------------------------------------- Changelog --------------------------------------------------------

# V0.1 Pre-Alpha - In-Dev 
# V0.2 Instauration d'un système de sauvegarde des variables
# V0.3 Ecriture de l'histoire et définition des mécaniques de gameplay
# V0.4 Mise en place de la structure globale
# V0.5 Alpha


# --------------------------------------------------------- Script ---------------------------------------------------------


# Déclaration des fonctions


# Fichier de sauvegarde

if (test-path C:\PowerDungeon\PowerDungeonSave.csv)
{
    $savedVariables = Import-CSV -Path C:\PowerDungeon\PowerDungeonSave.csv -Delimiter ","
    $firstTimePlay = $savedVariables.firstTimePlay
    $charNameInput = $savedVariables.charNameInput 
    $Global:goblinSlayedButtonShow = $savedVariables.goblinSlayedButtonShow
    $Global:showTorch = $savedVariables.showTorch
    $Global:showRevelato = $savedVariables.showRevelato
    $Global:floor3unlocked = $savedVariables.floor3unlocked
    $Global:floor4unlocked = $savedVariables.floor4unlocked
}
else
{
    if (test-path C:\PowerDungeon)
    {
        Write-Host "Le dossier existe"
    }
    else
    {
        New-Item C:\PowerDungeon -Type Directory
    }
    New-Item C:\PowerDungeon\PowerDungeonSave.csv
    $firstTimePlay = "True"
    $Global:goblinSlayedButtonShow = "False"
    $Global:showTorch = "False"
    $Global:goblinsNotSlayed = "False"
    $Global:goblinSlayedCounter = 0
    $Global:showRevelato = "False"
    $Global:floor3unlocked = "False"
    $Global:floor4unlocked = "False"
}

$Global:currentFloor = 0
$Global:torchEquiped = "False"
$Global:useRevelato = "False"


# Déclaration des fonctions de boutons


Function MakeNewForm {
	$PoDMainFrame.Close()
	$PoDMainFrame.Dispose()
    $mapFrame.Close()
	$mapFrame.Dispose()
	MakeMainFrameForm
    $Global:useRevelato = "False"
}

$createCharBtn = {
    Set-Variable -Name charNameInput -Value $BoxPrenameUser.text -Scope 1
    $CreateUser.Dispose()
    $CreateUser.Close()
}


$invBtnClick = {
    MakeInvFrame
}

$compBtnClick = {
    MakeSkillFrame
}

$mapBtnClick = {
    MakeMapFrame
}

$mapClickFloor1 = {
    $currentFloor = 1
    MakeNewForm
}

$mapClickFloor0 = {
    $Global:useRevelato = "False"
    $currentFloor = 0
    MakeNewForm
}

$mapClickFloor2 = {
    $currentFloor = 2
    MakeNewForm
}

$mapClickFloor3 = {
    $currentFloor = 3
    MakeNewForm
}

$mapClickFloor4 = {
    $currentFloor = 4
    MakeNewForm
}

$cmbtBtnClick = {
    if ($Global:goblinSlayedButtonShow -ne "True" -and $Global:goblinsNotSlayed -ne "True")
    {
        $Global:goblinSlayedCounter++
        Write-Host $Global:goblinSlayedCounter/15
        if ($Global:goblinSlayedCounter -eq 15)
        {
            GoblinSlayedFrame
            $Global:goblinSlayedButtonShow = "True"
        }
    }
}

$skipBtnClick = {
if ($Global:goblinSlayedButtonShow -ne "True" -and $Global:goblinSlayedCounter -eq 0)
{
    $Global:goblinsNotSlayed = "True"
    $Global:goblinSlayedButtonShow = "True"
    GoblinNotSlayedFrame
}
}

$invTorchBtnClick = {
    $Global:torchEquiped = "True"
    $invFrame.Close()
    $invFrame.Dispose()
    MakeNewForm
}


$revelatoBtnClick = {
    $Global:useRevelato = "True"
    $skillFrame.Close()
    $skillFrame.Dispose()
    MakeNewForm
}

Function GoblinSlayedFrame {
$goblinSlayedFramed = New-Object system.Windows.Forms.Form

$goblinSlayedFramed.ClientSize         = '900,100'
$goblinSlayedFramed.text               = "PowerDungeon - Bravo!"
$goblinSlayedFramed.BackColor          = "#ffffff"

$TitreGob                           = New-Object system.Windows.Forms.Label
$TitreGob.text                      = "Après avoir tué une quinzaine de gobelins, une porte que vous n'avez jamais vu s'ouvre au fond.
(Vous pouvez passer a l'étage suivant)"
$TitreGob.AutoSize                  = $true
$TitreGob.width                     = 25
$TitreGob.height                    = 10
$TitreGob.location                  = New-Object System.Drawing.Point(50,20)
$TitreGob.Font                      = 'Microsoft Sans Serif,13'
$goblinSlayedFramed.Controls.Add($TitreGob)

$goblinSlayedFramed.ShowDialog()
}

Function GoblinNotSlayedFrame {
$goblinNotSlayedFramed = New-Object system.Windows.Forms.Form

$goblinNotSlayedFramed.ClientSize         = '900,100'
$goblinNotSlayedFramed.text               = "PowerDungeon - Bravo...?"
$goblinNotSlayedFramed.BackColor          = "#ffffff"

$TitreGobNo                           = New-Object system.Windows.Forms.Label
$TitreGobNo.text                      = "Sans aucune forme de respect a l'égard de la considération des gobelins, vous les enjambez.
(Vous pouvez passer a l'étage suivant)"
$TitreGobNo.AutoSize                  = $true
$TitreGobNo.width                     = 25
$TitreGobNo.height                    = 10
$TitreGobNo.location                  = New-Object System.Drawing.Point(50,20)
$TitreGobNo.Font                      = 'Microsoft Sans Serif,13'
$goblinNotSlayedFramed.Controls.Add($TitreGobNo)

$goblinNotSlayedFramed.ShowDialog()
}

Function MakeSkillFrame {
$skillFrame = New-Object system.Windows.Forms.Form

$skillFrame.ClientSize         = '600,550'
$skillFrame.text               = "PowerDungeon - Compétences"
$skillFrame.BackColor          = "#ffffff"

$TitreSkill                           = New-Object system.Windows.Forms.Label
$TitreSkill.text                      = "Compétences"
$TitreSkill.AutoSize                  = $true
$TitreSkill.width                     = 25
$TitreSkill.height                    = 10
$TitreSkill.location                  = New-Object System.Drawing.Point(268,20)
$TitreSkill.Font                      = 'Microsoft Sans Serif,13'
$skillFrame.Controls.Add($TitreSkill)

if ($Global:showRevelato -eq "True") {
    #Bouton Revelato
    $revelatoBtn                       = New-Object system.Windows.Forms.Button
    $revelatoBtn.BackColor             = "#ffffff"
    $revelatoBtn.text                  = "Revelato"
    $revelatoBtn.width                 = 100
    $revelatoBtn.height                = 50
    $revelatoBtn.location              = New-Object System.Drawing.Point(250,50)
    $revelatoBtn.Font                  = 'Microsoft Sans Serif,10'
    $revelatoBtn.ForeColor             = "#000"
    $revelatoBtn.Add_Click($revelatoBtnClick)
    $skillFrame.Controls.Add($revelatoBtn)   
    }
$skillFrame.ShowDialog()
}

Function MakeInvFrame {
#Construction de fenêtre de l'inventaire
$invFrame = New-Object system.Windows.Forms.Form

$invFrame.ClientSize         = '600,550'
$invFrame.text               = "PowerDungeon - Inventaire"
$invFrame.BackColor          = "#ffffff"

$TitreInv                           = New-Object system.Windows.Forms.Label
$TitreInv.text                      = "Inventaire"
$TitreInv.AutoSize                  = $true
$TitreInv.width                     = 25
$TitreInv.height                    = 10
$TitreInv.location                  = New-Object System.Drawing.Point(268,20)
$TitreInv.Font                      = 'Microsoft Sans Serif,13'
$invFrame.Controls.Add($TitreInv)

if ($Global:showTorch -eq "True") {
    #Bouton Torche
    $invTorchBtn                       = New-Object system.Windows.Forms.Button
    $invTorchBtn.BackColor             = "#ffffff"
    $invTorchBtn.text                  = "S'équiper de la torche"
    $invTorchBtn.width                 = 100
    $invTorchBtn.height                = 50
    $invTorchBtn.location              = New-Object System.Drawing.Point(250,50)
    $invTorchBtn.Font                  = 'Microsoft Sans Serif,10'
    $invTorchBtn.ForeColor             = "#000"
    $invTorchBtn.Add_Click($invTorchBtnClick)
    $invFrame.Controls.Add($invTorchBtn)   
    }
$invFrame.ShowDialog()
}

Function MakeMapFrame {
#Construction de fenêtre de la map
$mapFrame = New-Object system.Windows.Forms.Form

$mapFrame.ClientSize         = '600,550'
$mapFrame.text               = "PowerDungeon - Carte"
$mapFrame.BackColor          = "#ffffff"

$TitreMap                           = New-Object system.Windows.Forms.Label
$TitreMap.text                      = "Carte"
$TitreMap.AutoSize                  = $true
$TitreMap.width                     = 25
$TitreMap.height                    = 10
$TitreMap.location                  = New-Object System.Drawing.Point(268,20)
$TitreMap.Font                      = 'Microsoft Sans Serif,13'
$mapFrame.Controls.Add($TitreMap)

#Bouton Carte1
$mapFloorBtn1                       = New-Object system.Windows.Forms.Button
$mapFloorBtn1.BackColor             = "#ffffff"
$mapFloorBtn1.text                  = "Etage 1"
$mapFloorBtn1.width                 = 90
$mapFloorBtn1.height                = 30
$mapFloorBtn1.location              = New-Object System.Drawing.Point(250,100)
$mapFloorBtn1.Font                  = 'Microsoft Sans Serif,10'
$mapFloorBtn1.ForeColor             = "#000"
$mapFloorBtn1.Add_Click($mapClickFloor1)
$mapFrame.Controls.Add($mapFloorBtn1)

#Bouton Carte0
$mapFloorBtn0                       = New-Object system.Windows.Forms.Button
$mapFloorBtn0.BackColor             = "#ffffff"
$mapFloorBtn0.text                  = "Etage 0"
$mapFloorBtn0.width                 = 90
$mapFloorBtn0.height                = 30
$mapFloorBtn0.location              = New-Object System.Drawing.Point(250,50)
$mapFloorBtn0.Font                  = 'Microsoft Sans Serif,10'
$mapFloorBtn0.ForeColor             = "#000"
$mapFloorBtn0.Add_Click($mapClickFloor0)
$mapFrame.Controls.Add($mapFloorBtn0)


if ($Global:goblinSlayedButtonShow -eq "True")
{
    #Bouton Carte2
    $mapFloorBtn2                       = New-Object system.Windows.Forms.Button
    $mapFloorBtn2.BackColor             = "#ffffff"
    $mapFloorBtn2.text                  = "Etage 2"
    $mapFloorBtn2.width                 = 90
    $mapFloorBtn2.height                = 30
    $mapFloorBtn2.location              = New-Object System.Drawing.Point(250,150)
    $mapFloorBtn2.Font                  = 'Microsoft Sans Serif,10'
    $mapFloorBtn2.ForeColor             = "#000"
    $mapFloorBtn2.Add_Click($mapClickFloor2)
    $mapFrame.Controls.Add($mapFloorBtn2)
}

if ($Global:floor3unlocked -eq "True")
{
    #Bouton Carte3
    $mapFloorBtn3                      = New-Object system.Windows.Forms.Button
    $mapFloorBtn3.BackColor             = "#ffffff"
    $mapFloorBtn3.text                  = "Etage 3"
    $mapFloorBtn3.width                 = 90
    $mapFloorBtn3.height                = 30
    $mapFloorBtn3.location              = New-Object System.Drawing.Point(250,200)
    $mapFloorBtn3.Font                  = 'Microsoft Sans Serif,10'
    $mapFloorBtn3.ForeColor             = "#000"
    $mapFloorBtn3.Add_Click($mapClickFloor3)
    $mapFrame.Controls.Add($mapFloorBtn3)
}

if ($Global:floor4unlocked -eq "True")
{
    #Bouton Carte3
    $mapFloorBtn4                      = New-Object system.Windows.Forms.Button
    $mapFloorBtn4.BackColor             = "#ffffff"
    $mapFloorBtn4.text                  = "Etage 4"
    $mapFloorBtn4.width                 = 90
    $mapFloorBtn4.height                = 30
    $mapFloorBtn4.location              = New-Object System.Drawing.Point(250,250)
    $mapFloorBtn4.Font                  = 'Microsoft Sans Serif,10'
    $mapFloorBtn4.ForeColor             = "#000"
    $mapFloorBtn4.Add_Click($mapClickFloor4)
    $mapFrame.Controls.Add($mapFloorBtn4)
}

$mapFrame.ShowDialog()
}


# Construction de la fenêtre


Function MakeMainFrameForm {
Add-Type -AssemblyName System.Windows.Forms

$PoDMainFrame = New-Object system.Windows.Forms.Form

#Création de la fenêtre
$PoDMainFrame.ClientSize         = '600,550'
$PoDMainFrame.text               = "PowerDungeon"
$PoDMainFrame.BackColor          = "#ffffff"

$Titre                           = New-Object system.Windows.Forms.Label
$Titre.text                      = "PowerDungeon v0.5"
$Titre.AutoSize                  = $true
$Titre.width                     = 25
$Titre.height                    = 10
$Titre.location                  = New-Object System.Drawing.Point(220,20)
$Titre.Font                      = 'Microsoft Sans Serif,13'
$PoDMainFrame.Controls.Add($Titre)

#Bouton cancel
$cancelBtn                       = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor             = "#f00e0e"
$cancelBtn.text                  = "Fin du jeu"
$cancelBtn.width                 = 90
$cancelBtn.height                = 30
$cancelBtn.location              = New-Object System.Drawing.Point(480,490)
$cancelBtn.Font                  = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor             = "#000"
$cancelBtn.DialogResult          = [System.Windows.Forms.DialogResult]::Cancel
$PoDMainFrame.CancelButton   = $cancelBtn
$PoDMainFrame.Controls.Add($cancelBtn)

#Bouton Inventory
$inventoryBtn                       = New-Object system.Windows.Forms.Button
$inventoryBtn.BackColor             = "#78c9ff"
$inventoryBtn.text                  = "Inventaire"
$inventoryBtn.width                 = 90
$inventoryBtn.height                = 30
$inventoryBtn.location              = New-Object System.Drawing.Point(100,75)
$inventoryBtn.Font                  = 'Microsoft Sans Serif,10'
$inventoryBtn.ForeColor             = "#000"
$inventoryBtn.Add_Click($invBtnClick)
$PoDMainFrame.Controls.Add($inventoryBtn)

#Bouton Equipment
$compBtn                       = New-Object system.Windows.Forms.Button
$compBtn.BackColor             = "#6732d5"
$compBtn.text                  = "Compétences"
$compBtn.width                 = 100
$compBtn.height                = 30
$compBtn.location              = New-Object System.Drawing.Point(250,75)
$compBtn.Font                  = 'Microsoft Sans Serif,10'
$compBtn.ForeColor             = "#000"
$compBtn.Add_Click($compBtnClick)
$PoDMainFrame.Controls.Add($compBtn)

#Bouton Carte
$mapBtn                       = New-Object system.Windows.Forms.Button
$mapBtn.BackColor             = "#33d532"
$mapBtn.text                  = "Carte"
$mapBtn.width                 = 90
$mapBtn.height                = 30
$mapBtn.location              = New-Object System.Drawing.Point(400,75)
$mapBtn.Font                  = 'Microsoft Sans Serif,10'
$mapBtn.ForeColor             = "#000"
$mapBtn.Add_Click($mapBtnClick)
$PoDMainFrame.Controls.Add($mapBtn)

#Display character name
$charName                           = New-Object system.Windows.Forms.Label
$charName.text                      = "Joueur : " + $charNameInput
$charName.AutoSize                  = $true
$charName.width                     = 25
$charName.height                    = 50
$charName.location                  = New-Object System.Drawing.Point(50,50)
$charName.Font                      = 'Microsoft Sans Serif,10'
$PoDMainFrame.Controls.Add($charName)

#Display current floor
$curFloor                           = New-Object system.Windows.Forms.Label
$curFloor.text                      = "Etage actuel : " + $currentFloor
$curFloor.AutoSize                  = $true
$curFloor.width                     = 25
$curFloor.height                    = 50
$curFloor.location                  = New-Object System.Drawing.Point(250,125)
$curFloor.Font                      = 'Microsoft Sans Serif,10'
$PoDMainFrame.Controls.Add($curFloor)

if ($currentFloor -eq 0){

    $currentInfo = "Vous voîla dans le donjon. 
    Vous avancez prudemment, le son de vos bottes se réverbérant a l'infini.
    Au fond, vous apercevez une porte qui attire votre regard.
    (cliquez sur Carte et passez à l'étage suivant)"
}

if ($currentFloor -eq 0 -and $Global:useRevelato -eq "True")
{
    $currentInfo = "En lancant Revelato, vous apercevez un coffre qui se dessinne dans un coin de la pièce!
    Vous obtenez un Easter Egg!"
}
if ($currentFloor -eq 1){
    $currentInfo = "A peine rentré, vous tombez face a une horde de gobelins!
    Battez-vous ou... ignorez les et passez a travers eux ils ont pas l'air si hostile"

    #Bouton Skip
    $skipBtn                       = New-Object system.Windows.Forms.Button
    $skipBtn.BackColor             = "#ffffff"
    $skipBtn.text                  = "Les enjamber ...?"
    $skipBtn.width                 = 100
    $skipBtn.height                = 50
    $skipBtn.location              = New-Object System.Drawing.Point(245,325)
    $skipBtn.Font                  = 'Microsoft Sans Serif,10'
    $skipBtn.ForeColor             = "#000"
    $skipBtn.Add_Click($skipBtnClick)
    $PoDMainFrame.Controls.Add($skipBtn)
}

if ($currentFloor -eq 2) {
    $currentInfo = "Cette pièce est plongée dans l'obscuritée, impossible d'y voir plus loin.
    Soudainement, vous vous rappelez que vous aviez 
    emporté une torche avec vous!
    (Ouvrez l'inventaire et sélectionnez la torche qui était dans votre poche...
    comment elle rentrait d'ailleurs??)"
    $Global:showTorch = "True"
}
if ($currentFloor -eq 2 -and $Global:torchEquiped -eq "True") {
    $currentInfo = "Vous prenez la torche. Elle s'allume comme par magie grâce à la magie.
    Vous pouvez avancer par la porte suivante."
    $Global:floor3unlocked = "True"

}
if ($currentFloor -eq 3)
{
    $currentInfo = "Vous voilà dans une pièce aussi vide que mon compte en banque.
    Rien que des toiles d'araignées dans les coins (ils pourraient faire le ménage)
    Soudain, vous vous rappellez que vous pouvez utiliser vos compétences!
    (Ouvrez le menu Compétences et lancez Revelato)"
    $Global:showRevelato = "True"
}
if ($currentFloor -eq 3 -and $Global:useRevelato -eq "True") {
    $currentInfo = "En lançant Revelato, une porte apparaît au fond de la piece!"
    $Global:floor4unlocked = "True"
}
if ($currentFloor -eq 3 -and $Global:floor4unlocked -eq "True") {
    $currentInfo = "En lançant Revelato, une porte apparaît au fond de la piece!"
    $Global:floor4unlocked = "True"
}
if ($currentFloor -eq 4) {
    $currentInfo = "Félicitations vous voilà arrivés au 4ème étage, signe de la fin de l'Alpha!
    Si vous avez aimé, n'hésitez pas à me faire un retour! 
    Idem si vous avez trouvé un ou plusieurs bugs!
    Merci d'avoir pris le temps de jouer ;)
    Eazon"
}

#Display current info
$curInfo                           = New-Object system.Windows.Forms.Label
$curInfo.text                      = $currentInfo
$curInfo.AutoSize                  = $true
$curInfo.width                     = 25
$curInfo.height                    = 50
$curInfo.location                  = New-Object System.Drawing.Point(45,150)
$curInfo.Font                      = 'Microsoft Sans Serif,10'
$curInfo.TextAlign                 = [System.Drawing.ContentAlignment]::MiddleCenter
$PoDMainFrame.Controls.Add($curInfo)

if ($currentFloor -eq 1)
{
    #Bouton Combat
    $cmbtBtn                       = New-Object system.Windows.Forms.Button
    $cmbtBtn.BackColor             = "#ffffff"
    $cmbtBtn.text                  = "Combattre un monstre"
    $cmbtBtn.width                 = 120
    $cmbtBtn.height                = 50
    $cmbtBtn.location              = New-Object System.Drawing.Point(235,250)
    $cmbtBtn.Font                  = 'Microsoft Sans Serif,10'
    $cmbtBtn.ForeColor             = "#000"
    $cmbtBtn.Add_Click($cmbtBtnClick)
    $PoDMainFrame.Controls.Add($cmbtBtn)
}

$Global:result = $PoDMainFrame.ShowDialog()
}

#Fenetre de premier joueur
Add-Type -AssemblyName System.Windows.Forms
$CreateUser = New-Object system.Windows.Forms.Form

#Création de la fenêtre
$CreateUser.ClientSize         = '400,550'
$CreateUser.text               = "PowerDungeon"
$CreateUser.BackColor          = "#ffffff"

$Titre                           = New-Object system.Windows.Forms.Label
$Titre.text                      = "PowerDungeon v0.5"
$Titre.AutoSize                  = $true
$Titre.width                     = 25
$Titre.height                    = 10
$Titre.location                  = New-Object System.Drawing.Point(120,20)
$Titre.Font                      = 'Microsoft Sans Serif,13'
$CreateUser.Controls.Add($Titre)

#Bouton cancel
$cancelBtn                       = New-Object system.Windows.Forms.Button
$cancelBtn.BackColor             = "#f00e0e"
$cancelBtn.text                  = "Fin du jeu"
$cancelBtn.width                 = 90
$cancelBtn.height                = 30
$cancelBtn.location              = New-Object System.Drawing.Point(480,490)
$cancelBtn.Font                  = 'Microsoft Sans Serif,10'
$cancelBtn.ForeColor             = "#000"
$cancelBtn.DialogResult          = [System.Windows.Forms.DialogResult]::Cancel
$CreateUser.CancelButton   = $cancelBtn
$CreateUser.Controls.Add($cancelBtn)

#Texte explicatif
$LineExplication                               = New-Object System.Windows.Forms.Label
$LineExplication.Location                      = New-Object System.Drawing.Point(50,100)
$LineExplication.Size                          = New-Object System.Drawing.Size(280,300)
$LineExplication.Font                          = 'Microsoft Sans Serif,13'
$LineExplication.Text                          = "Bonjour et bienvenue dans PowerDungeon! Ce jeu vous propose d'incarner un aventurirer en quête d'aventures...(Ouais on est à ce niveau.) Après avoir suivi un tas de panneaux étranges, vous voilà arrivé devant un bien étrange donjon : le donjon de Nahe.. merde j'ai pas les droits, euh bonne chance aventurier!"
$CreateUser.Controls.Add($LineExplication)

# Formulaire nom
$LinePrenameUser                               = New-Object System.Windows.Forms.Label
$LinePrenameUser.Location                      = New-Object System.Drawing.Point(130,400)
$LinePrenameUser.Size                          = New-Object System.Drawing.Size(280,20)
$LinePrenameUser.Text                          = "Rentrez le nom du joueur"
$CreateUser.Controls.Add($LinePrenameUser)

$BoxPrenameUser                      = New-Object system.Windows.Forms.TextBox
$BoxPrenameUser.Location             = New-Object System.Drawing.Point(70,420)
$BoxPrenameUser.Size                 = New-Object System.Drawing.Size(260,20)
$CreateUser.Controls.Add($BoxPrenameUser)

#Bouton Go
$createChar                       = New-Object system.Windows.Forms.Button
$createChar.BackColor             = "#ffffff"
$createChar.text                  = "Démarrer!"
$createChar.width                 = 90
$createChar.height                = 30
$createChar.location              = New-Object System.Drawing.Point(150,450)
$createChar.Font                  = 'Microsoft Sans Serif,10'
$createChar.ForeColor             = "#000"
$createChar.Add_Click($createCharBtn)
$CreateUser.Controls.Add($createChar)

# Script

# Détéction de si premier joueur

if ( $firstTimePlay -eq "True" )
{
    $CreateUser.ShowDialog()
    $firstTimePlay = "False"
    New-Object -TypeName PSCustomObject -Property @{
    firstTimePlay=$firstTimePlay
    charNameInput=$charNameInput

    }|Export-Csv -path C:\PowerDungeon\PowerDungeonSave.csv -NoTypeInformation 

}


MakeMainFrameForm
if ($Global:result –eq [System.Windows.Forms.DialogResult]::Cancel)
{
    write-output 'Fin du jeu'
    New-Object PSObject -Property @{
    firstTimePlay=$firstTimePlay
    charNameInput=$charNameInput
    goblinsNotSlayed=$Global:goblinsNotSlayed
    goblinSlayedButtonShow=$Global:goblinSlayedButtonShow
    showTorch=$Global:showTorch
    showRevelato=$Global:showRevelato
    floor3unlocked=$Global:floor3unlocked
    floor4unlocked=$Global:floor4unlocked
    }|Export-Csv -path C:\PowerDungeon\PowerDungeonSave.csv -NoTypeInformation 
}