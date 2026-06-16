# La Jefecita — Restaurant Ops Client (Flutter)

> Flutter client for the La Jefecita restaurant ops platform: role-scoped flows for waitstaff, kitchen, and cashier, intended to stay in sync with a real-time backend via WebSocket.

## Problem
Small-restaurant floor operations rely on handwritten tickets and walkie-talkie relays between waitstaff, kitchen, and cashier. The result: miscommunicated orders, lost tickets, late dishes, and messy end-of-shift cash reconciliation. A digital client is only useful if every role sees the same order state at the same time.

## Approach
A single Flutter codebase ships role-scoped UIs (waitstaff / kitchen / cashier / admin) from one app. Authentication picks the user's role and swaps the screen tree accordingly. Order state is intended to be kept consistent across every device on the floor through a WebSocket channel exposed by the backend, with Stripe handling the payment-capture step at the cashier role. This repository contains the client side of that system.

## Stack
| Layer | Tech |
|---|---|
| Client | Flutter / Dart (SDK `>=3.2.2 <4.0.0`) |
| HTTP | `dio` |
| State | `provider` |
| Config | `flutter_dotenv` |
| Logging | `logger` |
| Real-time (backend-side) | WebSockets (Socket.IO) |
| Payments (platform) | Stripe |
| Backend (separate repo) | NestJS + Socket.IO + PostgreSQL |

Targets scaffolded in this project: Android, iOS, web, Linux, macOS, Windows.

## Highlights
- Role-scoped client architecture (waitstaff / kitchen / cashier) from a single Flutter codebase
- WebSocket-driven order state model on the platform side, designed for low-latency updates across roles
- Stripe payment flow integration at the cashier role (platform-level)
- Cross-platform Flutter targets out of the box (mobile + web + desktop)

## Repo layout
```
lib/
  config/helpers/      # Auth + bootstrap helpers (e.g. getLogin.dart)
  domain/entities/     # Plain Dart entities (e.g. user_entity.dart)
  insfraestructure/    # Data models / DTOs (sic — folder name as-is)
  presentation/
    providers/         # ChangeNotifier providers (user_provider.dart)
    screens/           # Login + role dashboards (Waiter/, ...)
  main.dart            # App entry, dotenv bootstrap, route table
```

## Local setup
Requires Flutter SDK `>=3.2.2 <4.0.0`.

```bash
flutter pub get

# Create a .env at the repo root (loaded by flutter_dotenv at startup)
# Expected keys are read by lib/config/helpers/ — point them at your backend.
touch .env

flutter run            # default device
flutter run -d chrome  # web
```

The backend (NestJS API + Socket.IO gateway + PostgreSQL) lives in a separate, team-owned repository and is not part of this organization.

## Status & limitations
- **Early client build.** The shipped screens cover login and a waiter-side dashboard scaffold; the full kitchen and cashier UIs, the WebSocket wiring, and the Stripe checkout live at the platform level and are not all present in this client snapshot.
- **No Stripe or WebSocket Dart packages** are pinned in `pubspec.yaml` in this build — payment capture and real-time order state are implemented at the platform layer, not in this client snapshot. HTTP-side traffic uses `dio`.
- **Single-restaurant deployment.** No public demo.
- **Backend is not public** from this org — this repo is the client only.
- Auth and test coverage are minimal in this build.

## Team & my role
- **My role:** Designed the real-time order UI and the role-scoped client flows for the platform, and collaborated on the Flutter client implementation.
- **Team:** Multi-developer effort. Primary backend implementation by Daniel Zhu (`@Chu2409` / `@tichekiwar`), who also contributed the majority of overall commits across the project. I was not the dominant committer on the codebase as a whole.

## Related
- Portfolio: <https://devjaes.dev> (listed under *More Work*; highlight: **−30% order-entry errors**)
- Canonical project write-up: La Jefecita — full-stack restaurant management platform (Flutter client + NestJS API + Socket.IO gateway + PostgreSQL + Stripe)
