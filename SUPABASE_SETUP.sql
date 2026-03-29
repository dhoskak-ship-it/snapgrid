-- ============================================================
-- SNAPGRID — Complete Supabase Database Setup
-- Paste this entire file into Supabase SQL Editor and click RUN
-- ============================================================

-- 1. PROFILES TABLE
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  username text unique not null,
  full_name text,
  avatar_url text,
  bio text,
  website text,
  created_at timestamp with time zone default timezone('utc', now())
);

-- 2. POSTS TABLE
create table posts (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  image_url text not null,
  caption text,
  created_at timestamp with time zone default timezone('utc', now())
);

-- 3. LIKES TABLE
create table likes (
  id uuid default gen_random_uuid() primary key,
  post_id uuid references posts(id) on delete cascade not null,
  user_id uuid references profiles(id) on delete cascade not null,
  created_at timestamp with time zone default timezone('utc', now()),
  unique(post_id, user_id)
);

-- 4. COMMENTS TABLE
create table comments (
  id uuid default gen_random_uuid() primary key,
  post_id uuid references posts(id) on delete cascade not null,
  user_id uuid references profiles(id) on delete cascade not null,
  text text not null,
  created_at timestamp with time zone default timezone('utc', now())
);

-- 5. FOLLOWS TABLE
create table follows (
  id uuid default gen_random_uuid() primary key,
  follower_id uuid references profiles(id) on delete cascade not null,
  following_id uuid references profiles(id) on delete cascade not null,
  created_at timestamp with time zone default timezone('utc', now()),
  unique(follower_id, following_id)
);

-- 6. SAVES TABLE
create table saves (
  id uuid default gen_random_uuid() primary key,
  post_id uuid references posts(id) on delete cascade not null,
  user_id uuid references profiles(id) on delete cascade not null,
  created_at timestamp with time zone default timezone('utc', now()),
  unique(post_id, user_id)
);

-- ============================================================
-- ROW LEVEL SECURITY (RLS) — Keeps data safe
-- ============================================================

alter table profiles enable row level security;
alter table posts enable row level security;
alter table likes enable row level security;
alter table comments enable row level security;
alter table follows enable row level security;
alter table saves enable row level security;

-- Profiles: anyone can read, only owner can update
create policy "Profiles viewable by everyone" on profiles for select using (true);
create policy "Users can insert their own profile" on profiles for insert with check (auth.uid() = id);
create policy "Users can update their own profile" on profiles for update using (auth.uid() = id);

-- Posts: anyone can read, only owner can insert/delete
create policy "Posts viewable by everyone" on posts for select using (true);
create policy "Users can insert own posts" on posts for insert with check (auth.uid() = user_id);
create policy "Users can delete own posts" on posts for delete using (auth.uid() = user_id);

-- Likes: anyone can read, authenticated users can insert/delete their own
create policy "Likes viewable by everyone" on likes for select using (true);
create policy "Users can like posts" on likes for insert with check (auth.uid() = user_id);
create policy "Users can unlike posts" on likes for delete using (auth.uid() = user_id);

-- Comments: anyone can read, authenticated users can insert
create policy "Comments viewable by everyone" on comments for select using (true);
create policy "Users can comment" on comments for insert with check (auth.uid() = user_id);
create policy "Users can delete own comments" on comments for delete using (auth.uid() = user_id);

-- Follows
create policy "Follows viewable by everyone" on follows for select using (true);
create policy "Users can follow" on follows for insert with check (auth.uid() = follower_id);
create policy "Users can unfollow" on follows for delete using (auth.uid() = follower_id);

-- Saves
create policy "Users can view own saves" on saves for select using (auth.uid() = user_id);
create policy "Users can save posts" on saves for insert with check (auth.uid() = user_id);
create policy "Users can unsave posts" on saves for delete using (auth.uid() = user_id);

-- ============================================================
-- STORAGE BUCKET for post images
-- ============================================================
-- Run this separately in Supabase Storage section OR SQL:

insert into storage.buckets (id, name, public)
values ('posts', 'posts', true);

create policy "Anyone can view post images" on storage.objects
  for select using (bucket_id = 'posts');

create policy "Authenticated users can upload" on storage.objects
  for insert with check (bucket_id = 'posts' and auth.role() = 'authenticated');

create policy "Users can delete own uploads" on storage.objects
  for delete using (bucket_id = 'posts' and auth.uid()::text = (storage.foldername(name))[1]);

-- ============================================================
-- DONE! Your database is ready.
-- ============================================================
