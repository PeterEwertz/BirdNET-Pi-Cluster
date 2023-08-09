-- todo nach pg_cron portieren
INSERT INTO public.detections 
	(time, comname, host, sciname, topic, confidence, cutoff, lat, lng, overlap, sens, week, time_arrival)
	(
	SELECT dt::timestamp, comname, host, sciname, topic, confidence, 
		cutoff, lat, lng, overlap, sens, week, time
	FROM stage_0.birds s
	WHERE (s.time, s.host) NOT IN (SELECT p.time, p.host FROM public.detections p)
	)
;

