# Import 3D models from BeyWeb

BeyBlox models, logos, and VFX style are ported from the sibling **[BeyWeb](../BeyWeb)** repo.

## Copy from BeyWeb root

| BeyWeb file | BeyBlox target |
|-------------|----------------|
| `storm_pegasus.glb` | `assets/Beys/Pegasus/` |
| `meteo_ldrago.glb` | `assets/Beys/LDrago/` |
| `rock_leone.glb` | `assets/Beys/Leone/` |
| `flame_libra.glb` | `assets/Beys/Libra/` |
| `dark_bull.glb` | `assets/Beys/Bull/` |
| `pegasusLogo.png` etc. | `assets/UI/Logos/` |

## Pipeline

1. Copy GLB from `../BeyWeb/`
2. Blender → scale to ~2 stud diameter (`reference/config.json` `defaultOuterRadius`)
3. Import to Roblox Studio or FBX export
4. Match collider inset `0.9` from BeyWeb `CONFIG.COLLIDER_INSET`

See [docs/BEYWEB_SOURCE.md](../docs/BEYWEB_SOURCE.md) for physics and ability port map.
