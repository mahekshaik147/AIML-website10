# 🔧 Solve 404 Error - Step by Step Guide

## 🔴 The Problem

You're seeing these errors in the console:
```
Failed to load resource: the server responded with a status of 404
Error fetching leadership: Object
```

**This means:** The `leadership` table doesn't exist in your Supabase database yet.

---

## ✅ Solution (Takes 2 Minutes)

### Step 1: Open Supabase Dashboard
1. Go to **https://supabase.com/dashboard**
2. Login to your account
3. Select your project: **nazeyrzodnnvcqwttrvr**

### Step 2: Open SQL Editor
1. Click **SQL Editor** in the left sidebar (it has a database icon)
2. Click the **New query** button (top right) or use the existing editor

### Step 3: Copy the SQL Script
1. In your project folder, open **`setup-leadership-complete.sql`**
   - This is the **complete setup script** that creates everything
   - OR use `create-leadership-table.sql` (simpler version)
2. **Select ALL** the text (Ctrl+A / Cmd+A)
3. **Copy** it (Ctrl+C / Cmd+C)

### Step 4: Paste and Run
1. **Paste** the SQL code into the Supabase SQL Editor
2. Click the **Run** button (or press Ctrl+Enter / Cmd+Enter)
3. Wait for it to complete (you should see "Success" message)

### Step 5: Verify It Worked
1. In Supabase Dashboard, click **Table Editor** in the left sidebar
2. You should see **`leadership`** in the list of tables
3. Click on it to see the table structure

### Step 6: Refresh Admin Panel
1. Go back to your admin panel (`admin/dashboard.html`)
2. Press **F5** to refresh
3. Click on **Leaders** in the sidebar
4. ✅ **The 404 error should be gone!**

---

## 📋 What the Script Creates

The SQL script will create:
- ✅ `leadership` table (to store leader data)
- ✅ Row Level Security (RLS) policies (for permissions)
- ✅ `leadership-photos` storage bucket (for images)
- ✅ Storage policies (for uploads/downloads)
- ✅ Indexes (for better performance)

---

## 🎯 After Setup

Once the table is created:
1. ✅ No more 404 errors
2. ✅ You can add leaders through the admin panel
3. ✅ You can upload leader photos
4. ✅ Leaders will appear on the website automatically

---

## ⚠️ About Other Console Messages

### "Tracking Prevention blocked access to storage"
- **What it is:** Browser privacy feature warning
- **Is it a problem?** ❌ No, you can ignore it
- **Why?** It's just a browser warning, uploads still work

### "Failed to load resource: net::ERR_FILE_NOT_FOUND" for faculty images
- **What it is:** Local file paths that don't exist
- **Is it a problem?** ❌ No, not critical
- **Why?** Faculty images from the database will work fine
- **Solution:** These are just old static file references, ignore them

---

## 🚨 Still Having Issues?

### If you see errors when running the SQL:

1. **"relation already exists"**
   - The table already exists, that's fine!
   - The script uses `IF NOT EXISTS` so it's safe to run again

2. **"permission denied"**
   - Make sure you're logged into Supabase
   - Make sure you selected the correct project

3. **"syntax error"**
   - Make sure you copied the ENTIRE script
   - Don't copy just part of it

### If the 404 error persists after setup:

1. **Check the table exists:**
   - Go to Supabase Dashboard → Table Editor
   - Look for `leadership` table
   - If it's not there, run the SQL script again

2. **Check your Supabase connection:**
   - Open browser console (F12)
   - Look for "Supabase connected: true"
   - If it says false, check `admin/supabase-config.js`

3. **Clear browser cache:**
   - Press Ctrl+Shift+Delete
   - Clear cached images and files
   - Refresh the page

---

## 📞 Quick Checklist

Before asking for help, make sure:
- [ ] SQL script ran without errors
- [ ] `leadership` table appears in Table Editor
- [ ] `leadership-photos` bucket appears in Storage
- [ ] Refreshed admin panel after setup
- [ ] Checked browser console for new errors

---

## 🎉 Success!

Once you see:
- ✅ No 404 errors in console
- ✅ Leaders section shows "No leaders found" (or your leaders)
- ✅ "Add Leader" button works

**You're all set!** The Leadership feature is now fully connected.

