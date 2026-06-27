-- ════════════════════════════════════════════════════════════════
-- מוסכּומטר — סכמת Supabase
-- הריצו את כל הקובץ הזה ב: Supabase → SQL Editor → New query → Run
-- ════════════════════════════════════════════════════════════════

create table if not exists public.repairs (
  id           uuid primary key default gen_random_uuid(),
  created_at   timestamptz not null default now(),
  repair_type  text   not null,
  cost         numeric not null check (cost > 0),
  garage_name  text   not null,
  garage_phone text,
  area         text,
  car          text
);

-- אינדקסים שימושיים לשאילתות ההשוואה
create index if not exists repairs_type_idx  on public.repairs (repair_type);
create index if not exists repairs_phone_idx on public.repairs (garage_phone);

-- Row Level Security: כל אחד יכול להוסיף ולקרוא, אף אחד לא יכול לערוך/למחוק
alter table public.repairs enable row level security;

drop policy if exists "anyone can insert" on public.repairs;
create policy "anyone can insert"
  on public.repairs for insert to anon, authenticated with check (true);

drop policy if exists "anyone can read" on public.repairs;
create policy "anyone can read"
  on public.repairs for select to anon, authenticated using (true);
