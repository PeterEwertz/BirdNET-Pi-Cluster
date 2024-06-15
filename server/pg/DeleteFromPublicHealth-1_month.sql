BEGIN;
\echo -n 'health_cpu:\t'
DELETE FROM health_cpu WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_disk:\t'
DELETE FROM health_disk WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_diskio:\t'
DELETE FROM health_diskio WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_kernel:\t'
DELETE FROM health_kernel WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_mem:\t'
DELETE FROM health_mem WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_processes:\t'
DELETE FROM health_processes WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_swap:\t'
DELETE FROM health_swap WHERE time < (date_trunc('day', now() - interval '1 month'));
\echo -n 'health_system:\t'
DELETE FROM health_system WHERE time < (date_trunc('day', now() - interval '1 month'));
COMMIT;

