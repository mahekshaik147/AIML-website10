# Quick Fix: Leadership Table 404 Error

## 🔴 Problem
You're seeing this error:
```
Failed to load resource: the server responded with a status of 404
Error fetching leadership: Object
```

This means the `leadership` table doesn't exist in your Supabase database yet.

## ✅ Solution (2 minutes)

### Step 1: Open Supabase Dashboard
1. Go to https://supabase.com/dashboard
2. Select your project (nazeyrzodnnvcqwttrvr)

### Step 2: Open SQL Editor
1. Click **SQL Editor** in the left sidebar
2. Click **New query** button (or use existing editor)

### Step 3: Run the SQL Script
1. Open the file `create-leadership-table.sql` in your project folder
2. **Copy ALL the SQL code** (lines 1-74)
3. **Paste it** into the Supabase SQL Editor
4. Click **Run** button (or press Ctrl+Enter / Cmd+Enter)

### Step 4: Verify It Worked
1. Go to **Table Editor** in Supabase Dashboard
2. You should see `leadership` table in the list
3. Refresh your admin panel - the error should be gone!

## 📋 What the Script Does

The SQL script will:
- ✅ Create the `leadership` table
- ✅ Set up Row Level Security (RLS) policies
- ✅ Create the `leadership-photos` storage bucket
- ✅ Set up storage policies
- ✅ Insert sample data (optional)

## 🎯 After Running the Script

1. **Refresh your admin panel** (F5)
2. **Go to Leaders section**
3. You should see:
   - No more 404 errors
   - Empty table (or sample data if included)
   - "Add Leader" button works

## ⚠️ Other Errors You Might See

### "Tracking Prevention blocked access to storage"
- This is just a browser privacy warning
- **Not a real error** - can be ignored
- Your uploads will still work

### "Failed to load resource: net::ERR_FILE_NOT_FOUND" for faculty images
- These are local file paths that don't exist
- **Not critical** - faculty images from database will work fine
- You can ignore these errors

## 🚀 Next Steps

Once the table is created:
1. ✅ Add leaders through the admin panel
2. ✅ Upload leader photos
3. ✅ View leaders on the website

---

**Still having issues?** Check:
- Supabase project is correct
- SQL script ran without errors
- Table appears in Table Editor
- Refresh admin panel after creating table
