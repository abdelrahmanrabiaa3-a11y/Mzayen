# المزين / Almozayen: barber booking prototype

- `backend/`: Node.js + Express + PostgreSQL API, plus the admin dashboard at `/admin`
- `app/`: React Native (Expo) app for Android, iOS and web, Arabic and English

## Run locally
1. Backend: `cd backend && cp .env.example .env` (fill it in), `npm install`, `npm start`. The tables are created automatically on first start and the admin account comes from ADMIN_EMAIL and ADMIN_PASSWORD.
2. App: `cd app && cp .env.example .env`, `npm install`, `npx expo start` (press `w` for web, or scan the QR code with Expo Go).

## Deploy
- Backend: Railway, root directory `backend`, add a PostgreSQL service, set DATABASE_URL, JWT_SECRET, ADMIN_EMAIL, ADMIN_PASSWORD, ALLOWED_ORIGIN.
- App (web): Vercel, root directory `app`, env var EXPO_PUBLIC_API_URL = your Railway URL.

## Security notes (prototype)
Rate limits per IP, bcrypt passwords, JWT roles, a signed one-time anti-bot challenge plus a honeypot field, and a unique database index that stops two people booking the same slot.
