SET done TO FALSE.
SET loop_count TO 0.
SET desired_speed TO 0.

//TODO: tune.
SET Kp TO 1.
SET Ki TO 0.001.
SET Kd TO 0.1.

SET I TO 0.
SET previous_time TO TIME:SECONDS.
SET previous_P TO 0.

ON AG1 {SET Kp TO Kp -0.25. PRESERVE.} //CAN't be in main loop.
ON AG3 {SET Kp TO Kp +0.25. PRESERVE.} //PRESERVE to re-instate it after run.
ON AG2 {SET done TO TRUE.} //NO NEED TO PRESERVE.

UNTIL done {
	SET desired_speed to SHIP:CONTROL:PILOTMAINTHROTTLE * 10.
	SET P TO desired_speed - SHIP:groundspeed.

	SET dt TO TIME:SECONDS - previous_time.
	SET I TO I + P*dt.
	IF dt = 0 {
		SET D TO 0.
	}
	ELSE {
		SET D TO (P-previous_P)/dt.
	}
	SET thr TO 0.5+(0.5 * (Kp*P + Ki*I + Kd*D)).
	//PRINT loop_count.
	IF MOD(loop_count, 50) = 0 {
		PRINT " ".
		print "----".
		PRINT "TIME:SECONDS: " + TIME:SECONDS.
		PRINT "dt: " + dt.
		PRINT "pT: " + previous_time.
		PRINT "GroundSpeed: " + ship:groundspeed.
		PRINT "Desired Sped: " + desired_speed.
		PRINT "Kp: " + Kp.
		PRINT "P: " + P.
		PRINT "I: " + I.
		PRINT "D: " + D.
		PRINT "dt: " + dt.
		PRINT "Throttle: " + thr.
	}
	LOCK WHEELTHROTTLE TO thr.
	SET previous_time TO TIME:SECONDS.
	SET previous_P TO P.
	SET loop_count to loop_count + 1.
	WAIT 0.01.
}.
UNLOCK WHEELTHROTTLE.
PRINT "done " + loop_count.