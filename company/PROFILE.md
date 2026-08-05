# Evolta — Company Profile (single source of truth)

> Every agent reads this before acting. Fill in the `[TODO]` fields. Keep it
> current — this file is the company's shared memory.

## 1. What Evolta is
- **One-line description:** Evolta is a software company that (1) builds and sells
  its own AI and traditional software products with support services, (2)
  markets and distributes AI software products into Singapore and Southeast Asia
  (SEA), and (3) runs **Evolta.AI** — a free, non-profit learning platform of
  interactive games and articles teaching real concepts to everyone.
- **Industry / category:** Software — product development studio + software
  distribution / reseller.
- **Stage:** Early — three products in build (one near-MVP, one live open-source
  credibility project, one piano app in progress) + an inbound distribution
  partnership opportunity. [TODO — confirm pre-revenue? any paying users yet?]
- **Website / handles:** [TODO]  (note: `mmedabo/Evolta` and `striris/Evolta`
  repos exist — confirm which is the company site/home)

## 2. Business lines

### Line 1 — Product Studio (build & sell software + support)
Build AI and regular software products/apps and sell them with support services.

**Portfolio / pipeline:**
| Product | What it is | Target user | Stage (reviewed 2026-08-03) |
|---------|-----------|-------------|-------|
| Pianio | Piano / music learning app (user side + admin side) | Learners (consumer) + admin | ~60–70% built. Designed in **Claude Design**, implemented in a **Claude Code session** (user + admin sides). **Not in an accessible GitHub repo yet** — needs to be pushed to a repo (or code shared) before engineering can review it. |
| Form Coach | Privacy-first PWA: sport training + **on-device computer-vision** form coach (volleyball live; tennis/basketball/soccer queued). Python R&D `analysis/` folder (ball/rally trackers). | Athletes / trainees (consumer); gov innovation story | ~60% MVP. **Active repo: `mmedabo/formcoach`** (confirmed; ignore `form-coach-deluxe`). Remaining: finish CV model + more sports. Positioned for **Singapore gov startup / tech-innovation** grant angle. |
| Agent Firewall | Local-first **security scanner + runtime firewall** for AI agents/skills/MCP servers. Maps to OWASP LLM/Agentic + MITRE ATLAS. | Developers / security teams (open-source community) | **Mature — v1.3.0, "Production/Stable"**, 27 modules, 170 tests, CI. Repo `mmedabo/AgentFirewall`. **Open source, not for sale — company credibility asset.** |
| _More ideas_ | Ongoing brainstorm — capture here as they firm up | | Idea |

### Line 2 — Software Distribution in Singapore & SEA ("Blue Cloud Soft Tech")
Retail / distribution of AI software products into the Singapore and SEA market.
Plan: establish **partner agreements** to market and distribute software solutions
across Singapore and the broader SEA / Asia-Pacific region.

- **Blue Cloud Soft Tech** = a **separate company** (a partner, not an Evolta
  entity) that has AI-orchestrated software/services and an interest in expanding
  into Singapore & APAC. They have offered Evolta a **reseller / distribution
  partnership** for those AI-orchestrated services. [confirm details]
- [TODO — get the actual product list + what "AI-orchestrated services" covers]
- **Target markets:** Singapore first, then broader SEA / Asia-Pacific.
- [TODO — commercial model: reseller margin / referral / exclusivity / licensing?]
- **Status (2026-08-03):** Founder has **already met the CEO of Blue Cloud
  Softech** and is **confident the partnership will happen**. Next: Blue Cloud is
  providing **product demos**; founder will then run a **business analysis** of
  their offerings. **This is a designated MAJOR strategic asset / focus for
  Evolta** — not a "later" bet. Still to formalize: term sheet (margin,
  exclusivity, customer ownership, support, targets, IP, PDPA/data residency).

