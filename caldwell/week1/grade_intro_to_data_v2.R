# Auto-grading script for "Introduction to Data in R" learnr tutorial
# Author: Aaron Caldwell
# Usage: Source this script and call grade_submissions("path/to/blackboard_export.csv")

library(tidyverse)
library(learnrhash)
library(janitor)
# Expected exercise chunks from intro-to-data.Rmd
EXPECTED_EXERCISES <- c(

  "load-packages",
  "glimpse-hsb2",
  "glimpse-email50",
  "hsb2-count-schtyp",
  "hsb2-filter-schtyp-public",
  "hsb2-count-schtyp-again",
  "email50-filter-number-big",
  "hsb2-mean-read",
  "hsb2-mean-read-assign",
  "hsb2-mean-read-assign-show",
  "hsb2-mutate-read-cat",
  "hsb2-mutate-num-char-cat",
  "email50-fortified",
  "hsb2-science-math",
  "hsb2-science-math-prog",
  "email50-plot"
)


# Function to clean hash from Blackboard HTML
clean_blackboard_hash <- function(hash_string) {
  cleaned <- gsub("<[^>]+>", "", hash_string)
  cleaned <- gsub("\\s+", "", cleaned)
  cleaned <- trimws(cleaned)
  return(cleaned)
}

# CORRECTED grading function
grade_completion <- function(hash, required_questions) {
  tryCatch({
    clean_hash <- clean_blackboard_hash(hash)
    decoded <- decode_obj(clean_hash)

    # Get the actual question labels from the label column
    answered <- decoded$label

    # Check if all required questions were answered
    completion <- mean(required_questions %in% answered)

    return(data.frame(
      completed = completion == 1,
      completion_rate = completion,
      questions_answered = length(answered)
    ))
  }, error = function(e) {
    return(data.frame(
      completed = FALSE,
      completion_rate = 0,
      questions_answered = 0,
      error_msg = as.character(e$message)
    ))
  })
}

# Load student submissions
submissions <- read_csv(here::here("caldwell", "week1", "week1_26.csv")) %>%
  clean_names() %>%
  mutate(hash = answer_5)

# Define your required questions
required <- EXPECTED_EXERCISES

# Grade all submissions
results <- submissions %>%
  rowwise() %>%
  mutate(grade_completion(hash, required)) %>%
  select(last_name, first_name, completed, completion_rate, questions_answered)
