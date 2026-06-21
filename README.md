# BeyBlox

Roblox port of **[BeyWeb](https://github.com/LakshmanChelliah/BeyWeb)** (Spin Sumo) — Metal Fusion beyblade battles with campaign, tournaments, ranked PvP, 2v2, Bey Points leaderboards, leveling, and gacha rolls.

**BeyWeb is the source of truth** for physics formulas, animation timing, bey models (GLB), special moves, VFX style, and ability tuning. This repo ports those systems to Luau + Roblox Studio.

## BeyWeb → BeyBlox

| BeyWeb (source) | BeyBlox (target) |
|-----------------|------------------|
| `js/physics/*` | `ServerScriptService/Physics/` |
| `js/game/abilities/impl.js` | `Shared/Abilities/` |
| `js/render/*Vfx.js` | Client VFX modules |
| `*.glb` models | `assets/Beys/` (import pipeline) |
| Cannon-es 60 Hz sim | Server-authoritative fixed tick |
| WebSocket rooms | TeleportService + Remotes |

Sibling checkout: `../BeyWeb` — copy GLBs and reference JS when porting.

## Quick start

```bash
cd BeyBlox
aftman install
rojo serve
```

Open Roblox Studio → Rojo plugin → Connect.

## Game modes

Campaign · Casual · Ranked 1v1 · Friendly 1v1 · Ranked 2v2 · Tournaments · Practice

## Progression

Player Level · Bey Points (ELO) · Coins · Gacha rolls · Parts & color variants (phase 2)

See [docs/GAME_DESIGN.md](docs/GAME_DESIGN.md) and [docs/PROGRESSION_ECONOMY.md](docs/PROGRESSION_ECONOMY.md).

## Repo layout

```
BeyBlox/
├── src/           # Luau (Rojo)
├── reference/     # JSON ported from BeyWeb
├── assets/        # Models imported from BeyWeb GLBs
├── docs/          # Design & architecture
└── scripts/       # Tooling + GitHub issue sync
```

## Development tracking

All work is tracked as [GitHub Issues](https://github.com/LakshmanChelliah/BeyBlox/issues) with phase labels (`phase-1` … `phase-10`) and area labels (`physics`, `graphics`, `animations`, `abilities`, etc.).

See [docs/ROADMAP.md](docs/ROADMAP.md) for phase overview.

## Docs

- [Architecture](docs/ARCHITECTURE.md)
- [Migration from BeyWeb](docs/MIGRATION_FROM_BEYWEB.md)
- [BeyWeb source map](docs/BEYWEB_SOURCE.md)