### Line 3 — Evolta.AI: free learning (non-profit / mission)
**Live at [evolta.ai](https://evolta.ai)** — the original Evolta content: free,
interactive **learning games, simulations and articles** that teach real concepts.
Bilingual **English / 中文**. Static site, no paywall, no login.

- **Tagline:** *"learn, play, evolve"*
- **Product promise:** *"learning is a right, not a privilege"* — everything free.
- **Philosophy (verbatim from the site):** *"Never in history has knowledge been so
  easy to access. The only wall stopping you is your desire to learn. We help you
  break that wall and evolve with a smile."*
- **Positioning:** AI-powered software products supporting learning, skill
  development and performance improvement through interactive educational games,
  simulations and training tools **for everyone**.
- **Repo:** `striris/Evolta` (site source, CNAME → evolta.ai); fork at `mmedabo/Evolta`.
- **Contact:** hello@evolta.ai · mailing list on site.

**Catalogue (16 pages live):**
| Domain | Titles |
|--------|--------|
| Trading & markets | Trading Sandbox portal · *Peak & Dispatch* (power trading) · *Sweet Spread* (sugar) · *The Spread* (market making) · *Safe Harbor* (portfolio hedging) |
| Finance | *The Ledger* — corporate finance academy, 10 chapters (statements, ratios, Du Pont, Modigliani–Miller, WACC) |
| Energy | *LNG Academy* — 8-chapter junior-trader voyage w/ mentor + badges · *First Cargo* capstone simulator |
| Maths & stats | *Quick Math* · *Shape Quest* (4 geometry games) · **StatLab — AI Fundamentals** (7 levels + boss round, HintBot) |
| Science | *Collision* — momentum & energy lab |
| Humanities & fun | *Aporia* (philosophy personality quiz) · *Atlas* (city match) · *Reversi* (flip chess, AI opponent) |

**Governance / people — [TODO confirm]:** the site lists **Xinran Liu as Founder**,
with **Madhav Medaboina as a Contributor (StatLab — AI Fundamentals)**, plus
contributors Bangyuan Zhu (Reversi) and Qingyi He (Collision).
→ **Clarify the relationship between Evolta.AI (this collaborative learning
project) and Evolta the company** — same entity, sister non-profit, or separate?
This determines who owns the brand, the IP, and how a non-profit arm is structured.

**Strategic role:** mission + brand + top-of-funnel credibility. Free by design —
it is **not** a revenue line. Feeds the company's reputation (and the Singapore
innovation story) the same way Agent Firewall does.

## 3. Customers
- **Line 1 — consumer apps (Pianio, Sport Form Coach):** individual learners /
  athletes. [confirm + refine ICP]
- **Line 1 — B2B (Agent Firewall):** businesses deploying/using AI agents.
  [TODO — confirm and define ICP]
- **Line 2 — distribution:** SEA businesses and/or consumers, plus channel
  partners. [TODO — define who we sell *through* vs. *to*]
- **Their main pain / job-to-be-done:** [TODO per segment]

## 4. Market & competition
- **Main competitors:** [TODO per product + per distribution market]
- **How we position against them:** [TODO]

## 5. Brand & voice
- **Tone:** [TODO]
- **Words we use / avoid:** [TODO]
- **Visual identity notes:** [TODO]

## 6. Goals
- **This quarter's #1 goal:** [TODO — to be proposed by the `ceo` agent and
  confirmed by the founder]
- **12-month vision:** Establish Evolta as both a shipping software-product studio
  and a go-to distributor of AI software in Singapore / SEA.
- **Constraints (budget, team, time):** [TODO — solo founder? team? monthly
  budget? hours/week?]

## 7. Assets & accounts
- **Tools/stacks in use:** [TODO]
- **Social/ad accounts:** [TODO]
- **Guardrails (things agents must NOT do):** [TODO — e.g. no signing partner
  agreements, no public pricing commitments, without founder sign-off]

---
_Until a field is filled, agents will treat it as unknown and flag assumptions
rather than inventing facts._
