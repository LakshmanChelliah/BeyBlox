# Implementation Roadmap

## Phase 0 — Repo & tooling ✅

- [x] Rojo project structure
- [x] Shared data modules
- [x] Reference JSON from BeyWeb
- [x] Design docs

## Phase 1 — Hub & profiles (2 weeks)

- [ ] Create Roblox place + connect Rojo
- [ ] Hub spawn with mode portals
- [ ] ProfileService + DataStore with session lock
- [ ] Bey select carousel UI
- [ ] Basic inventory display

## Phase 2 — Core battle (3 weeks)

- [ ] Arena bowl model + KO pockets
- [ ] Bey spawn, launch grace, drop-in
- [ ] Spin gauge, decay, wobble, sleep-out
- [ ] Custom clash + wall bounce
- [ ] Win detection (KO / SO / draw)
- [ ] Best-of-3 series flow
- [ ] Battle HUD (spin %, cooldowns)

## Phase 3 — Abilities (4 weeks)

- [ ] Ability registry pattern
- [ ] Port all 10 BeyWeb abilities
- [ ] VFX per ability (Particles, Beams)
- [ ] Special logo flash ScreenGui

## Phase 4 — PvP (2 weeks)

- [ ] MatchInput / MatchSnapshot remotes
- [ ] Client interpolation
- [ ] Ranked 1v1 queue
- [ ] ELO updates + leaderboards

## Phase 5 — Campaign & casual (1 week)

- [ ] 5-stage campaign controller
- [ ] AI tiers (port `js/input/ai.js`)
- [ ] Casual random rival + difficulty select

## Phase 6 — Meta & shop (2 weeks)

- [ ] XP + level ups
- [ ] Coin rewards
- [ ] Gacha roll UI + server validation
- [ ] Developer products (Robux)
- [ ] Daily free roll

## Phase 7 — Tournaments (2 weeks)

- [ ] Bracket generator
- [ ] Entry gates (BP + level + fee)
- [ ] Scheduled event UI
- [ ] Placement rewards

## Phase 8 — 2v2 (2 weeks)

- [ ] Party queue
- [ ] Team spawn layout
- [ ] Team ELO
- [ ] Tag-team or simultaneous mode

## Phase 9 — Parts & customization (3+ weeks)

- [ ] Part catalog
- [ ] Bey builder UI
- [ ] Stat recomputation
- [ ] Color variants on mesh

---

**Estimated total:** ~19 weeks solo dev, ~10 weeks with 2 engineers.

Prioritize Phase 2 before monetization — core battle feel is the product.
