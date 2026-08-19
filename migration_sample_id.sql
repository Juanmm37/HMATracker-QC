-- Fix 1: Add sample_id column to test_records
-- Run this in Supabase SQL Editor before reloading the app

ALTER TABLE test_records ADD COLUMN IF NOT EXISTS sample_id text;
CREATE INDEX IF NOT EXISTS idx_test_records_sample_id ON test_records(sample_id);

-- Backfill existing rows from the results JSONB blob
UPDATE test_records
SET sample_id = results->>'sampleId'
WHERE sample_id IS NULL
  AND results->>'sampleId' IS NOT NULL
  AND results->>'sampleId' != '';
