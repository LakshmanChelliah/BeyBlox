# Progression & Economy

## Currencies

### Coins (soft)

| Source | Amount |
|--------|--------|
| Casual win | 40 |
| Ranked win | 60 |
| Ranked loss | 15 |
| Campaign stage clear | 150 |
| Campaign complete | 1000 |
| Daily login | 100 |
| Duplicate bey from roll | 50 |

### Free rolls

- 1 on first login each day (reset UTC)
- +1 at levels 5, 10, 15, 20, 25
- Campaign complete: +1 Epic roll token

### Robux products (configure in Creator Dashboard)

| Product | Robux | Grants |
|---------|-------|--------|
| Single Roll | 49 | 1 standard roll |
| 5-Roll Bundle | 199 | 5 rolls |
| 10-Roll Bundle | 349 | 10 rolls + pity progress |

## Bey Points (ELO)

- **Starting BP:** 1000
- **Display:** integer, shown as "Bey Points" in UI
- **Updates:** ranked 1v1, ranked 2v2, tournament matches only
- **Formula:** standard Elo with mode-specific K-factor (see `Shared/Elo.lua`)

### Leaderboards

- `Global` — OrderedDataStore, top 100
- `Friends` — filter client-side from cached top 1000
- `Weekly` — reset Monday 00:00 UTC, cosmetic badge for top 10

## Level curve

```
XP to reach level L = floor(100 × (L - 1)^1.65)
```

| Level | Cumulative XP | Typical time |
|-------|---------------|--------------|
| 5 | ~1,100 | 1–2 hours |
| 10 | ~4,600 | 5–8 hours |
| 15 | ~10,500 | 12–18 hours |
| 25 | ~28,000 | 30+ hours |

## Unlock table

| Content | How to unlock |
|---------|---------------|
| Storm Pegasus | Default |
| Dark Bull | Level 3 OR roll |
| Flame Libra | Level 5 OR roll |
| Rock Leone | Level 8 OR roll |
| Meteo L-Drago | Level 15 OR roll (3% base rate) |
| Flame Sagittario | Level 20 OR roll |
| Earth Eagle | Level 25 OR roll |
| Color variants | Rolls only |
| Parts | Rolls + campaign drops (phase 2) |

## Tournament gates

| Tier | Min level | Min BP | Entry fee |
|------|-----------|--------|-----------|
| Bronze | 3 | 0 | 0 |
| Silver | 8 | 1100 | 200 coins |
| Gold | 12 | 1300 | 500 coins |
| Platinum | 18 | 1500 | 1000 coins |
| Champion | 25 | 1700 | 2000 coins |

Failed gate shows specific requirement: *"Need 1300 Bey Points for Gold Cup"*.

## Gacha tables

### Standard roll (500 coins or 49 Robux)

| Reward | Weight | Notes |
|--------|--------|-------|
| Dark Bull | 28 | Uncommon |
| Flame Libra | 22 | Rare |
| Rock Leone | 14 | Epic |
| Storm Pegasus | 8 | Rare |
| Meteo L-Drago | 3 | Legendary |
| Pegasus Chrome variant | 12 | Cosmetic |
| Bull Shadow variant | 10 | Cosmetic |
| Spin Track 145 | 3 | Part (phase 2) |

### Pity rules

- Counter increments on each roll without Rare+ bey or Epic+ variant
- At 10: next roll guaranteed Rare+ from bey pool
- Counter visible in shop UI

## Anti-grind

- Casual coins: 100% for first 10 wins/day, 25% after
- Ranked BP: inactive 14 days → display "Rusty" badge, no penalty
- Smurf detection: new account + high win rate → accelerated K-factor (40) until 20 matches

## Battle pass (future)

- Free track: coins, variants
- Premium (Robux): exclusive arena skin, emotes, faster pity (+1 every 5 levels)
