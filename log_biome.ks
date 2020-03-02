DECLARE biome_file_name TO "biomes.json".
DECLARE file_changes TO false.
//DECLARE FUNCTION log_biome {
  DECLARE gps TO SHIP:PARTSNAMED("SurfaceScanner")[0]:GETMODULE("ModuleGPS").

  DECLARE biome TO GPS:GETFIELD("Biome").
  SET biomes TO LEXICON().
  IF EXISTS(biome_file_name) {
    SET biomes TO READJSON(biome_file_name).
  }
  PRINT biomes.
  IF NOT biomes:HASKEY(body) {
    biomes:ADD(body, LEXICON()).
    SET file_changes TO true.
  }.
  IF NOT biomes[body]:HASKEY(biome) {
    //PRINT "Found NEW Biome".
    biomes[body]:ADD(biome, LEXICON()).
    SET file_changes TO true.
  }.
  //PRINT body + ":" + biome + ":" + biomes[body][biome].
  DECLARE sensor1 TO "sensorGravimeter".
  IF NOT biomes[body][biome]:haskey(sensor1) {
    //PRINT "tobelogged".
    biomes[body][biome]:ADD(sensor1, "ToBeLogged").
    SET file_changes TO true.
  }
  IF NOT (biomes[body][biome][sensor1] = "LOGGED") {
    //LOGGRAVITY
    //PRINT "LOGGING".
    DECLARE grav TO SHIP:PARTSDUBBED(sensor1)[0]:GETMODULE("ModuleScienceExperiment").
    grav:DOACTION("delete data", true).
    grav:DEPLOY.
    wait 1.
    //PRINT SHIP:PARTSDUBBED("probeStackSmall")[0]:ALLMODULES.
    DECLARE probe TO SHIP:PARTSDUBBED("probeStackSmall")[0]:GETMODULE("ModuleScienceContainer").
    probe:DOACTION("collect all", true).
    grav:DOACTION("delete data", true).
    SET biomes[body][biome][sensor1] TO "Logged".
    SET file_changes TO true.
  }
  ELSE {
    //PRINT "NOT LAGGING".
  }.
  if file_changes {
    WRITEJSON(biomes, biome_file_name).
  }.

//}.