# Leadership Photos Storage Bucket Setup Guide

This guide will help you set up the `leadership-photos` storage bucket in Supabase so that leader images can be uploaded, retrieved, and managed from the Admin panel.

## 🎯 Quick Setup (Recommended)

### Option 1: Using SQL Script (Fastest)

1. **Open Supabase Dashboard**
   - Go to https://supabase.com/dashboard
   - Select your project

2. **Open SQL Editor**
   - Click on **SQL Editor** in the left sidebar
   - Click **New query**

3. **Run the Setup Script**
   - Open the file `setup-leadership-photos-bucket.sql` in your project
   - Copy all the SQL code
   - Paste it into the SQL Editor
   - Click **Run** (or press Ctrl+Enter)

4. **Verify Bucket Created**
   - Go to **Storage** in the left sidebar
   - You should see `leadership-photos` bucket listed
   - It should show as **Public**

### Option 2: Manual Setup (Step-by-Step)

1. **Create the Bucket**
   - Go to Supabase Dashboard > **Storage**
   - Click **New bucket**
   - Enter bucket name: `leadership-photos` (exactly as shown)
   - ✅ Check **Public bucket**
   - Click **Create bucket**

2. **Set Up Storage Policies**
   - Go to **Storage** > **Policies** (or use SQL Editor)
   - Run the following SQL to create policies:

```sql
-- Public read access
CREATE POLICY "Public Access for leadership-photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'leadership-photos');

-- Public upload access (for admin panel)
CREATE POLICY "Public uploads for leadership-photos"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'leadership-photos');

-- Public update access
CREATE POLICY "Public updates for leadership-photos"
ON storage.objects FOR UPDATE
USING (bucket_id = 'leadership-photos');

-- Public delete access
CREATE POLICY "Public deletes for leadership-photos"
ON storage.objects FOR DELETE
USING (bucket_id = 'leadership-photos');
```

## ✅ Verification Steps

After setup, verify everything works:

1. **Check Bucket Exists**
   - Go to **Storage** in Supabase Dashboard
   - You should see `leadership-photos` in the list
   - Status should show as **Public**

2. **Test Upload from Admin Panel**
   - Open `admin/login.html` in your browser
   - Login to admin panel
   - Go to **Leaders** section
   - Click **Add Leader**
   - Fill in the form and upload a photo
   - Click **Save Leader**
   - ✅ If successful, you should see "Leader added successfully!"
   - ✅ The leader should appear in the table with the photo

3. **Check Storage**
   - Go to Supabase Dashboard > **Storage** > `leadership-photos`
   - You should see the uploaded image file

4. **Check User Website**
   - Open `index.html` in your browser
   - Navigate to the **Leadership** section
   - ✅ The leader you added should appear with their photo

## 🔧 Troubleshooting

### Error: "Bucket not found"

**Solution:**
- The bucket doesn't exist yet
- Follow the setup steps above to create it
- Make sure the name is exactly `leadership-photos` (with hyphen)

### Error: "Permission denied" or "RLS policy violation"

**Solution:**
- The storage policies are not set up correctly
- Run the SQL script `setup-leadership-photos-bucket.sql`
- Or manually create the policies as shown in Option 2

### Error: "File upload failed"

**Possible causes:**
1. **Bucket not public** - Make sure "Public bucket" is enabled
2. **File too large** - Supabase has file size limits (usually 50MB)
3. **Network issue** - Check your internet connection
4. **Invalid file type** - Make sure you're uploading an image file (jpg, png, etc.)

**Solution:**
- Check bucket settings in Supabase Dashboard
- Try uploading a smaller image
- Check browser console (F12) for detailed error messages

### Images not displaying on website

**Possible causes:**
1. **Bucket not public** - Images need public access to display
2. **Wrong URL format** - Check the photo_url in the database
3. **CORS issue** - Usually not a problem with Supabase public buckets

**Solution:**
- Verify bucket is public in Supabase Dashboard
- Check the `photo_url` in the `leadership` table
- The URL should start with your Supabase project URL

## 📋 What Was Enhanced

The Admin panel now has:

1. **Bucket Validation** - Checks if bucket exists before uploading
2. **Better Error Messages** - Clear instructions when bucket is missing
3. **Automatic Photo Cleanup** - Deletes photos from storage when leaders are deleted
4. **Enhanced Upload Function** - Better error handling and logging

## 🔒 Security Notes

⚠️ **Important:** The current setup allows public uploads to the `leadership-photos` bucket. This is fine for an admin-controlled system, but if you want more security:

1. Use Supabase Authentication
2. Create policies that require authentication
3. Update the admin panel to use Supabase Auth

For now, the public upload policy works because:
- Only admins have access to the admin panel
- The admin panel is password-protected
- Public read access is needed for images to display on the website

## 📚 Related Files

- `setup-leadership-photos-bucket.sql` - Complete SQL setup script
- `create-buckets-safe.sql` - Creates all buckets including leadership-photos
- `admin/database.js` - Contains upload and delete functions
- `admin/dashboard.js` - Leader form submission handler

## 🎉 Success!

Once the bucket is set up, you can:
- ✅ Upload leader photos from Admin panel
- ✅ View leaders with photos on the website
- ✅ Edit leader photos
- ✅ Delete leaders (photos are automatically removed)
- ✅ All changes sync automatically to the user website

