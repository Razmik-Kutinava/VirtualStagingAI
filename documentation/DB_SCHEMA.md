## Схема БД

### 1. users

- id — integer, PK
- email — string, NOT NULL, unique
- encrypted_password — string, NOT NULL
- reset_password_token — string, unique
- reset_password_sent_at — datetime
- remember_created_at — datetime
- confirmation_token — string, unique
- confirmed_at — datetime
- confirmation_sent_at — datetime
- unconfirmed_email — string
- created_at — datetime
- updated_at — datetime

### 2. images

- id — integer, PK
- user_id — integer, FK → users
- kind — string ("input"/"output")
- room_type — string
- metadata — json
- created_at — datetime
- updated_at — datetime
- file — Active Storage attachment

### 5. styles

- id — integer, PK
- name — string
- prompt — text
- created_at — datetime
- updated_at — datetime

### 6. generations

- id — integer, PK
- user_id — integer, FK → users
- input_image_id — integer, FK → images
- output_image_id — integer, FK → images, optional
- style_id — integer, FK → styles
- status — string (queued/running/succeeded/failed)
- error — text
- created_at — datetime
- updated_at — datetime

### 7. token_packages

- id — integer, PK
- name — string
- tokens_amount — integer
- price_cents — integer
- validity_days — integer, default: 90
- active — boolean, default: true
- created_at — datetime
- updated_at — datetime

### 8. token_purchases

- id — integer, PK
- user_id — integer, FK → users
- token_package_id — integer, FK → token_packages
- tokens_remaining — integer
- purchased_at — datetime
- expires_at — datetime
- created_at — datetime
- updated_at — datetime

### 9. token_transactions

- id — integer, PK
- user_id — integer, FK → users
- token_purchase_id — integer, FK → token_purchases, optional
- generation_id — integer, FK → generations, optional
- operation — string
- amount — integer
- created_at — datetime
- updated_at — datetime

### 10. payments

- id — integer, PK
- user_id — integer, FK → users
- token_package_id — integer, FK → token_packages
- amount_cents — integer
- currency — string, default: "RUB"
- status — string, default: "pending"
- cloudpayments_transaction_id — string, unique
- cloudpayments_invoice_id — string
- card_type — string
- card_last_four — string
- paid_at — datetime
- metadata — json
- created_at — datetime
- updated_at — datetime

---

### Связи

users ──1:N──► images
users ──1:N──► generations
users ──1:1──► subscriptions
users ──N:1──► subscription_plans
users ──1:N──► token_purchases
users ──1:N──► token_transactions
users ──1:N──► payments

subscription_plans ──1:N──► subscriptions (plan_id)
subscription_plans ──1:N──► subscriptions (scheduled_plan_id)

images ──1:N──► generations (input_image_id)
images ◄──1:1── generations (output_image_id)

styles ──1:N──► generations

token_packages ──1:N──► token_purchases
token_packages ──1:N──► payments

token_purchases ──1:N──► token_transactions
generations ──1:N──► token_transactions