-- todo nach pg_cron portieren


with not_exists as (
	select  dt::timestamp, com_name, host, sci_name, topic, confidence, cutoff, lat, lng, overlap, sens, week, time from stage_0.birds st 
	where time > (select last_run from last_run where on_table = 'birds')
		and not exists (select time, host from public.detections p where p.time = st.dt::timestamp and p.host = st.host)
)
insert into public.detections (time, com_name, host, sci_name, topic, confidence, cutoff, lat, lng, overlap, sens, week, time_arrival)
(select dt::timestamp, com_name, host, sci_name, topic, confidence, cutoff, lat, lng, overlap, sens, week, time from not_exists)
;
