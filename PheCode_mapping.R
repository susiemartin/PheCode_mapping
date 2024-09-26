# PheCode mapping R script
# Susie Martin
# 23 September 2024
# Similar to Python script at https://github.com/spiros/phemap

# Read in PheCode mapping and definition files
download.file(url = "https://raw.githubusercontent.com/susiemartin/PheCode_to_ICD10/refs/heads/main/Phecode_map_v1_2_icd10_beta.csv",
              destfile = "Phecode_map_v1_2_icd10_beta.csv", method = "curl")

download.file(url = "https://raw.githubusercontent.com/susiemartin/PheCode_to_ICD10/refs/heads/main/phecode_definitions1.2.csv",
              destfile = "phecode_definitions1.2.csv", method = "curl")

mapdata <- read.csv("Phecode_map_v1_2_icd10_beta.csv", header = TRUE, stringsAsFactors = FALSE)
defdata <- read.csv("phecode_definitions1.2.csv", header = TRUE, stringsAsFactors = FALSE)

# Function to map PheCodes to ICD-10 codes
PheCode_to_ICD <- function(phecodes) {
  icdcodes <- NULL
  for (i in 1:length(phecodes)) {
    subicdcodes <- mapdata[!is.na(mapdata$PHECODE) & startsWith(as.character(mapdata$PHECODE), as.character(phecodes[i])),]$ICD10
    icdcodes <- unique(c(icdcodes, subicdcodes))
  }
  icdcodes
}

# Function to map ICD-10 codes to PheCodes
ICD_to_PheCode <- function(icdcodes) {
  phecodes <- NULL
  for (i in 1:length(icdcodes)) {
    subphecodes <- mapdata[!is.na(mapdata$ICD10) & startsWith(as.character(mapdata$ICD10), as.character(icdcodes[i])),]$PHECODE
    phecodes <- unique(c(phecodes, subphecodes))
  }
  phecodes
}

# Function to extract exclusion codes based on inputted PheCode/ICD-10 codes
exclusion_code <- function(PheCode = "", ICD = "", output = "PheCode") {
  if ((missing(PheCode) | PheCode == "") & (missing(ICD) | ICD == "")) {
    stop("Must provide input into either PheCode or ICD arguments, or both")
  }
  if (!(output %in% c("PheCode", "ICD"))) {
    stop("Argument output can only be given values PheCode or ICD. Default is PheCode")
  }
  exclcodes1 <- exclcodes2 <- NULL
  if (!(missing(PheCode)) & PheCode != "") {
    for (i in 1:length(PheCode)) {
      subexclcodes1 <- mapdata[!is.na(mapdata$PHECODE) & startsWith(as.character(mapdata$PHECODE), as.character(PheCode[i])),]$Exl..Phecodes
      exclcodes1 <- unique(c(exclcodes1, subexclcodes1))
    }
  }
  if (!(missing(ICD)) & ICD != "") {
    for (i in 1:length(ICD)) {
      subexclcodes2 <- mapdata[!is.na(mapdata$ICD10) & startsWith(as.character(mapdata$ICD10), as.character(ICD[i])),]$Exl..Phecodes
      exclcodes2 <- unique(c(exclcodes2, subexclcodes2))
    }
  }
  exclcodes <- unique(c(exclcodes1, exclcodes2))
  if (length(exclcodes) > 0) {
    if (any(grepl(",", exclcodes))) {
      exclcodes <- c(unlist(strsplit(exclcodes, ",")))
      exclcodes <- trimws(exclcodes)
    }
    outdata <- NULL
    for (i in 1:length(exclcodes)) {
      mincode <- unlist(strsplit(exclcodes[i], "-"))[1]
      maxcode <- unlist(strsplit(exclcodes[i], "-"))[2]
      subdata <- mapdata[!is.na(mapdata$PHECODE) & mapdata$PHECODE >= mincode & mapdata$PHECODE <= maxcode,]
      outdata <- rbind(outdata, subdata)
    }
  }
  if (output == "PheCode") {
    exclcodes <- unique(outdata$PHECODE)
  } else {
    exclcodes <- unique(outdata$ICD10)
  }
  exclcodes
}

# Function to output PheCode definition of provided PheCode
PheCode_defn <- function(phecodes) {
  phedefs <- defdata[defdata$phecode %in% phecodes,]
  phedefs
}

