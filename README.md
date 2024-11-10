# Project 11 - Learning with bumblebees (fr: Apprentissage avec des bourdons)

### Encoding: UTF-8

This analysis focuses on the control group of bumblebees **Bombus terrestris**. It is part of a larger study on the effects of environmental stressors on the learning behaviour of bumblebees. From 187 bumblebee trajectories in an automated Y-maze learning apparatus, we analysed trajectories from trials 1 to 15 to observe changes in learning behaviour. We focused on factors such as reinforced side, light colour and fountain side.

## List of files
1. README.md: an overview of the project
2. analyse.R: Main script containing the code for data analysis, calculations, and visualisations used in the project.
3. 180s_video.mp4: 3-minute video explanation of the calculation methods
4. calculation_presentation.pdf: PDF version of the presentation

## Data description

Each data file contains 8 columns:

| Column           | Description                                                               |
|-------------------|---------------------------------------------------------------------------|
| `t.f`             | Time in frames (10 fps)                                  |
| `x.px`            | Position in pixels on x-axis                        |
| `y.px`            | Position in pixels on y-axis                                            |
| `comp`            | Compartment where the bumblebee is (see the report for a visualisation)    |
| `coul.renforce`   | Light colour for testing (`yellow` or `blue`)                       |
| `cote.renforce`   | Side where the reinforced colour was placed (`left` or `right`)             |
| `id.bourdon`      | Unique ID for each bumblebee                                   |
| `essai`           | Bumblebee trial number (varies between **1** and **31**)       |

- **Scale:** 1 cm corresponds to 75 pixels.
- **Trial Variation:** The number of trials per bumblebee can vary from **1 to 31**.
- **Important:** Some bumblebees never reached the feeding area. We **excluded** them in final statistical analyses.

### File name format

The data files are named as follows: `frame_date_bee_xy_trial=z_tab.csv`.

| Element       | Description                                          |
|---------------|------------------------------------------------------|
| `date`        | Testing date in `year-month-day` format
             |
| `xy`          | Bumblebee identification number
                   |
| `z`           | Trial number
                                    |

---

## Structure of the analysis performed

### 1. Fraction of reinforced side and fountain choices
- **Objectif :** To measure the proportion of bumblebees ±SEM that successfully learned to navigate from a reinforced gate to reach the same side of the fountain over the first 15 trials.
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
