# SnapGrid — Your Instagram Clone
## Complete Deployment Guide (No coding experience needed)

---

## What you've got
A full social media platform with:
- ✅ Photo posts + scrollable feed
- ✅ User profiles with follow system
- ✅ Likes, comments, saves
- ✅ Explore page with search
- ✅ Sign up / login with email
- ✅ Image uploads with drag & drop
- ✅ Stories row UI
- ✅ Mobile responsive

---

## STEP 1 — Set Up Your Free Database (Supabase)
*Time: ~15 minutes*

1. Go to **supabase.com** → click "Start your project"
2. Sign up with GitHub (free)
3. Click **"New Project"**
   - Name: `snapgrid`
   - Database password: create a strong one (save it!)
   - Region: pick the closest to you
   - Click "Create new project" (takes ~2 minutes)

4. Once ready, go to **SQL Editor** (left sidebar icon that looks like `< >`)
5. Click **"New query"**
6. Open the file `SUPABASE_SETUP.sql` from this folder
7. Copy ALL the text and paste it into the SQL editor
8. Click **"Run"** (green button)
9. You should see "Success. No rows returned" — that means it worked!

10. Now get your API keys:
    - Go to **Settings** → **API** (left sidebar)
    - Copy **"Project URL"** — looks like `https://abc123.supabase.co`
    - Copy **"anon public"** key — a long string of letters

---

## STEP 2 — Add Your API Keys to the App
*Time: 2 minutes*

1. In the `snapgrid` folder, find the file `.env.example`
2. Make a copy of it and rename the copy to `.env` (no .example)
3. Open `.env` in any text editor (Notepad is fine)
4. Replace `https://YOUR_PROJECT_ID.supabase.co` with your Project URL
5. Replace `your_anon_key_here` with your anon public key
6. Save the file

---

## STEP 3 — Install Node.js (one-time setup)
*Time: 5 minutes*

1. Go to **nodejs.org**
2. Click the big green "LTS" download button
3. Install it (just keep clicking Next)
4. To verify it worked: open Command Prompt (Windows) or Terminal (Mac)
   and type: `node --version` — you should see something like `v20.11.0`

---

## STEP 4 — Run the App Locally (Test it)
*Time: 3 minutes*

1. Open Terminal / Command Prompt
2. Navigate to the snapgrid folder:
   ```
   cd path/to/snapgrid
   ```
   (Example on Windows: `cd C:\Users\Klajdi\Desktop\snapgrid`)

3. Install dependencies (one time only):
   ```
   npm install
   ```
   (This takes 1-2 minutes the first time)

4. Start the app:
   ```
   npm start
   ```

5. Your browser will open automatically at `http://localhost:3000`
6. You should see the SnapGrid login page!
7. Create an account, post a photo, explore!

---

## STEP 5 — Deploy Live to the Internet (Free)
*Time: 10 minutes*

### Option A: Vercel (Recommended — easiest)

1. Go to **github.com** → create a free account
2. Create a new repository called `snapgrid`
3. Upload all your snapgrid files to it
4. Go to **vercel.com** → sign up with GitHub
5. Click **"New Project"** → import your `snapgrid` repo
6. Before deploying, click **"Environment Variables"** and add:
   - `REACT_APP_SUPABASE_URL` = your Supabase URL
   - `REACT_APP_SUPABASE_ANON_KEY` = your anon key
7. Click **"Deploy"**
8. In ~2 minutes you get a live URL like `snapgrid.vercel.app`

### Option B: Netlify (Also free)
Same process — go to netlify.com, connect GitHub repo, add env variables, deploy.

---

## STEP 6 — Add a Custom Domain (Optional, ~$12/year)

1. Buy a domain at **namecheap.com** or **godaddy.com**
   - Examples: `snapgrid.com`, `buildershare.com`
2. In Vercel dashboard → your project → **Settings → Domains**
3. Add your domain and follow their DNS instructions
4. Takes 10-30 minutes to go live

---

## Monthly Running Costs

| Scale | Cost |
|-------|------|
| 0–100 users | **$0/month** (free tiers) |
| 100–1,000 users | ~**$0–10/month** |
| 1,000–10,000 users | ~**$25–50/month** |
| 10,000+ users | ~**$100–300/month** |

---

## What's Next (Phase 2 features to add later)

- [ ] Direct messaging (DMs)
- [ ] Stories with 24hr expiry
- [ ] Video / Reels support
- [ ] Push notifications
- [ ] Hashtags and tagging
- [ ] Mobile app (React Native)

---

## Need Help?

If you get stuck on any step, take a screenshot of the error
and share it — every problem has a solution!
