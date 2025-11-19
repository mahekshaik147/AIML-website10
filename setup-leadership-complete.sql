-- Complete Leadership Setup Script
-- This script creates everything needed for the Leadership feature
-- Run this in Supabase Dashboard > SQL Editor

-- ============================================
-- STEP 1: Create Leadership Table
-- ============================================
CREATE TABLE IF NOT EXISTS public.leadership (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    position TEXT NOT NULL,
    photo_url TEXT,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- ============================================
-- STEP 2: Enable Row Level Security (RLS)
-- ============================================
ALTER TABLE public.leadership ENABLE ROW LEVEL SECURITY;

-- ============================================
-- STEP 3: Create RLS Policies
-- ============================================
-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Allow public read access" ON public.leadership;
DROP POLICY IF EXISTS "Allow authenticated insert" ON public.leadership;
DROP POLICY IF EXISTS "Allow authenticated update" ON public.leadership;
DROP POLICY IF EXISTS "Allow authenticated delete" ON public.leadership;

-- Create policy to allow public read access
CREATE POLICY "Allow public read access" ON public.leadership
    FOR SELECT
    USING (true);

-- Create policy to allow insert (for admin panel)
CREATE POLICY "Allow authenticated insert" ON public.leadership
    FOR INSERT
    WITH CHECK (true);

-- Create policy to allow update (for admin panel)
CREATE POLICY "Allow authenticated update" ON public.leadership
    FOR UPDATE
    USING (true);

-- Create policy to allow delete (for admin panel)
CREATE POLICY "Allow authenticated delete" ON public.leadership
    FOR DELETE
    USING (true);

-- ============================================
-- STEP 4: Create Index for Performance
-- ============================================
CREATE INDEX IF NOT EXISTS leadership_display_order_idx ON public.leadership(display_order);

-- ============================================
-- STEP 5: Create Storage Bucket
-- ============================================
-- Create storage bucket for leadership photos if it doesn't exist
INSERT INTO storage.buckets (id, name, public)
VALUES ('leadership-photos', 'leadership-photos', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- ============================================
-- STEP 6: Create Storage Policies
-- ============================================
-- Drop existing storage policies if they exist
DROP POLICY IF EXISTS "Public Access" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated uploads" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated updates" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated deletes" ON storage.objects;
DROP POLICY IF EXISTS "Public Access for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Public uploads for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Public updates for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Public deletes for leadership-photos" ON storage.objects;

-- Create storage policy for public read access
CREATE POLICY "Public Access for leadership-photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'leadership-photos');

-- Create storage policy for public insert (upload)
CREATE POLICY "Public uploads for leadership-photos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'leadership-photos');

-- Create storage policy for public update
CREATE POLICY "Public updates for leadership-photos"
ON storage.objects FOR UPDATE
USING (bucket_id = 'leadership-photos');

-- Create storage policy for public delete
CREATE POLICY "Public deletes for leadership-photos"
ON storage.objects FOR DELETE
USING (bucket_id = 'leadership-photos');

-- ============================================
-- STEP 7: Verify Setup
-- ============================================
-- Check if table was created
SELECT 
    'leadership' as table_name,
    COUNT(*) as row_count
FROM public.leadership;

-- Check if bucket was created
SELECT 
    id as bucket_name, 
    name,
    public as is_public,
    created_at
FROM storage.buckets
WHERE id = 'leadership-photos';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================
-- If you see results above, the setup was successful!
-- Now refresh your admin panel and the 404 error should be gone.

