---
title: "README"
author: "Jim v.M."
output: html_document
---

# Contents of this gitHub Repository

1. ReadMe.md (THIS FILE!)
2. CodeBook.md
      - informs the reader about the raw and tidy data.
3. run_analysis.R
      - performs the tidying of the data.

# CodeBook

The CodeBook contains: 

1. a description of the study design used to collect the raw data.
2. a URL to the raw data.
3. a pseudo-coded version of `run_analysis.R`.
3. a description of the final tidy dataset and the variables in it.

# Script

The script `run_analysis.R` stores the tidied data in a file tidy_table.txt in the current working directory. It requires that the `dplyr` package is installed.  

To load the tidy dataset into R's memory use: `read.table(file = "./tidy_table.txt", header = T)`.
