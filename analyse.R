### CLEAN THE DATA ###
rm(list=ls())

### Get the data trials < 16 ###
get_top15_trials = function(data_path) {
  fichiers = list.files(data_path, pattern = "\\.csv$", full.names = TRUE)
  top15trials = c()

  for (file in fichiers) {
    data = read.csv(file, header = TRUE, sep = ",", dec = ".", fill = TRUE)
    if (any(data$essai < 16, na.rm = TRUE)) {
      top15trials = c(top15trials, file)
    }
  }

  return(top15trials)
}

### SEM ###
calculate_sd_se = function(vector) {
  if (length(vector) <= 1) {
    return(list(sd = NA, se = NA))
  }

  std = sd(vector, na.rm = TRUE)
  std_error = std / sqrt(length(vector))

  return(se = std_error)
}

### For Task 01 and 02
count_congruent_gates_fountain = function(file_list) {
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

  for (file in file_list) {
    data = read.csv(file, header = TRUE)

    fountain_visits = subset(data, comp %in% c("fountain_left", "fountain_right"))

    if (nrow(fountain_visits) == 0) {
      next
    }

    first_fountain_visit = fountain_visits[which.min(fountain_visits$t.f), ]

    cote_reinforce = unique(first_fountain_visit$cote.renforce)
    color = unique(first_fountain_visit$coul.renforcee)

    if (color == "yellow") {
      nb_yellow = nb_yellow + 1
    } else if (color == "blue") {
      nb_blue = nb_blue + 1
    }

    # Task 01 : ll & rr #
    if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left") {
      left_left = left_left + 1
    } else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right") {
      right_right = right_right + 1
    } else {
      not_the_case = not_the_case + 1
    }

    # Task 02 : yll - yrr - bll - brr #
    if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left" & color == "yellow") {
      yellow_ll = yellow_ll + 1
    } else if (cote_reinforce == "left" & first_fountain_visit$comp == "fountain_left" & color == "blue") {
      blue_ll = blue_ll + 1
    } else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right" & color == "yellow") {
      yellow_rr = yellow_rr + 1
    } else if (cote_reinforce == "right" & first_fountain_visit$comp == "fountain_right" & color == "blue") {
      blue_rr = blue_rr + 1
    } else {
      other_one = other_one + 1
    }
  }

  # Fraction Task 01 and Task 02 #
  nbtop15 = length(file_list)
  fraction_fountain_reinforce = (left_left + right_right) / nbtop15
  fraction_yellow_fountain_reinforced = (yellow_ll + yellow_rr) / nb_yellow
  fraction_blue_fountain_reinforced = (blue_ll + blue_rr) / nb_blue

  # SEM Calculation
  vec_fountain_reinforce = c(rep(1, left_left + right_right), rep(0, not_the_case))
  vec_yellow = c(rep(1, yellow_ll + yellow_rr), rep(0, nb_yellow - (yellow_ll + yellow_rr)))
  vec_blue = c(rep(1, blue_ll + blue_rr), rep(0, nb_blue - (blue_ll + blue_rr)))

  sem_fountain_reinforce = calculate_sd_se(vec_fountain_reinforce)
  sem_yellow = calculate_sd_se(vec_yellow)
  sem_blue = calculate_sd_se(vec_blue)

  return(list(
    fraction_fountain_reinforce = fraction_fountain_reinforce,
    fraction_yellow_fountain_reinforced = fraction_yellow_fountain_reinforced,
    fraction_blue_fountain_reinforced = fraction_blue_fountain_reinforced,
    sem_fountain_reinforce = sem_fountain_reinforce,
    sem_yellow = sem_yellow,
    sem_blue = sem_blue
  ))
}

