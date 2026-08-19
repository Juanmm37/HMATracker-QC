-- AC Tonnage: stores monthly tonnage per mix for the Mix Avgs table in the AC Report
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS ac_tonnage (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  year text NOT NULL,
  month integer NOT NULL CHECK (month BETWEEN 1 AND 12),
  family text NOT NULL,
  mix_no text NOT NULL,
  tonnage numeric NOT NULL DEFAULT 0,
  updated_at timestamptz NOT NULL DEFAULT now(),
  updated_by text,
  UNIQUE (year, month, family, mix_no)
);

ALTER TABLE ac_tonnage ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated full access" ON ac_tonnage
  FOR ALL USING (true) WITH CHECK (true);
