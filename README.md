# PheCode mapping: Convert PheCodes to ICD-10 codes, and vice versa, and extract corresponding exclusion codes

R scripts and resources to:
- Convert list of PheCodes to ICD-10 codes, and vice versa
- Produce list of exclusion codes corresponding to inputted PheCodes or ICD-10 codes
- Output PheCode definition of provided PheCode.

Similar to Python script available at https://github.com/spiros/phemap, but made to use with R.

This script requires the PheCode definitions file and PheCode-to-ICD-10 mapping file stored in this directory. The latest versions of both files are available at https://phewascatalog.org/phecodes.

## How to use

### Set-up

On an R session, run the following command:
```
library(devtools)
source_url("https://raw.githubusercontent.com/susiemartin/PheCode_mapping/refs/heads/main/PheCode_mapping.R") 
```
This will copy the PheCode definition and mapping files from this directory into your R session, and make all functions below available for use in R.

### Available functions

`PheCode_to_ICD` Extracts ICD-10 codes for a list of inputted PheCodes from the PheCode-to-ICD-10 mapping file.

`ICD_to_PheCode` Extracts PheCodes for a list of inputted ICD-10 codes from the PheCode-to-ICD-10 mapping file. ICD-10 codes need to be entered as characters.

`exclusion_code` Identifies exclusion codes (in PheCode or ICD-10 format, based on function argument) corresponding to inputted PheCode or ICD-10 codes. ICD-10 codes, if used, need to be entered as characters. More detail below.

`PheCode_defn` Outputs the PheCode definition for an inputted PheCode from the PheCode definitions file.

**Note:** As PheCodes are hierarchical<sup>1</sup>, using the PheCode 250 in functions `PheCode_to_ICD` and `exclusion_code` will search for all PheCodes of form 250* including 250.1, 250.2, 250.21, etc. ICD-10 codes are dealt with in a similar manner. The `PheCode_defn` function however will output only the definitions for the specific PheCodes entered.

### Examples

```
icdcodes <- PheCode_to_ICD(c(250.1,250.2))
phecodes <- ICD_to_PheCode("E11")
exclcodes <- exclusion_code(PheCode = "", ICD = c("E10", "E11"), output = "ICD")
PheCode_defn(250.2)
```
The `exclusion_code` function allows PheCodes or ICD-10 codes, or both, to be inputted. The `output` argument requires either `"PheCode"` or `"ICD"` to determine the format of exclusion codes to be output - the default is PheCode.

### References

1. Bastarache L. Using phecodes for research with the electronic health record: from PheWAS to PheRS. Annual review of biomedical data science. 2021 Jul 20;4(1):1-9.
