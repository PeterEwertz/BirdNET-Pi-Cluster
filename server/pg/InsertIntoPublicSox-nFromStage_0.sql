-- todo nach pg_cron portieren


\echo -n 'sox_n:\t'

with not_exists as (
	select time, host, length_seconds, local_time, maximum_amplitude, maximum_delta, mean_amplitude, mean_delta, mean_norm, midline_amplitude, minimum_amplitude, minimum_delta, rms_amplitude, rms_delta, rough_frequency, samples_read, scaled_by, volume_adjustment from stage_0."sox-n" st
	where not exists (select time, host from public.sox_n p where p.time = st.time and p.host = st.host)
)
insert into public.sox_n (time, host, length_seconds, local_time, maximum_amplitude, maximum_delta, mean_amplitude, mean_delta, mean_norm, midline_amplitude, minimum_amplitude, minimum_delta, rms_amplitude, rms_delta, rough_frequency, samples_read, scaled_by, volume_adjustment)
(select time, host, length_seconds, local_time, maximum_amplitude, maximum_delta, mean_amplitude, mean_delta, mean_norm, midline_amplitude, minimum_amplitude, minimum_delta, rms_amplitude, rms_delta, rough_frequency, samples_read, scaled_by, volume_adjustment from not_exists)
;






