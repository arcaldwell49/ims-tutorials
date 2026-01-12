# Auto-grading script for "Introduction to Data in R" learnr tutorial
# Author: Generated for Aaron Caldwell
# Usage: Source this script and call grade_submissions("path/to/blackboard_export.csv")

library(tidyverse)
library(learnrhash)

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

#' Decode a single hash and extract completion info
#' @param hash_string The encoded hash from learnrhash
#' @return A list with student info and exercise completion, or NULL if decode fails
decode_submission <- function(hash_string) {
  if (is.na(hash_string) || hash_string == "") {
    return(NULL)
  }

  tryCatch({
    decoded <- learnrhash::decode_obj(hash_string)

    # Extract student identifiers
    student_info <- decoded |>
      filter(type == "identifier") |>
      select(label, answer) |>
      mutate(answer = as.character(answer)) |>
      pivot_wider(names_from = label, values_from = answer)

    # Extract exercise submissions (type == "exercise")
    exercises <- decoded |>
      filter(type == "exercise") |>
      pull(label)

    list(
      student_name = student_info$student_name %||% NA_character_,
      student_id = student_info$student_id %||% NA_character_,
      exercises_completed = exercises
    )
  }, error = function(e) {
    NULL
  })
}

#' Grade all submissions from a Blackboard export CSV
#' @param csv_path Path to the Blackboard export CSV
#' @param expected_exercises Vector of expected exercise chunk names (defaults to EXPECTED_EXERCISES)
#' @param hash_column Name of the column containing the hash (default: "Answer 5")
#' @return A tibble with grading results
grade_submissions <- function(csv_path,
                               expected_exercises = EXPECTED_EXERCISES,
                               hash_column = "answer_5") {

  # Read Blackboard export

  submissions <- read_csv(csv_path, show_col_types = FALSE)

  # Process each submission
  results <- submissions |>
    janitor::clean_names() |>
    rowwise() |>
    mutate(
      decoded = list(decode_submission(.data[[hash_column]]))
    ) |>
    ungroup()

  # Build grading output
  graded <- results |>
    mutate(
      # From Blackboard
      bb_username = username,
      bb_last_name = `last_name`,
      bb_first_name = `first_name`,


      # From decoded hash
      hash_student_name = map_chr(decoded, ~ .x$student_name %||% NA_character_),
      hash_student_id = map_chr(decoded, ~ .x$student_id %||% NA_character_),

      # Grading
      decode_success = map_lgl(decoded, ~ !is.null(.x)),
      exercises_completed = map(decoded, ~ .x$exercises_completed %||% character(0)),
      n_completed = map_int(exercises_completed, length),
      n_expected = length(expected_exercises),
      pct_complete = round(100 * n_completed / n_expected, 1),

      # Which exercises are missing?
      missing_exercises = map_chr(exercises_completed, function(completed) {
        missing <- setdiff(expected_exercises, completed)
        if (length(missing) == 0) "" else paste(missing, collapse = "; ")
      })
    ) |>
    select(
      bb_username,
      bb_first_name,
      bb_last_name,
      hash_student_name,
      hash_student_id,
      decode_success,
      n_completed,
      n_expected,
      pct_complete,
      missing_exercises
    )

  graded
}

#' Convenience function to grade and save results
#' @param csv_path Path to the Blackboard export CSV
#' @param output_path Path for output CSV (default: adds "_graded" to input filename)
#' @return The graded tibble (invisibly)
grade_and_save <- function(csv_path, output_path = NULL) {
  if (is.null(output_path)) {
    output_path <- str_replace(csv_path, "\\.csv$", "_graded.csv")
  }

  graded <- grade_submissions(csv_path)
  write_csv(graded, output_path)

  # Print summary

  cat("\n=== Grading Summary ===\n")
  cat("Total submissions:", nrow(graded), "\n")
  cat("Successful decodes:", sum(graded$decode_success), "\n")
  cat("Failed decodes:", sum(!graded$decode_success), "\n")
  cat("\nScore distribution:\n")
  print(summary(graded$pct_complete))
  cat("\nResults saved to:", output_path, "\n")

  invisible(graded)
}

# If running interactively, show usage
if (interactive()) {
  message("Grading functions loaded. Usage:")
  message('  results <- grade_submissions("path/to/blackboard_export.csv")')
  message('  grade_and_save("path/to/blackboard_export.csv")')
}
