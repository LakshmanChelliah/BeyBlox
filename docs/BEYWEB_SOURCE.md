# BeyWeb Source Map

BeyBlox ports directly from the BeyWeb repo. Keep both repos checked out side-by-side:

```
Documents/
├── BeyWeb/    ← source (physics, models, moves, VFX)
└── BeyBlox/   ← Roblox port
```

## Physics (port first)

| BeyWeb file | What to port | BeyBlox target |
|-------------|--------------|----------------|
| `js/config.js` | Arena radius, spin decay, knockback | `reference/config.json` → `Physics/Config.lua` |
| `js/physics/top.js` | Spin gauge, wobble, launch drop-in | `Physics/Top.lua` |
| `js/physics/steer.js` | Steering force from MOVE stat | `Physics/Steer.lua` |
| `js/physics/contact.js` | Custom bey-vs-bey clashes | `Physics/Contact.lua` |
| `js/physics/arena.js` | KO pockets, ring-out | `Physics/Arena.lua` |
| `js/physics/arenaGeometry.js` | Pocket angles, wall normals | `Physics/ArenaGeometry.lua` |
| `js/physics/ringOut.js` | KO cinematic | `Physics/RingOut.lua` |
| `js/game/simulation.js` | Fixed 60 Hz tick loop | `MatchService.lua` |
| `js/game/stats.js` | ATK/DEF/STA multipliers | `Shared/Stats.lua` ✅ |
| `js/game/rules.js` | KO / SO / draw | `Shared/Rules.lua` ✅ |

## Special moves (ability registry)

All moves live in `js/game/abilities/impl.js` (`ABILITY_REGISTRY`). Beys reference IDs in `js/game/beys.js` `gimmicks` field.

Port order (complexity ascending):

1. `pegasus_speed_boost`
2. `bull_maximum_stampede`
3. `ldrago_spin_steal`
4. `leone_wide_ball`
5. `libra_sonic_shield`
6. `libra_sonic_buster`
7. `bull_red_horn_uppercut`
8. `leone_lion_wall`
9. `pegasus_star_blast` (multi-phase cinematic)
10. `ldrago_supreme_flight` (hover + lightning)

## VFX & animation style

| BeyWeb VFX module | Effect |
|-------------------|--------|
| `js/render/starBlastVfx.js` | Pegasus Star Blast slam |
| `js/render/pegasusSpeedBoostVfx.js` | Speed boost trail |
| `js/render/ldragoAbilityVfx.js` | Lightning strikes |
| `js/render/leoneAbilityVfx.js` | Tornado wall |
| `js/render/libraAbilityVfx.js` | Sonic shield + quicksand |
| `js/render/bullAbilityVfx.js` | Stampede + uppercut |
| `js/render/collisionSparksVfx.js` | Metal clash sparks |
| `js/render/top.js` | Spin visual, wobble tilt |

Special-move logo flash: `SPECIAL_WINDUP_MULT`, `SPECIAL_LOGO_FLASH_DUR` in `impl.js`.

## 3D models (GLB → Roblox)

| Bey | BeyWeb asset | Logo |
|-----|--------------|------|
| Storm Pegasus | `storm_pegasus.glb` | `pegasusLogo.png` |
| Meteo L-Drago | `meteo_ldrago.glb` | `updatedLdragoLogo.png` |
| Rock Leone | `rock_leone.glb` | `rockleonelogandFacebolt.png` |
| Flame Libra | `flame_libra.glb` | `flame_libralogo.png` |
| Dark Bull | `dark_bull.glb` | `darkbull_logo.png` |

Collider calibration: `CONFIG.COLLIDER_INSET = 0.9` in `config.js`.

## Networking parity

| BeyWeb | BeyBlox |
|--------|---------|
| `server/Room.js` | `MatchService.lua` |
| `js/net/snapshot.js` | Snapshot serializer |
| `js/net/interpolation.js` | Client interpolation |
| `js/net/remoteInput.js` | Input application on server |

## Parity testing

1. Record `matchSeed` + input log from BeyWeb online match
2. Replay through BeyBlox `MatchService`
3. Compare round outcomes within position epsilon

Target: identical KO/SO/draw for passive physics (no abilities) before porting gimmicks.
