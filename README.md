# Mathematica-CZI
Mathematica package to read Zeiss CZI metadata

## Usage
### 1. CZIMetaData
Use the function to extract CZI metadata from the given file path:
```
In:   CZIMetaData["~/Desktop/Image 78.czi"] 
Out:  (Mathematica XML object of the metadata)
```
### 2. CZIBlockTable
Use the function to look up the table of the blocks of the given file path:
```
In:   CZIBlockTable["~/Desktop/Image 78.czi"]
Out:  {{"ZISRAWFILE", 0, 512, 512}, {"ZISRAWSUBBLOCK", 544, 131328, 131328},
      {"ZISRAWSUBBLOCK", 131904, 131328, 131328}, {"ZISRAWMETADATA", 263264, 21600, 21600},
      {"ZISRAWATTACH", 284896, 106144, 106134}, {"ZISRAWATTACH", 391072, 3584, 3584},
      {"ZISRAWATTACH", 394688, 288, 272}, {"ZISRAWATTACH", 395008, 288, 264},
      {"ZISRAWDIRECTORY", 395328, 448, 432}, {"ZISRAWATTDIR", 395808, 768, 768}}
```
