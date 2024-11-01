# Project 11 - Apprentissage avec des bourdons

### Encoding: UTF-8

Cette analyse se focalise sur le groupe de contrôle des bourdons **Bombus terrestris**, dans le cadre d'une étude plus large sur l'impact des facteurs de stress environnementaux sur le comportement d'apprentissage des bourdons. Nous examinons 187 trajectoires de bourdons dans un dispositif d'apprentissage automatisé de type Y-maze. Nous analysons les essais 1 à 15 pour observer l'évolution des comportements d'apprentissage, en tenant compte de facteurs tels que le côté renforcé, la couleur de la lumière et le côté de la fontaine.


## Description des données

Chaque fichier de données contient 8 colonnes :

| Colonne           | Description                                                               |
|-------------------|---------------------------------------------------------------------------|
| `t.f`             | Temps en termes de frames vidéo (10 fps)                                  |
| `x.px`            | Position en pixels sur l'axe x                                            |
| `y.px`            | Position en pixels sur l'axe y                                            |
| `comp`            | Compartiment où se trouve le bourdon (voir diapos 3 et 4 pour détails)    |
| `coul.renforce`   | Couleur renforcée lors du test (`yellow` ou `blue`)                       |
| `cote.renforce`   | Côté où la couleur renforcée était placée (`left` ou `right`)             |
| `id.bourdon`      | Identifiant unique pour chaque bourdon                                   |
| `essai`           | Numéro d'essai du bourdon (varie entre **1** et **31**)                  |

- **Échelle :** 1 cm correspond à 75 pixels.
- **Variation des Essais :** Le nombre d'essais par bourdon peut varier de **1 à 31**.
- **Important :** Certains bourdons n'ont jamais atteint la zone de nourriture. Nous les **excluons** dans des analyses statistiques finales.

### Format de nom des fichiers

Les fichiers de données sont nommés comme suit : `frame_date_bee_xy_trial=z_tab.csv`

| Élément       | Description                                          |
|---------------|------------------------------------------------------|
| `date`        | Date du test au format `année-mois-jour`             |
| `xy`          | Numéro d'identification du bourdon                   |
| `z`           | Numéro de l'essai                                    |

---
## Calculs à effectuer

### 1. Fraction des choix pour le côté renforcé et la fontaine

- **Objectif :** Mesurer la fréquence à laquelle les bourdons choisissent la fontaine du même côté que la sortie renforcée (gauche-gauche ou droite-droite) sur les essais **1 à 15**. Inclure l’**erreur standard (± SE)** pour plus de précision.
- **Visualisation :** Un **diagramme en barres** comparant la fraction totale des choix congruents et non congruents, pour montrer les différences dans le renforcement.

### 2. Fraction des choix pour le côté avec la couleur renforcée et la fontaine

- **Objectif :** Réaliser la même analyse de fraction ± SE que ci-dessus, en ajoutant les couleurs renforcées **jaune** (y) et **bleu** (b) avec les côtés renforcés **gauche** et **droite**. Il y a quatre groupes : yll, yrr, bll, brr.
- **Visualisation :** Un **graphique comparatif** montrant les fractions pour les cas congruents et non congruents.

### 3. Latence Moyenne entre Gate_Test et Arrivée à la Zone de Nourriture

- **Objectif :** Calculer la **latence moyenne** entre la sortie du compartiment `gate_test` et la première arrivée à une zone de nourriture (`fountain_left` ou `fountain_right`).
- **Visualisation :** Une **courbe de survie** pour comparer les essais **1, 5, 10 et 15**.

### 4. Latence Apprentissage Réussi vs. Échoué

- **Objectif :** Calculer la latence moyenne entre le dernier passage du bourdon dans le `gate_test` et sa première visite à la fontaine. Comparer les latences de deux groupes : **apprentissage réussi** (choix du même côté, par ex. gauche-gauche) et **apprentissage échoué** (côtés différents).
- **Visualisation :** Deux **courbes de survie** par couleur, comparant les essais **1, 5, 10 et 15**.

### 5. Vitesse Moyenne pour Atteindre la Zone de Nourriture

- **Objectif :** Calculer la **vitesse moyenne ± SE** entre le `gate_test` et la première arrivée à une (`fountain_left` ou `fountain_right`), et comparer cette vitesse à travers les essais **1, 5, 10 et 15**.
---
