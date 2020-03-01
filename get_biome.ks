
DECLARE FUNCTION get_biome {
  //TODO: find biome by kerbnet?
  RETURN SHIP:PARTSNAMED("SurfaceScanner")[0]:GETMODULE("ModuleGPS"):GETFIELD("Biome").
}.