-- todo nach pg_cron portieren

START TRANSACTION;

\echo -n 'health_cpu:\t'
WITH not_exists AS (
	SELECT time, cpu, host, topic, usage_guest, usage_guest_nice, usage_idle, usage_iowait, usage_irq, usage_nice, usage_softirq, usage_steal, usage_system, usage_user FROM stage_0.cpu st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_cpu p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_cpu ( time, cpu, host, topic, usage_guest, usage_guest_nice, usage_idle, usage_iowait, usage_irq, usage_nice, usage_softirq, usage_steal, usage_system, usage_user)
(SELECT time, cpu, host, topic, usage_guest, usage_guest_nice, usage_idle, usage_iowait, usage_irq, usage_nice, usage_softirq, usage_steal, usage_system, usage_user FROM not_exists)
;
\echo -n 'cpu:\t'
DELETE FROM stage_0.cpu ;



\echo -n 'health_disk:\t'
WITH not_exists AS (
	SELECT time, device, fstype, host, mode, path, topic, free, inodes_free, inodes_total, inodes_used, total, used, used_percent FROM stage_0.disk st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_disk p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_disk ( time, device, fstype, host, mode, path, topic, free, inodes_free, inodes_total, inodes_used, total, used, used_percent)
(SELECT time, device, fstype, host, mode, path, topic, free, inodes_free, inodes_total, inodes_used, total, used, used_percent FROM not_exists)
;
\echo -n 'disk:\t'
DELETE FROM stage_0.disk;


\echo -n 'health_diskio:\t'
WITH not_exists AS (
	SELECT time, host, name, topic, io_time, iops_in_progress, merged_reads, merged_writes, read_bytes, read_time, reads, weighted_io_time, write_bytes, write_time, writes FROM stage_0.diskio st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_diskio p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_diskio ( time, host, name, topic, io_time, iops_in_progress, merged_reads, merged_writes, read_bytes, read_time, reads, weighted_io_time, write_bytes, write_time, writes )
(SELECT time, host, name, topic, io_time, iops_in_progress, merged_reads, merged_writes, read_bytes, read_time, reads, weighted_io_time, write_bytes, write_time, writes FROM not_exists)
;
\echo -n 'diskio:\t'
DELETE FROM stage_0.diskio;


\echo -n 'health_kernel:\t'
WITH not_exists AS (
	SELECT time, host, topic, boot_time, context_switches, entropy_avail, interrupts, processes_forked FROM stage_0.kernel st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_kernel p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_kernel ( time, host, topic, boot_time, context_switches, entropy_avail, interrupts, processes_forked )
(SELECT time, host, topic, boot_time, context_switches, entropy_avail, interrupts, processes_forked FROM not_exists)
;
\echo -n 'kernel:\t'
DELETE FROM stage_0.kernel;


\echo -n 'health_mem:\t'
WITH not_exists AS (
	SELECT time, host, topic, active, available, available_percent, buffered, cached, commit_limit, committed_as, dirty, free, high_free, high_total, huge_page_size, huge_pages_free, huge_pages_total, inactive, low_free, low_total, mapped, page_tables, shared, slab, sreclaimable, sunreclaim, swap_cached, swap_free, swap_total, total, used, used_percent, vmalloc_chunk, vmalloc_total, vmalloc_used, wired, write_back, write_back_tmp FROM stage_0.mem st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_mem p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_mem ( time, host, topic, active, available, available_percent, buffered, cached, commit_limit, committed_as, dirty, free, high_free, high_total, huge_page_size, huge_pages_free, huge_pages_total, inactive, low_free, low_total, mapped, page_tables, shared, slab, sreclaimable, sunreclaim, swap_cached, swap_free, swap_total, total, used, used_percent, vmalloc_chunk, vmalloc_total, vmalloc_used, wired, write_back, write_back_tmp )
(SELECT time, host, topic, active, available, available_percent, buffered, cached, commit_limit, committed_as, dirty, free, high_free, high_total, huge_page_size, huge_pages_free, huge_pages_total, inactive, low_free, low_total, mapped, page_tables, shared, slab, sreclaimable, sunreclaim, swap_cached, swap_free, swap_total, total, used, used_percent, vmalloc_chunk, vmalloc_total, vmalloc_used, wired, write_back, write_back_tmp FROM not_exists)
;
\echo -n 'mem:\t'
DELETE FROM stage_0.mem;


\echo -n 'health_processes:\t'
WITH not_exists AS (
	SELECT time, host, topic, blocked, dead, idle, paging, running, sleeping, stopped, total, total_threads, unknown, zombies FROM stage_0.processes st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_processes p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_processes 
( time, host, topic, blocked, dead, idle, paging, running, sleeping, stopped, total, total_threads, unknown, zombies )
(SELECT time, host, topic, blocked, dead, idle, paging, running, sleeping, stopped, total, total_threads, unknown, zombies FROM not_exists)
;
\echo -n 'processes:\t'
DELETE FROM stage_0.processes;


\echo -n 'health_swap:\t'
WITH not_exists AS (
	SELECT time, host, topic, free, "in", "out", total, used, used_percent FROM stage_0.swap st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_swap p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_swap ( time, host, topic, free, "in", "out", total, used, used_percent )
(SELECT time, host, topic, free, "in", "out", total, used, used_percent FROM not_exists)
;
\echo -n 'swap:\t'
DELETE FROM stage_0.swap;


\echo -n 'health_system:\t'
WITH not_exists AS (
	SELECT time, host, topic, load1, load15, load5, n_cpus, n_unique_users, n_users, uptime, uptime_format FROM stage_0.system st
	WHERE NOT EXISTS (SELECT time, host FROM public.health_system p WHERE p.time = st.time AND p.host = st.host)
)
INSERT INTO public.health_system ( time, host, topic, load1, load15, load5, n_cpus, n_unique_users, n_users, uptime, uptime_format )
(SELECT time, host, topic, load1, load15, load5, n_cpus, n_unique_users, n_users, uptime, uptime_format FROM not_exists)
;
\echo -n 'system:\t'
DELETE FROM stage_0.system;


COMMIT;


