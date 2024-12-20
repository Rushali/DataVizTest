# The DuckDB executable must be on your environment path!
# Use DuckDB version 0.9.2 or later
# Write to a named file as portable file descriptors such as
# (/dev/stdout) appear to be unavailable in GitHub actions.
# FROM 'https://idl.uw.edu/mosaic-datasets/data/nyc-rides-2010.parquet';
duckdb :memory: << EOF
-- Load spatial extension
INSTALL spatial; LOAD spatial;

-- Project, following the example at https://github.com/duckdb/duckdb_spatial
CREATE TEMP TABLE rides AS SELECT
  pickup_datetime::TIMESTAMP AS datetime,
  ST_Transform(ST_Point(pickup_latitude, pickup_longitude), 'EPSG:4326', 'ESRI:102718') AS pick,
  ST_Transform(ST_Point(dropoff_latitude, dropoff_longitude), 'EPSG:4326', 'ESRI:102718') AS drop

FROM '/Users/rushali/Documents/Framework2/src/data/crashes.parquet';

-- Write output parquet file
COPY (SELECT
  HOUR(datetime) + MINUTE(datetime) / 60 AS time,
  ST_X(pick)::INTEGER AS px, -- extract pickup x-coord
  ST_Y(pick)::INTEGER AS py, -- extract pickup y-coord
  ST_X(drop)::INTEGER AS dx, -- extract dropff x-coord
  ST_Y(drop)::INTEGER AS dy  -- extract dropff y-coord
FROM rides) TO 'trips.parquet' WITH (FORMAT PARQUET);
EOF

cat trips.parquet >&1  # Write output to stdout
rm trips.parquet       # Clean up