SWITCH TO 0.
LIST.
RUN get_biome.

SHIP:PARTS[3]:GETMODULE("ModuleKerbnetAcess"):DOEVENT("kerbnet access").

PRINT SHIP:PARTSDUBBED("sensorGravimeter")[0]:GETMODULE("ModuleScienceExperiment"):DEPLOY.

PRINT SHIP:PARTSNAMED("SurfaceScanner")[0]:GETMODULE("ModuleGPS"):GETFIELD("Biome").
