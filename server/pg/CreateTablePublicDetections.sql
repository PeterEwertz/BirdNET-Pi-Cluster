-- Table: public.detections

-- DROP TABLE IF EXISTS public.detections;

CREATE TABLE IF NOT EXISTS public.detections
(
    "time" timestamp without time zone,
    comname text COLLATE pg_catalog."default",
    host text COLLATE pg_catalog."default",
    sciname text COLLATE pg_catalog."default",
    topic text COLLATE pg_catalog."default",
    confidence double precision,
    cutoff double precision,
    lat double precision,
    lng double precision,
    overlap double precision,
    sens double precision,
    week bigint,
    time_arrival timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.detections
    OWNER to pew;

REVOKE ALL ON TABLE public.detections FROM grafana;

GRANT SELECT ON TABLE public.detections TO grafana;

GRANT ALL ON TABLE public.detections TO pew;
