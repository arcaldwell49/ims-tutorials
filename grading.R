
hash1 = "QlpoOTFBWSZTWaCgIIcAANZ/wP/2SIhBY3bwKQAGQL+v3+BAAAADsAEWM0NTVPCIMI00DINNNAA0yA9E9QNTJNT1NNPaUHqAAAAAAA0DaUmiAIMEYRkyMRiekwCaaDPhoGKI0esBEBEtZsJQGElDsXN1uIOnHtaAg7lIgxs6zQEI72k9e6CquWvx5RczjK9rsKampGkeACYIpsIDBJRaUWpGhJTvGxsRFnYfGdSdVzr+5oJ+6Tb+eR8tmolZ26DXp0qCmGUFPYgilKHtGnNCaKgCkB0x2SazFLkXq4GV18IDccagsJO5RIlHSsHHsp64CsW1odAVMTGWWEFtKEz8IeuiGkEbGwYIBiO199zwEK658cjCAmV6BSuOGjg6NUKQNsHemsWCuEHtiXUlwvkEtzywJDhJHp4Xn0OvBMXcOM/HIF/F3JFOFCQoKAghwA=="
hash = hash1


library(learnrhash)
library(tidyverse)

# Load student submissions (from CSV, Google Sheets, etc.)
#submissions <- read_csv("student_hashes.csv")

grade_completion <- function(hash, required_questions) {
  tryCatch({
    decoded <- decode_obj(hash)
    answered <- decoded$label

    # Check if all required questions were answered
    completion <- mean(required_questions %in% answered)

    return(data.frame(
      completed = completion == 1,
      completion_rate = completion,
      hash_length = length(answered)
    ))
  }, error = function(e) {
    return(data.frame(
      completed = FALSE,
      completion_rate = 0,
      questions_answered = 0))
  })
}

# Define your required questions (must match your learnr exercise labels)
required_questions <- c("load-packages")

# Grade all submissions
grade_completion(hash, required)
