-- Role: grafana
-- DROP ROLE IF EXISTS grafana;

CREATE ROLE grafana WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:+4GHSe2F2RnvbyMo3VAwYQ==$QCsprbNEXVD48kaH2IUxOaYuUONwJg1xS8q6wmeAkMw=:vyniTifZYBVRiXDi1xAm7I9G0roZLX6XRuGWtpuF4fM=';