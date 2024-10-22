# bourdon_R
# Project Bourdon 11 - Reinforced Side

## Project Description

### Encoding: UTF-8

We are analysing 187 trajectories of the **Bombus terrestris** bumblebee in an automated learning setup. Each data file contains 8 columns:

| Column            | Description                                                               |
|-------------------|---------------------------------------------------------------------------|
| `t.f`             | Time in terms of video frames (10 fps)                                    |
| `x.px`            | Position in pixels on the x-axis                                           |
| `y.px`            | Position in pixels on the y-axis                                           |
| `comp`            | Compartment where the bee is located (see slides 3 and 4 for details)      |
| `coul.renforce`   | Reinforced colour during the test (`yellow` or `blue`)                      |
| `cote.renforce`   | Side where the reinforced colour was located (`left` or `right`)            |
| `id.bourdon`      | Unique identifier for the bumblebee                                        |
| `essai`           | Trial number of the bumblebee (varies between **1** and **31**)            |

### Additional Information

- **Scale:** 1 cm corresponds to 75 pixels in the data.
- **Trial Variation:** The number of trials per bee can vary from **1 to 31**.
- **Important:** Some bees never reached the food zone. These bees must be **excluded** from the final statistical analyses.

### File Naming Format

The data files are named as follows: `frame_date_bee_xy_trial=z_tab.csv`


| Element        | Description                                          |
|----------------|------------------------------------------------------|
| `date`         | Date of the test in the format `year-month-day`       |
| `xy`           | Identification number of the bee                     |
| `z`            | Trial number                                         |

---

## Calculations to Perform

### 1. Fraction of Choices for the Reinforced Side-Fountain

- **Objective:** Calculate the fraction of choices for the reinforced side and the fountain side (2 groups ll-rr), with the **standard error (± SE)**, over trials **1 to 15**.
- **Visualisation:** Create a **graph** showing how this fraction evolves over the trials.

### 2. Analysis by Colour (Yellow / Blue)

- **Objective:** Perform the same analysis as above, but add reinforced colours **yellow** and **blue** together with the reinforced sides **left** and **right** (4 groups: yll, yrr, bll, brr)
- **Visualisation:** Create a comparative **graph** of the fractions for each colour.

### 3. Average Latency between Exit and Arrival at Food Zone

- **Objective:** Calculate the **average latency** between the exit from the `gate_test` compartment and the first arrival at a food zone (`fountain_left` or `fountain_right`).
- **Visualisation:** Create a **survival curve** (see [Wikipedia: Survival Analysis](https://en.wikipedia.org/wiki/Survival_analysis)) to compare trials **1, 5, 10, and 15**.

### 4. Comparative Survival Curve (Reinforced Colour vs Non-Reinforced)

- **Objective:** Perform a comparative analysis of the time based on whether the first source visited was the **reinforced colour** or not.
- **Visualisation:** Overlay the two survival curves (for a given trial) to compare the times.

### 5. Average Speed to Reach the Food Zone

- **Objective:** Calculate the **average speed** (with **standard error ± SE**) to reach a food zone, and compare this across trials **1, 5, 10, and 15**.
- **Visualisation:** Create a graph to illustrate the speed as a function of the trial.

---

## Notes
- We **excluded** bees that did not reach the food zone from the final statistical analysis.
