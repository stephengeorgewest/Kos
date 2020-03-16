SET done TO FALSE.
SET loop_count TO 0.
SET desired_speed TO 0.

SET Kp TO 0.5.
SET Ki TO 0.1.
SET Kd TO 0.

SET I TO 0.
SET previous_time TO TIME:SECONDS.
SET previous_P TO 0.

ON AG1 {SET desired_speed TO desired_speed -0.25. PRESERVE.} //CAN't be in main loop.
ON AG3 {SET desired_speed TO desired_speed +0.25. PRESERVE.} //PRESERVE to re-instate it after run.
ON AG2 {SET done TO TRUE.} //NO NEED TO PRESERVE.
UNTIL done {
	SET P TO desired_speed - SHIP:groundspeed.

	SET dt TO TIME:SECONDS - previous_time.
	SET I TO I + P*dt.
	SET previous_time TO TIME:SECONDS.
	IF dt = 0 {
		SET D TO 0.
	}
	ELSE {
		SET D TO (P-previous_P)/dt.
	}
	SET previous_P TO P.
	SET thr to (0.5 * (Kp*P + Ki*I + Kd*D)).
	//PRINT loop_count.
	IF MOD(loop_count, 50) = 0 {
		PRINT " ".
		PRINT "TIME:SECONDS: " + TIME:SECONDS.
		PRINT "dt: " + dt.
		PRINT "pT: " + previous_time.
		PRINT "GroundSpeed: " + ship:groundspeed.
		PRINT "Desired Sped: " + desired_speed.
		PRINT "P: " + P.
		PRINT "I: " + I.
		PRINT "D: " + D.
		PRINT "dt: " + dt.
		PRINT "Throttle: " + thr.
	}
	SET loop_count to loop_count + 1.
	WAIT 0.01.
}.
PRINT "done " + loop_count.