-- Setup Leadership Photos Storage Bucket
-- Run this in Supabase Dashboard > SQL Editor
-- This script creates the bucket and sets up all necessary policies

-- Step 1: Create the storage bucket (if it doesn't exist)
INSERT INTO storage.buckets (id, name, public)
VALUES ('leadership-photos', 'leadership-photos', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Step 2: Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Public Access for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated uploads for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated updates for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated deletes for leadership-photos" ON storage.objects;
DROP POLICY IF EXISTS "Public Access" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated uploads" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated updates" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated deletes" ON storage.objects;

-- Step 3: Create policy for public read access (anyone can view images)
CREATE POLICY "Public Access for leadership-photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'leadership-photos');

-- Step 4: Create policy for public insert (upload) - allows anonymous uploads
-- This is needed because the admin panel doesn't use Supabase auth
CREATE POLICY "Public uploads for leadership-photos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'leadership-photos');

-- Step 5: Create policy for public update (modify existing files)
CREATE POLICY "Public updates for leadership-photos"
ON storage.objects FOR UPDATE
USING (bucket_id = 'leadership-photos');

-- Step 6: Create policy for public delete (remove files)
CREATE POLICY "Public deletes for leadership-photos"
ON storage.objects FOR DELETE
USING (bucket_id = 'leadership-photos');

-- Step 7: Verify the bucket was created
SELECT 
    id as bucket_name, 
    name,
    public as is_public,
    created_at,
    updated_at
FROM storage.buckets
WHERE id = 'leadership-photos';

-- Expected output: Should show one row with leadership-photos bucket

