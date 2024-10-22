 Encodage UTF-8

187 trajectoires du bourdon Bombus terrestris dans un dispositif d'apprentissage automatisé. Chaque fichier a 6 colonnes:
t.f (temps en terme de frame du film, 10 fps
x.px (position en pixel axe x
y.px (position en pixel axe y
comp (compartiment dans lequel le bourdon se trouve, voir diapo 3 et 4)
coul.renforce (couleur - yellow/blue - qui a été renforcé dans ce test
cote.renforce (cote - left/right - ou s'est trouvé la couleur renforcé
id.bourdon (chiffre de l'identité du bourdon)
essai (numéro d'essai du bourdon id.bourdon)

1 cm en réalité correspond a 75 pixels, le nombre d'essai par bourdon peut varier de 1 à 31

Attention: certains bourdons ne sont jamais arrivé dans la zone de nourriture: les identifier et ne pas les traiter dans les statistiques finales.

le nom du fichier est du format: "frame_date_bee_xy_trial=z_tab.csv" avec
date: annee-mois-jour
xy: numéro du bourdon
z: numéro d'essai

A calculer:
- fraction (+- es) de choix de la couleur renforcé au cours des essais 1 à 15, en faire un graphique
- même analyse mais séparément pour la couleur renforcé "yellow" et "blue", faire un graphique qui permet de comparer les fractions
- calculer la latence moyenne entre sortie du compartiment 'gate_test' et première arrivé dans une zone avec nourriture ('fountain_left', 'fountain_right'). En faire une courbe de survie (voir wikipedia ce que c'est). Comparer ces courbes entre essai 1, essai 5, essai 10 et essai 15
- même analyse en séparant les temps selon que la première source visité soit celle de la couleur renforcé ou pas. Faire une courbe de survie comparative (superposer po.ur un essai donnée les deux courbes de survie)
- calculer la vitesse moyenne (+- es) d'atteindre une zone avec nourriture en fonction de l'essai 1, 5, 10 et 15.
