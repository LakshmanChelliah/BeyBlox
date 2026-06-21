# Migration from BeyWeb

This document maps BeyWeb (Three.js + Cannon-es + WebSocket) systems to BeyRoblox (Roblox Studio + Luau).

## Direct ports (logic-only)

| BeyWeb | BeyRoblox | Status |
|--------|-----------|--------|
| `js/game/beys.js` | `Shared/BeyCatalog.lua` + `reference/beys.json` | Scaffolded |
| `js/game/stats.js` | `Shared/Stats.lua` | Ported |
| `js/game/rules.js` | `Shared/Rules.lua` | Ported |
| `js/game/modes.js` | `Shared/GameModes.lua` | Extended |
| `js/game/campaign.js` | `reference/campaign.json` | Data only |
| `js/config.js` | `reference/config.json` | Data only |
| `js/game/abilities/impl.js` | `Shared/Abilities/*` (TODO) | Not started |
| `js/physics/*.js` | `ServerScriptService/Physics/*` (TODO) | Not started |
| `js/net/snapshot.js` | MatchService snapshots (TODO) | Not started |
| `js/net/interpolation.js` | Client Interpolation (TODO) | Not started |
| `server/Room.js` | `MatchService.lua` | Scaffolded |

## Assets

Copy from BeyWeb root:

```
storm_pegasus.glb   → assets/Beys/Pegasus/
meteo_ldrago.glb    → assets/Beys/LDrago/
rock_leone.glb      → assets/Beys/Leone/
flame_libra.glb     → assets/Beys/Libra/
dark_bull.glb       → assets/Beys/Bull/
*Logo.png           → assets/UI/Logos/
```

See `assets/README.md` for Blender → Roblox pipeline.

## Physics differences

| Concept | BeyWeb | Roblox |
|---------|--------|--------|
| Engine | Cannon-es rigid bodies | Custom forces on BaseParts |
| Spin | 0–1 gauge in state | Same gauge; visual via `CFrame` spin |
| Collisions | Custom 2D clash resolver | Port same math; ignore default elasticity |
| Arena | Three.js mesh + pocket angles | MeshPart bowl + same angle constants |
| Gravity | `CONFIG.GRAVITY = 14` | Tune `workspace.Gravity` or per-body force |

**Critical:** BeyWeb disables cannon top-top contacts. Roblox must use the same approach — manual clash resolution each tick.

## Abilities port order

Recommended order (complexity ascending):

1. `pegasus_speed_boost` — steer multiplier only
2. `bull_maximum_stampede` — temporary speed + knockback buff
3. `ldrago_spin_steal` — collision hook steals spin
4. `leone_wide_ball` — plant + damage reduction
5. `libra_sonic_shield` — radial repulse aura
6. `libra_sonic_buster` — center pull field
7. `bull_red_horn_uppercut` — rim charge + launch
8. `leone_lion_wall` — hover + tornado pulses
9. `pegasus_star_blast` — multi-phase cinematic
10. `ldrago_supreme_flight` — hover + lightning strikes

Each ability = one ModuleScript in `Shared/Abilities/` with `onActivate`, `onStep`, `onEnd`, `onContact` hooks matching BeyWeb registry.

## Online → Roblox networking

| BeyWeb | Roblox |
|--------|--------|
| WebSocket room code | TeleportService to arena + reserved server |
| 60 Hz input send | `MatchInput` RemoteEvent |
| Snapshot broadcast | `MatchSnapshot` UnreliableRemoteEvent |
| Bey lock | Pre-match ready gate in MatchService |
| 15s disconnect forfeit | `Players.PlayerRemoving` + timeout |

## New systems (not in BeyWeb)

- ProfileService / DataStore
- Elo / Bey Points
- Shop / gacha rolls
- MarketplaceService
- Tournament brackets
- 2v2 team modes
- Parts customization
- Hub world & leaderboards

## Parity testing

1. Export match seed + input log from BeyWeb (`matchSeed` in Room.js)
2. Replay inputs through Roblox MatchService
3. Compare round outcomes (KO/SO/draw) and final positions within epsilon

Target: identical results for passive physics (no abilities) before porting gimmicks.

## Suggested first milestone

**Playable 1v1 casual** with Pegasus vs Bull, no abilities, KO + SO only:

- [ ] Import one bey model
- [ ] Bowl arena with 3 pockets
- [ ] Spin decay + steer + clash
- [ ] Best-of-3 series UI
- [ ] Local server test with 2 Studio players
