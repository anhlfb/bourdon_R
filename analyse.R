### CLEAN THE DATA ###
rm(list=ls())
#print(list.files())
data_path = "../data/"

fichiers = list.files(data_path, pattern=".csv")
nbFichiers = length(fichiers)

top15trials = c()

### First take files with trial < 16, then check files and count the colours, then do the maths ###
for (k in 1:nbFichiers) {
  donnees = read.csv(fichiers[k], header=TRUE, sep = ",", dec = ".", fill = TRUE, comment.char = "")
  if (any(donnees[,8] < 16)) {
    top15trials = c(top15trials, fichiers[k])
  }
}
rm(donnees)

### Task 01 - Fraction of congruent gates: left-left and right-right###

nbtop15 = length(top15trials)
#print(nbtop15)
left_left = 0
right_right = 0
not_the_case = 0
yellow_ll = 0
yellow_rr = 0
blue_ll = 0
blue_rr = 0
other_one = 0
nb_yellow = 0
nb_blue = 0

for (k in 1:nbtop15) {
  data_top15 = read.csv(top15trials[k], header = TRUE)
  fountain_visits = subset(data_top15, comp == "fountain_left" | comp == "fountain_right")

  if (nrow(fountain_visits) == 0) {
    next
  }

  first_fountain_visit = fountain_visits[which.min(fountain_visits$t.f), ]
  cote_reinforce = unique(first_fountain_visit$cote.renforce)[1]
  color = unique(first_fountain_visit$coul.renforcee)[1]
  if (color == "yellow") {
    nb_yellow = nb_yellow + 1
  }
  else if (color == "blue") {
    nb_blue = nb_blue + 1
  }
  else {
    print(NA)
  }

  ### Task 01 ###
  if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left") {
    left_left = left_left + 1
  }
  else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right") {
    right_right = right_right + 1
  }
  else {
    not_the_case = not_the_case + 1
  }

  ### Task 02 ###
  if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left" & color == "yellow") {
    yellow_ll = yellow_ll + 1
  }
  else if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left" & color == "blue") {
    blue_ll = blue_ll + 1
  }
  else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right" & color == "yellow") {
    yellow_rr = yellow_rr + 1
  }
  else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right" & color == "blue") {
    blue_rr = blue_rr + 1
  }
  else {
    other_one = other_one + 1
  }

}


print(paste("01. Left-left: ", left_left, ", Right-right: ", right_right, ", Not the case: ", not_the_case))
fraction_fountain_reinforce = (left_left + right_right) / nbtop15
print(paste("02. Fraction of gate and fountain:", fraction_fountain_reinforce))

vec_rep_01 = rep(x=1, times = left_left+right_right)
vec_rep_02 = rep(x=0, times = not_the_case)
vec_total = c(vec_rep_01, vec_rep_02)

### Use function because we will calculate a lot of SEM ###
calculate_sd_se = function(vector) {
  if (length(vector) <= 1) {
    return(list(sd = NA, se = NA))
  }

  std = sd(vector)

  std_error = std / sqrt(length(vector))

  return(list(se = std_error))
}

result_vec_total = calculate_sd_se(vec_total)
print(paste("03. Standard error for first task", result_vec_total$se))

### Plot Stacked Graph ###
fraction_fountain_reinforce = (left_left + right_right) / nbtop15
not_congruent = 1 - fraction_fountain_reinforce

data_for_plot = data.frame(
  Category = c("Same comp - same fountain", "Not Congruent"),
  Fraction = c(fraction_fountain_reinforce, not_congruent)
)

ggplot(data_for_plot, aes(x = "", y = Fraction, fill = Category)) +
  geom_bar(stat = "identity", width = 0.5) +
  geom_text(aes(label = paste0(round(Fraction * 100, 1), "%")),
            position = position_stack(vjust = 0.5)) +
  labs(title = "Congruency Fraction of Reinforce side and fountains",
       y = "Fraction",
       x = "") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

### Bar graph ###

# Load ggplot2 for plotting
library(ggplot2)

# Create a data frame for the bar plot with error bars
data_for_plot <- data.frame(
  Category = "Same reinforce gate - Same fountain side",
  Fraction = fraction_fountain_reinforce,
  SE = result_vec_total$se
)