### Task 03 - 04 ###
calculate_latency = function(file_list, trials = c(1, 5, 10, 15), condition = NULL) {
  ### For task 03
  latency_1 = c()
  latency_5 = c()
  latency_10 = c()
  latency_15 = c()

  ### For task 04
  congruent_latency = list(trial_1 = c(), trial_5 = c(), trial_10 = c(), trial_15 = c())
  incongruent_latency = list(trial_1 = c(), trial_5 = c(), trial_10 = c(), trial_15 = c())

  for (file in file_list) {
    data = read.csv(file, header = TRUE)

    for (trial in trials) {
      trial_data = subset(data, essai == trial)
      if (nrow(trial_data) == 0) next

      relevant_data = subset(trial_data, comp %in% c("fountain_left", "fountain_right", "gate_test"))
      if (nrow(relevant_data) == 0) next

      fountain_visits = subset(relevant_data, comp %in% c("fountain_left", "fountain_right"))
      if (nrow(fountain_visits) == 0) next

      first_fountain_visit = fountain_visits[which.min(fountain_visits$t.f), ]
      first_fountain_time = first_fountain_visit$t.f
      cote_reinforce = unique(first_fountain_visit$cote.renforce)[1]
      fountain_side = first_fountain_visit$comp

      is_congruent = (cote_reinforce == "left" & fountain_side == "fountain_left") |
                     (cote_reinforce == "right" & fountain_side == "fountain_right")

      gate_test_times = relevant_data$t.f[relevant_data$comp == "gate_test" & relevant_data$t.f < first_fountain_time]
      if (length(gate_test_times) == 0) next
      last_gate_test_time = max(gate_test_times, na.rm = TRUE)

      latency_fps = first_fountain_time - last_gate_test_time
      latency_seconds = latency_fps / 10  # Convert to seconds

      if (latency_seconds > 0) {
        if (is.null(condition)) {
          if (trial == 1) {
            latency_1 = c(latency_1, latency_seconds)
          } else if (trial == 5) {
            latency_5 = c(latency_5, latency_seconds)
          } else if (trial == 10) {
            latency_10 = c(latency_10, latency_seconds)
          } else if (trial == 15) {
            latency_15 = c(latency_15, latency_seconds)
          }
        } else {
          if (is_congruent) {
            if (trial == 1) {
              congruent_latency$trial_1 = c(congruent_latency$trial_1, latency_seconds)
            } else if (trial == 5) {
              congruent_latency$trial_5 = c(congruent_latency$trial_5, latency_seconds)
            } else if (trial == 10) {
              congruent_latency$trial_10 = c(congruent_latency$trial_10, latency_seconds)
            } else if (trial == 15) {
              congruent_latency$trial_15 = c(congruent_latency$trial_15, latency_seconds)
            }
          } else {
            if (trial == 1) {
              incongruent_latency$trial_1 = c(incongruent_latency$trial_1, latency_seconds)
            } else if (trial == 5) {
              incongruent_latency$trial_5 = c(incongruent_latency$trial_5, latency_seconds)
            } else if (trial == 10) {
              incongruent_latency$trial_10 = c(incongruent_latency$trial_10, latency_seconds)
            } else if (trial == 15) {
              incongruent_latency$trial_15 = c(incongruent_latency$trial_15, latency_seconds)
            }
          }
        }
      }
    }
  }

  if (is.null(condition)) {
    average_latency_1 = mean(latency_1, na.rm = TRUE)
    average_latency_5 = mean(latency_5, na.rm = TRUE)
    average_latency_10 = mean(latency_10, na.rm = TRUE)
    average_latency_15 = mean(latency_15, na.rm = TRUE)

    return(list(
      latency_1 = latency_1, average_latency_1 = average_latency_1,
      latency_5 = latency_5, average_latency_5 = average_latency_5,
      latency_10 = latency_10, average_latency_10 = average_latency_10,
      latency_15 = latency_15, average_latency_15 = average_latency_15
    ))
  } else {
    congruent_avg = sapply(congruent_latency, function(x) mean(x, na.rm = TRUE))
    incongruent_avg = sapply(incongruent_latency, function(x) mean(x, na.rm = TRUE))

    return(list(
      congruent = congruent_avg,
      incongruent = incongruent_avg
    ))
  }
}



### Task 05 ###
calculate_average_speed = function(file_list, trials = c(1, 5, 10, 15)) {
  trial_speeds_list = list()

  for (file in file_list) {
    data = read.csv(file, header = TRUE)

    data$x.cm = data$x.px / 75
    data$y.cm = data$y.px / 75

    for (trial in trials) {
      trial_data = subset(data, essai == trial)

      if (nrow(trial_data) == 0) next

      gate_point = trial_data[trial_data$comp == "gate_test", ]
      if (nrow(gate_point) == 0) next
      gate_point = gate_point[which.max(gate_point$t.f), ]

      fountain_visits = trial_data[trial_data$comp %in% c("fountain_left", "fountain_right"), ]
      if (nrow(fountain_visits) == 0) next
      first_fountain_visit = fountain_visits[which.min(fountain_visits$t.f), ]

      distance_cm = sqrt((first_fountain_visit$x.cm - gate_point$x.cm)^2 +
                         (first_fountain_visit$y.cm - gate_point$y.cm)^2)

      time_taken_frames = first_fountain_visit$t.f - gate_point$t.f
      time_taken_seconds = time_taken_frames / 10

      if (time_taken_seconds == 0) next

      average_speed_cm_per_s = distance_cm / time_taken_seconds

      if (!is.null(trial_speeds_list[[as.character(trial)]])) {
        trial_speeds_list[[as.character(trial)]] = c(trial_speeds_list[[as.character(trial)]], average_speed_cm_per_s)
      } else {
        trial_speeds_list[[as.character(trial)]] = c(average_speed_cm_per_s)
      }
    }
  }

  results = list()
  for (trial in trials) {
    speeds = trial_speeds_list[[as.character(trial)]]
    if (length(speeds) > 1) {
      mean_speed = mean(speeds, na.rm = TRUE)
      se_speed = sd(speeds, na.rm = TRUE) / sqrt(length(speeds))
      results[[as.character(trial)]] = list(mean = mean_speed, se = se_speed)
    } else {
      results[[as.character(trial)]] = list(mean = NA, se = NA)
    }
  }

  return(results)
}


