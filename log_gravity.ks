
DECLARE biome TO SHIP:PARTSNAMED("SurfaceScanner")[0]:GETMODULE("ModuleGPS"):GETFIELD("Biome").
IF biome = "NEWBIOME" {
 SHIP:PARTSDUBBED("sensorGravimeter")[0]:GETMODULE("ModuleScienceExperiment"):DEPLOY.
 wait 1.
 SHIP:PARTSDUBBED("probeStackSmall")[0]:GETMOUDLE("ModuleScienceContainer"):DOACTION("collect all", true).
}