# Create the bar plot with error bars
ggplot(data_for_plot, aes(x = Category, y = Fraction)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  geom_errorbar(aes(ymin = Fraction - SE, ymax = Fraction + SE),
                width = 0.2, color = "black") +
  geom_text(aes(label = paste0(round(Fraction * 100, 1), "%")),
            vjust = -0.5) +
  labs(title = "Fraction of congruency effect of reinforced gate and the fountain side with SEM",
       y = "Fraction",
       x = "") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

### Task 02 ###

print(paste("04. Y-L-L: ", yellow_ll, ", B-L-L: ", blue_ll, ", Y-R-R: ", yellow_rr, ", B-R-R: ", blue_rr))
print(paste("05. Not the case: ", other_one))
print(paste("06. Case with yellow", nb_yellow, ", Case with blue", nb_blue))
fraction_yellow_fountain_reinforced = (yellow_ll + yellow_rr) / nb_yellow
fraction_blue_fountain_reinforced = (blue_ll + blue_rr) / nb_blue
print(paste("07. Fraction of color blue, gate and fountain:", fraction_blue_fountain_reinforced))
print(paste("08. Fraction of color yellow, gate and fountain:", fraction_yellow_fountain_reinforced))

vec_yel01 = rep(x=1, times = yellow_ll+yellow_rr)
vec_yel00 = rep(x=0, times = nb_yellow)
vec_yel = c(vec_yel01, vec_yel00)
vec_blu01 = rep(x=1, times = blue_ll+blue_rr)
vec_blu00 = rep(x=0, times = nb_blue)
vec_blu = c(vec_blu00, vec_blu01)

result_vec_yel = calculate_sd_se(vec_yel)
print(paste("09. Standard error for merg_vector is", result_vec_yel$se))
result_vec_blu = calculate_sd_se(vec_blu)
print(paste("10. Standard error for merg_vector is", result_vec_blu$se))

data_for_plot <- data.frame(
  Category = c("Yellow Gates", "Blue Gates"),
  Fraction = c(fraction_yellow_fountain_reinforced, fraction_blue_fountain_reinforced),
  SE = c(result_vec_yel$se, result_vec_blu$se)
)

ggplot(data_for_plot, aes(x = Category, y = Fraction)) +
  geom_bar(stat = "identity", fill = c("yellow", "blue"), width = 0.5) +
  geom_errorbar(aes(ymin = Fraction - SE, ymax = Fraction + SE),
                width = 0.2, color = "black") +
  geom_text(aes(label = paste0(round(Fraction * 100, 1), "%")),
            vjust = -0.5) +
  labs(title = "Fraction of Reinforced effect of colour and side on the fountain",
       y = "Fraction",
       x = "") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

#### Task 03 ###
### We extract the data of the gate_test, take the time of gate_test that smaller
### than the time of first fountain visit, then take the max value gate_test time
### We calculate then the latency = fountain time - gate_test time for each trials

### If the code doesn't work - print the line 204 - 205 in the terminal/console

library(survival)
library(survminer)

list_latency_1 <- c()
list_latency_5 <- c()
list_latency_10 <- c()
list_latency_15 <- c()

for (k in 1:nbtop15) {
  data_top15 = read.csv(top15trials[k], header = TRUE)

  for (trial in c(1, 5, 10, 15)) {
    trial_data = subset(data_top15, essai == trial)

    if (nrow(trial_data) > 0) {
      fountain_times = trial_data$t.f[trial_data$comp %in% c('fountain_left', 'fountain_right')]

      if (length(fountain_times) > 0) {
        first_fountain_time = min(fountain_times, na.rm = TRUE)
        gate_times = trial_data$t.f[trial_data$comp == 'gate_test']
        valid_gate_times = gate_times[gate_times < first_fountain_time]

        if (length(valid_gate_times) > 0) {
          last_gate_test_time = max(valid_gate_times, na.rm = TRUE)
          latency = first_fountain_time - last_gate_test_time

          if (latency > 0) {
            if (trial == 1) {
              list_latency_1 = c(list_latency_1, latency)
            } else if (trial == 5) {
              list_latency_5 = c(list_latency_5, latency)
            } else if (trial == 10) {
              list_latency_10 = c(list_latency_10, latency)
            } else if (trial == 15) {
              list_latency_15 = c(list_latency_15, latency)
            }
          }
        }
      }
    }
  }
}


### Create the survival curve ###
### 01. Create first the data frame with all the latency-trial lists
### Here: https://biostatistique.vetagro-sup.fr/guideR_Cox.pdf
### 02. Create Survival Object -> Compute the survival curve with fit Kaplan - No idea =))


latency_data = data.frame(
  Latency = c(list_latency_1, list_latency_5, list_latency_10, list_latency_15),
  Trial = factor(c(rep(1, length(list_latency_1)),
                   rep(5, length(list_latency_5)),
                   rep(10, length(list_latency_10)),
                   rep(15, length(list_latency_15))))
)

#print(latency_data)

surv_obj = Surv(time = latency_data$Latency)

fit = survfit(Surv(Latency) ~ Trial, data = latency_data)

### 03. Print the table to check the time each bee reach the zone ###
print(summary(fit))

### 04. Plot plot plot ###

### Plot moche ###
plot(fit, mark.time = TRUE, palette = c("#E7B800", "#2E9FDF", "#D95F02", "#7570B3"), title = "Survival Curves for Latency by Trial",
xlab = "Time (seconds)",
ylab = "Proportion of Bees Not Reaching Fountain"
)

### Joli plot =)) ###
ggsurvplot(fit,
           data = latency_data,
           risk.table = TRUE,
           pval = TRUE,
           conf.int = TRUE,
           ggtheme = theme_minimal(),
           palette = c("#E7B800", "#2E9FDF", "#D95F02", "#7570B3"),
           title = "Survival Curves for Latency by Trial",
           xlab = "Time (seconds)",
           ylab = "Proportion of Bees Not Reaching Fountain")


### Task 04
### We extract the data of the gate_test, take the time of gate_test that smaller
### than the time of first fountain visit, then take the max value gate_test time
### We calculate then the latency = fountain time - gate_test time for each trials
### Then we add the latency in the group only if they are congruent (yll - yrr - bll - brr)
