/* 1) Перевірка / увімкнення зовнішніх ключів (FOREIGN KEY) */
/* 1) Check and Enable Foreign Key Constraints */
PRAGMA foreign_keys;        -- якщо повертає 0 → FK вимкнені
PRAGMA foreign_keys = ON;   -- вмикаємо FK для поточного підключення
PRAGMA foreign_keys;        -- якщо повертає 1 → FK увімкнені

/* 2) Видалення таблиць, якщо вони вже існують (для перезапуску) */
/* 2) Drop Existing Tables */
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

/* 3) Створення таблиці customers (PRIMARY KEY = user_id) */
/* 3) Create Customers Table */
CREATE TABLE customers (
    user_id              TEXT PRIMARY KEY,
    first_name           TEXT,
    last_name            TEXT,
    email                TEXT,
    gender               TEXT,
    age                  INTEGER,
    city                 TEXT,
    acquisition_channel  TEXT,
    registration_date    TEXT  -- 'YYYY-MM-DD'
);

/* 4) Створення таблиці orders (PRIMARY KEY + FOREIGN KEY) */
/* 4) Create Orders Table with Foreign Key Relationship */
CREATE TABLE orders (
    order_id          TEXT PRIMARY KEY,
    user_id           TEXT NOT NULL,
    registration_date TEXT,   
    order_date        TEXT NOT NULL, -- 'YYYY-MM-DD'
    purchase_amount   REAL NOT NULL CHECK (purchase_amount >= 0),
    order_channel     TEXT,
    payment_method    TEXT,
    items_count       INTEGER,
    delivery_days     INTEGER,
    order_status      TEXT,

    FOREIGN KEY (user_id) REFERENCES customers(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* 5) Індекси — "швидкі покажчики" для прискорення JOIN/WHERE по ключових колонках */
/* 5) Create Indexes to Improve Query Performance */
CREATE INDEX idx_orders_user_id     ON orders(user_id);
CREATE INDEX idx_orders_order_date  ON orders(order_date);

/* 6) Тop 5 Acquisition Channels Among Female Customers */
select
   c.acquisition_channel
  ,count(distinct c.user_id) as female_users
  ,count(o.order_id) as female_orders
  ,round(sum(o.purchase_amount), 2) as female_revenue
  ,round(avg(o.purchase_amount), 2) as avg_check
from customers c
join orders o on c.user_id = o.user_id
where c.gender = 'Female'
group by c.acquisition_channel
order by female_revenue desc
limit 5;

-- Висновки:
-- 1. Найефективнішим каналом залучення жінок є Instagram.
-- 2. Instagram приніс найбільшу виручку ($190,547.29) та найбільшу кількість замовлень (1,441).
-- 3. Facebook та Google Ads посідають друге і третє місця за виручкою.
-- 4. Середній чек майже однаковий для всіх каналів і становить близько $131–132.
-- 5. Основний вплив на виручку має кількість користувачів та замовлень, а не середній чек.
-- 6. Рекомендується збільшити увагу до каналів Instagram, Facebook та Google Ads.

-- Conclusions:
-- 1. Instagram is the most effective acquisition channel for female customers.
-- 2. Instagram generated the highest revenue ($190,547.29) and the largest number of orders (1,441).
-- 3. Facebook and Google Ads are the second and third strongest channels by revenue.
-- 4. The average check is similar across all channels (around $131–132).
-- 5. Revenue differences are mainly driven by the number of users and orders rather than average order value.
-- 6. It is recommended to focus marketing efforts on Instagram, Facebook, and Google Ads.

/* 7) Overall Acquisition Channels Performance */
select
   c.acquisition_channel
  ,count(distinct c.user_id) as users
  ,count(o.order_id) as orders
  ,sum(o.purchase_amount) as revenue
  ,avg(o.purchase_amount) as avg_check
from customers c
join orders o on c.user_id = o.user_id
group by c.acquisition_channel
order by revenue desc
limit 5;

-- Висновки:
-- 1. Цей запит показує найефективніші канали залучення серед усіх клієнтів.
-- 2. Основний показник ефективності — revenue, тобто загальна виручка.
-- 3. Канали з найбільшою виручкою варто розглядати як пріоритетні для маркетингових інвестицій.

-- Conclusions:
-- 1. This query shows the most effective acquisition channels among all customers.
-- 2. The main performance metric is revenue.
-- 3. Channels with the highest revenue should be considered as priority channels for marketing investme

/* 8) Order Channels Performance */
select
   o.order_channel
  ,count(o.order_id) as orders
  ,sum(o.purchase_amount) as revenue
  ,avg(o.purchase_amount) as avg_check
  ,avg(o.items_count) as avg_items
from orders o
group by o.order_channel
order by revenue desc;

-- Висновки:
-- 1. Цей запит показує, через які канали клієнти роблять замовлення.
-- 2. Google Ads має найвищу виручку серед order channels.
-- 3. Instagram має найбільшу кількість замовлень.
-- 4. Email має нижчий середній чек, ніж інші основні канали.
-- 5. Аналіз order_channel допомагає зрозуміти, де клієнти фактично купують.

-- Conclusions:
-- 1. This query shows which channels customers use to place orders.
-- 2. Google Ads has the highest revenue among order channels.
-- 3. Instagram has the largest number of orders.
-- 4. Email has a lower average check compared to the main channels.
-- 5. Order channel analysis helps to understand where customers actually make purchases.

/* 9) Payment Methods Performance */
select
   o.payment_method
  ,count(o.order_id) as orders
  ,sum(o.purchase_amount) as revenue
  ,avg(o.purchase_amount) as avg_check
from orders o
group by o.payment_method
order by revenue desc;

-- Висновки:
-- 1. Найбільшу виручку приносить Credit Card.
-- 2. Debit Card та PayPal також є важливими способами оплати.
-- 3. Cash on Delivery має найнижчу виручку серед способів оплати.
-- 4. Компанії варто підтримувати зручні онлайн-методи оплати, оскільки вони приносять основну частину доходу.

-- Conclusions:
-- 1. Credit Card generates the highest revenue.
-- 2. Debit Card and PayPal are also important payment methods.
-- 3. Cash on Delivery has the lowest revenue among payment methods.
-- 4. The company should support convenient online payment methods because they generate most of the revenue.

/* 10) Monthly Revenue Dynamics */
select
   strftime('%Y-%m', o.order_date) as order_month
  ,count(o.order_id) as orders
  ,sum(o.purchase_amount) as revenue
  ,avg(o.purchase_amount) as avg_check
from orders o
group by strftime('%Y-%m', o.order_date)
order by order_month;

-- Висновки:
-- 1. Цей запит показує динаміку замовлень і виручки по місяцях.
-- 2. Найвищі показники виручки спостерігаються в літні місяці.
-- 3. Наприкінці року кількість замовлень та виручка знижуються.
-- 4. Такий аналіз допомагає побачити сезонність продажів.

-- Conclusions:
-- 1. This query shows monthly order and revenue dynamics.
-- 2. The highest revenue is observed during summer months.
-- 3. At the end of the year, the number of orders and revenue decrease.
-- 4. This analysis helps to identify sales seasonality.
