# Project 11 - Learning with bumblebees (fr: Apprentissage avec des bourdons)

Encoding: UTF-8

This analysis focuses on the control group of bumblebees **Bombus terrestris**. It is part of a larger study on the effects of environmental stressors on the learning behaviour of bumblebees. From 187 bumblebee trajectories in an automated Y-maze learning apparatus, we analysed trajectories from trials 1 to 15 to observe changes in learning behaviour. We focused on factors such as reinforced side, light colour and fountain side.

## List of files
1. README.md: an overview of the project
2. analyse.R: Main script containing the code for data analysis, calculations, and visualisations used in the project.
3. result folder: Figures from this analysis
4. summary.pdf: A short summary of structure of raw data and
5. data: empty folder



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


## Structure of the analysis performed

The code is divided into two main sections: `functions` and  `main`. Functions are grouped by task (Tasks 01 & 02, Tasks 03 & 04, and Task 05) and separated by ### headers. The `main` section executes the code using these functions.

### Task 01: Fraction of reinforced side and fountain choices
- **Objective :** To measure the proportion of bumblebees ±SEM that successfully learned to navigate from a reinforced gate to reach the same side of the fountain over the first 15 trials.
- **Visualisation :** A **bar graph** to compare the total proportion of learned and unlearned bumblebees over the first 15 trials.

### Task 02: Fraction of reinforced side with colour and the fountain

- **Objective :** To measure the proportion of bumblebees (±SEM) that chose the fountain on the same side as their reinforcement side, grouped by the reinforcement colours **yellow (y)** and **blue (b)**.

- **Visualisation :** A **bar graph** comparing the fractions of bumblebees that successfully learned versus those that failed to use the reinforced side and fountain side.

### Task 03: Average Latency between `gate_test` and arrival at food zone

- **Objective :** To measure the **average latency** between the exit of the `gate_test` compartment and the first arrival at a feeding area (`fountain_left` or `fountain_right`)

- **Visualisation :** A **survival curve** to compare trials **1, 5, 10 and 15**.

### Task 04: Latency Learning Successful vs. Failed between `gate_test` and arrival at food zone

- **Objectif :** To identify the latencies of bumblebees that **successfully learn** (choose the same side, e.g. left-left).

- **Visualisation :** A **survival curve** to compare trials **1, 5, 10 and 15**.

### Task 05: Average speed from `gate_test` to reach the feeding zone

- **Objectif :** To calculate the **average speed ± SE** between the `gate_test` and the first arrival at a (`fountain_left` or `fountain_right`), and to compare this speed across trials **1, 5, 10 and 15**.
---
