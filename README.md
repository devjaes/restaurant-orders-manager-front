# La Jefecita - Restaurant Ops Client (Flutter)

> Flutter client for the La Jefecita restaurant ops platform: role-scoped flows for waitstaff, kitchen, and cashier, kept in sync with the backend through a real-time WebSocket layer.

## Problem

Small-restaurant floor operations rely on handwritten tickets and walkie-talkie relays between waitstaff, kitchen, and cashier. The result: miscommunicated orders, lost tickets, late dishes, and messy end-of-shift cash reconciliation. A digital client is only useful if every role sees the same order state at the same time.

## Approach

A single Flutter codebase ships role-scoped UIs from one app. Authentication routes the user to the right role tree (waitstaff / kitchen / cashier / admin) and swaps the screen surface accordingly. Order state stays consistent across every device on the floor through the platform's WebSocket channel, with Stripe handling payment capture at the cashier step.

## Stack

| Layer | Tech |
|---|---|
| Client | Flutter / Dart |
| HTTP | `dio` |
| State | `provider` |
| Config | `flutter_dotenv` |
| Real-time | WebSockets (Socket.IO) |
| Payments | Stripe |
| Backend (separate repo) | NestJS + Socket.IO + PostgreSQL |

Cross-platform targets out of the box: Android, iOS, web, Linux, macOS, Windows.

## Highlights

- Role-scoped client architecture (waitstaff / kitchen / cashier) from a single Flutter codebase
- WebSocket-driven order state across roles for low-latency updates
- Stripe payment flow integration at the cashier role
- Cross-platform Flutter targets out of the box (mobile + web + desktop)

## Local setup

Requires Flutter SDK `>=3.2.2 <4.0.0`.

```bash
flutter pub get

# Create a .env at the repo root (loaded by flutter_dotenv at startup)
# pointing at your backend instance.
touch .env

flutter run            # default device
flutter run -d chrome  # web
```

## Status

Single-restaurant deployment.

## Team & my role

- **My role:** Designed the real-time order architecture and the role-scoped client flows. Collaborated on Flutter client implementation with the team.
- **Team:** Multi-developer effort across the Flutter client and the NestJS + Socket.IO backend.

## Related

- Portfolio: <https://devjaes.dev/work/lajefecita> - highlight: **−30% order-entry errors**
