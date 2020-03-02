DECLARE biome_file_name TO "biomes.json".
//DECLARE FUNCTION log_biome {
  IF NOT EXISTS(biome_file_name){
    WRITEJSON(LEXICON(),biome_file_name).
  }.
  SET L TO READJSON(biome_file_name).
  PRINT L.
  DECLARE biome to SHIP:PARTSNAMED("SurfaceScanner")[0]:GETMODULE("ModuleGPS"):GETFIELD("Biome").
  IF L:HASKEY(biome){
    PRINT biome + ":" + L[biome].
  }
  ELSE {
    PRINT "FoundBiome".
    L:ADD(biome, "FOUND").
    WRITEJSON(L, biome_file_name).
  }.

//}.