# Convert PheCodes to ICD-10 codes, and vice versa, and identify corresponding exclusion codes

R scripts and resources to:
- Convert list of PheCodes to ICD-10 codes, and vice versa
- Produce list of exclusion codes corresponding to inputted PheCodes or ICD-10 codes
- Output PheCode definition of provided PheCode.

Similar to Python script available at https://github.com/spiros/phemap, but made to use with R.

This script enquires the PheCode definitions file and PheCode-to-ICD-10 mapping file stored in this directory. The latest versions of both files are available at https://phewascatalog.org/phecodes.

## How to use

### Set-up

On an R session, run the following command:
```

```
This will copy the PheCode definitions and mapping files from this directory into your R session, and make all functions below available for use in R.

### Available functions

`PheCode_to_ICD` Extracts ICD-10 codes for a list of inputted PheCodes from the PheCode-to-ICD-10 mapping file.

`ICD_to_PheCode` Extracts PheCodes for a list of inputted ICD-10 codes from the PheCode-to-ICD-10 mapping file. ICD-10 codes need to be entered as characters.

`exclusion_code` Produces list of exclusion codes (in PheCode or ICD-10 format, based on function arguments) corresponding to inputted PheCode or ICD-10 codes. ICD-10 codes, if used, need to be entered as characters.

`PheCode_defn` Outputs the PheCode definition for an inputted PheCode from the PheCode definitions file.

### Examples

```
PheCode_to_ICD(c(250.1,250.2))
ICD_to_PheCode("E11")
exclusion_code(PheCode = "", ICD = c("E10", "E11"), output = "ICD")
PheCode_defn(250.2)
```
The `exclusion_code` function allows PheCodes or ICD-10 codes, or both, to be inputted. The argument `output` requires either `"PheCode"` or `"ICD"` to determine the format of exclusion codes to be output - the default is PheCode.