### PLOTS


### Plot survival curves
prepare_latency_data = function(latency_results) {
  latency_data = data.frame(
    Latency = c(latency_results$latency_1, latency_results$latency_5, latency_results$latency_10, latency_results$latency_15),
    Trial = factor(c(rep(1, length(latency_results$latency_1)),
                     rep(5, length(latency_results$latency_5)),
                     rep(10, length(latency_results$latency_10)),
                     rep(15, length(latency_results$latency_15))))
  )
  return(latency_data)
}

plot_survival_curve = function(latency_data) {
  library(survival)
  library(survminer)

  surv_obj = Surv(time = latency_data$Latency, event = rep(1, nrow(latency_data)))
  fit = survfit(surv_obj ~ Trial, data = latency_data)

  plot(fit,
       col = c("blue", "red", "green", "purple"),
       lwd = 2,
       lty = 1:4,
       main = "Survival Analysis for Bee Latency",
       xlab = "Time to Fountain (seconds)",
       ylab = "Proportion of Bees Not Reaching Fountain")

    legend("topright",
         legend = c("Trial 1", "Trial 5", "Trial 10", "Trial 15"),
         col = c("blue", "red", "green", "purple"),
         lwd = 2,
         lty = 1:4) }

### MAIN ###
data_path = "data/"
top15_trials = get_top15_trials(data_path)

### Task 01 and 02 ###
results = count_congruent_gates_fountain(top15_trials)
print(paste("01. Fraction of gate and fountain congruency:", results$fraction_fountain_reinforce, "with SEM ", results$sem_fountain_reinforce))
print(paste("02. Fraction of yellow gates:", results$fraction_yellow_fountain_reinforced, "With SEM ", results$sem_yellow))
print(paste("03. Fraction of blue gates:", results$fraction_blue_fountain_reinforced, "With SEM", results$sem_blue))

# For Task 03
latency_results_task03 = calculate_latency(top15_trials, condition = NULL)
print(paste("04. Average latency for trial 1:", latency_results_task03$average_latency_1))
print(paste("05. Average latency for trial 5:", latency_results_task03$average_latency_5))
print(paste("06. Average latency for trial 10:", latency_results_task03$average_latency_10))
print(paste("07. Average latency for trial 15:", latency_results_task03$average_latency_15))

# For Task 04
latency_results_task04 = calculate_latency(top15_trials, condition = TRUE)
print(paste("08. Average latency for trial 1 (congruent):", latency_results_task04$congruent["trial_1"]))
print(paste("09. Average latency for trial 5 (congruent):", latency_results_task04$congruent["trial_5"]))
print(paste("10. Average latency for trial 10 (congruent):", latency_results_task04$congruent["trial_10"]))
print(paste("11. Average latency for trial 15 (congruent):", latency_results_task04$congruent["trial_15"]))

print(paste("12. Average latency for trial 1 (incongruent):", latency_results_task04$incongruent["trial_1"]))
print(paste("13. Average latency for trial 5 (incongruent):", latency_results_task04$incongruent["trial_5"]))
print(paste("14. Average latency for trial 10 (incongruent):", latency_results_task04$incongruent["trial_10"]))
print(paste("15. Average latency for trial 15 (incongruent):", latency_results_task04$incongruent["trial_15"]))

### Task 05 ###
speed_results = calculate_average_speed(top15_trials)
for (trial in c(1, 5, 10, 15)) {
  trial_result = speed_results[[as.character(trial)]]
  print(paste("Average speed in trial", trial, ":", trial_result$mean, "±", trial_result$se))
}
