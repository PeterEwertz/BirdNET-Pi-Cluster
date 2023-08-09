-- todo nach pg_cron portieren


with not_exists as (
	select  dt::timestamp, comname, host, sciname, topic, confidence, cutoff, lat, lng, overlap, sens, week, time from stage_0.birds st 
	where not exists (select time, host from public.detections p where p.time = st.dt::timestamp and p.host = st.host)
)
insert into public.detections (time, comname, host, sciname, topic, confidence, cutoff, lat, lng, overlap, sens, week, time_arrival)
(select dt::timestamp, comname, host, sciname, topic, confidence, cutoff, lat, lng, overlap, sens, week, time from not_exists)
;
