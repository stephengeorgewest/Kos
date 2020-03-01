IF HASTARGET{
  PRINT TARGET.
  DECLARE previous_target TO TARGET.
}
ELSE{
  PRINT "NO TTARGET".
}
DECLARE previous_SAS to SAS.
DECLARE previous_SASMODE to SASMODE.
PRINT previous_SAS.
PRINT previous_SASMODE.

SET TARGET TO SUN.
WAIT 0.001.
SAS ON.
WAIT 0.001.
SET SASMODE TO "ANTITARGET".
DECLARE e_total TO 0.
DECLARE e_amount TO 0.
LIST RESOURCES IN r.
FOR res IN r{
  PRINT res:NAME.
  IF res:NAME = "ElectricCharge"{
    SET e_amount TO res:AMOUNT.
    PRINT e_amount.
    SET e_total TO res:CAPACITY.
    PRINT e_total.
  }
}
IF e_total > 0 {
  PRINT "a".
  UNTIL e_amount / e_total > 0.99 {
    PRINT e_amount / e_total.
    FOR res in r{
      IF res:NAME = "ElectricCharge"{
        SET e_amount TO res:AMOUNT.
      }
    }
    WAIT 0.5.
  }
}

IF DEFINED previous_target {
  PRINT previous_target.
  SET TARGET TO previous_target.
}
WAIT 0.001.
SET SASMODE TO previous_sasmode.
WAIT 0.001.
IF previous_SAS {
  PRINT "RE-ENABLING SAS".
  SAS ON.
}
ELSE{
  PRINT "RE-DUSABLING SAS".
  SAS OFF.
}

