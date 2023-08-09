-- Table: public.birds

-- DROP TABLE IF EXISTS public.birds;

CREATE TABLE IF NOT EXISTS public.birds
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

ALTER TABLE IF EXISTS public.birds
    OWNER to pew;

REVOKE ALL ON TABLE public.birds FROM grafana;

GRANT SELECT ON TABLE public.birds TO grafana;

GRANT ALL ON TABLE public.birds TO pew;
