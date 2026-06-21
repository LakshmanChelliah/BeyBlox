# Game Design Document

## Elevator pitch

Launch, clash, and knock rivals out of a Metal Fusion stadium. Climb Bey Points leaderboards, enter ranked tournaments, unlock beys through play and gacha rolls, and customize parts and colors.

## Core loop

```
Hub → Pick mode → Select bey (+ parts) → Match (best of 3) → Rewards → Hub
```

### Match rules (inherited from BeyWeb)

- **KO** — launch opponent through a KO pocket or off the platform
- **Sleep Out** — opponent's spin hits 0%, wobble finishes, still delay elapses while yours still spins
- **Draw** — both beys sleep out on platform
- **Series** — first to 2 round wins (configurable for finals)

### Controls (Roblox)

| Action | PC | Mobile |
|--------|-----|--------|
| Steer | WASD / stick toward cursor | Virtual joystick or drag |
| Power move | Q | Ability bar slot 1 |
| Special move | E | Ability bar slot 2 |

Steering applies tangential force scaled by spin % and MOVE stat.

## Modes in detail

### Campaign

Linear 5-boss run mirroring BeyWeb tournament order:

1. Dark Bull (AI tier 0)
2. Flame Libra (tier 1)
3. Rock Leone (tier 2)
4. Storm Pegasus (tier 3)
5. Meteo L-Drago (tier 4)

Each stage is best-of-3. Losing a series restarts the stage. Completing the campaign grants a guaranteed Epic roll token and large XP bonus.

### Casual

Pick CPU difficulty (Easy → Extreme). Random rival from campaign roster. Good for practice and daily coin farming (diminishing returns after 10 wins/day).

### Ranked 1v1

- Matchmaking within ±150 Bey Points (expands after 30s in queue)
- K-factor ELO: 32 for first 30 matches, then 24
- Win: +15 to +30 BP typical; loss: symmetric
- Season resets soft floor (never below 800 if you played 50+ ranked)

### Ranked 2v2

- Queue solo or with friend (party size 2)
- Team Bey Points = average of both players
- Series: each player tags in per round OR simultaneous 2v2 free-for-all (design decision — default: tag team, one bey active per team at a time)
- Team assist: brief 0.5s repulse aura when tagging in (phase 2)

### Tournaments

Scheduled events (e.g. Saturday Gold Cup):

| Tier | Min level | Min Bey Points | Entry fee |
|------|-----------|----------------|-----------|
| Bronze Cup | 3 | 0 | Free |
| Silver Cup | 8 | 1100 | 200 coins |
| Gold Cup | 12 | 1300 | 500 coins |
| Platinum Cup | 18 | 1500 | 1000 coins |
| Champion League | 25 | 1700 | 2000 coins |

Single-elimination bracket, best-of-3 per round, best-of-5 finals. Top 4 earn bonus rolls + exclusive color variants.

### Friendly

No BP change. Invite via Roblox party or server code. Supports 1v1 and 2v2.

## Progression

### Player level

| Level | Unlock |
|-------|--------|
| 1 | Storm Pegasus (starter) |
| 3 | Dark Bull, Bronze tournaments |
| 5 | Flame Libra |
| 8 | Rock Leone, Silver tournaments |
| 12 | Gold tournaments |
| 15 | Meteo L-Drago |
| 18 | Platinum tournaments |
| 20 | Flame Sagittario (gacha-only otherwise) |
| 25 | Champion League, Earth Eagle |

XP sources: campaign stages, ranked wins, tournament placement, daily first-win bonus.

### Bey Points (ELO)

- Display name: **Bey Points** (BP)
- Starting rating: 1000
- Shown on profile, leaderboard, and pre-match VS screen
- Tournament tiers gate on minimum BP to keep brackets competitive

### Economy

| Currency | Earn | Spend |
|----------|------|-------|
| Coins | Matches, campaign, daily login | Standard rolls (500), tournament entry |
| Free rolls | Daily login, level milestones | Gacha |
| Robux | Purchase | Premium roll bundles, battle pass (future) |

### Gacha (rolls)

**Standard pool weights** (see `Progression.STANDARD_ROLL_POOL`):

- Common bey duplicates → convert to 50 coins
- New bey → added to collection
- Color variant → cosmetic overlay on bey mesh
- Part → added to inventory (phase 2)

Pity: guaranteed Rare+ every 10 rolls without Rare+.

### Parts system (phase 2)

Real Metal Fusion slots:

- Energy Ring — type bias, slight ATK/DEF/STA
- Fusion Wheel — primary combat stats
- Spin Track — height, STA
- Performance Tip — MOVE, behavior profile

Custom builds recomputed into effective ATK/MOVE/DEF/STA before match.

## Monetization (Roblox-compliant)

- Developer products: single roll, 5-pack, 10-pack
- Optional game pass: +1 daily roll, exclusive hub emote
- No pay-to-win stat boosts in ranked — paid rolls use same pool as coin rolls
- Cosmetic-only premium color packs (Robux)

## Social & retention

- Global BP leaderboard (OrderedDataStore)
- Friends leaderboard
- Clan tags (phase 3)
- Seasonal rank badges

## Audio / feel

- Launch countdown 3-2-1 Go Shoot!
- Collision metal clangs scaled by impact speed
- Special move logo flash (ScreenGui) before cinematic abilities
- KO slow-mo camera (client-only)

## Success metrics

- D1 retention > 25%
- Average session 12+ minutes
- 40% of DAU complete at least one ranked match
- Roll conversion 3–5% of DAU (industry benchmark)
