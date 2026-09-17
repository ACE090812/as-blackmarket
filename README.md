# sd_blackmarket

Phase 1 of the black-market dealer plan: a standalone resource, no edits to sd-phone itself.
The whole conversation happens in sd-phone's real Messages app - this resource just listens for
messages sent to the dealer's number and reacts.

## Before you start it

1. **Ensure order**: this resource must start *after* `ox_target`, `sd-phone` (and after your
   inventory/framework) in `server.cfg`.
2. **Create the sticky note item** in your inventory's own item config with the name you set in
   `config.lua`'s `stickyNote.item` (defaults to `blackmarket_note`). This resource does not
   create the item definition itself - only the behaviour when it's used - and exactly how you
   wire "used" to that behaviour depends on your inventory:

   - **ox_inventory**: point the item at this resource's client export in `data/items.lua`:
     ```lua
     ['blackmarket_note'] = {
         label = 'Scrawled Note',
         weight = 10,
         stack = false,
         close = true,
         client = {
             export = 'sd_blackmarket.blackmarket_note',
         },
     },
     ```
     An ox_inventory item does nothing when "Use" is pressed unless something client-side calls
     `exports.ox_inventory:useItem` for it first - that's what the export above does (it's a
     one-line pass-through in `client/main.lua`, registered under the item's own name). The actual
     reveal-the-number logic runs server-side, listening for ox_inventory's own
     `ox_inventory:usedItem` event - nothing else to configure for that part.
   - **qb-inventory**: no extra wiring needed - this resource registers the use handler itself
     via `QBCore.Functions.CreateUseableItem` on start, as long as the item exists in your
     `qb-core` shared items.
3. **Create the catalog items** the same way - every `item` field under `Config.catalog` needs to
   already exist in your inventory config, same reasoning. See "Item definitions" below for the
   full set of entries (sticky note + catalog + cash item) for both inventories.
4. **Set `Config.dealer.number`** to whatever number you want players to text.
5. **Fill in `Config.order.dropSpots`** with real coordinates from your own map/server - the four
   shipped are just placeholders so the resource runs out of the box; replace them.
5a. **Requires `ox_target`.** A ped spawns at the drop spot for each order - players collect by
   using the `ox_target` option on it, not by walking up and pressing a key. Pick your own
   `Config.order.npcModels` (random per order) and `Config.order.npcScenario` if you want the ped
   doing something other than leaning.
6. **Check `Config.framework` / `Config.inventory`** - `'auto'` detects qbx_core/qb-core/es_extended
   and ox_inventory/qb-inventory. Set explicitly if you run something auto-detect might get wrong.
7. **Check `Config.payment.mode`** - `'account'` (cash balance) or `'item'` (physical cash item),
   whichever matches how you want players to pay.

## Item definitions

Every item name below is whatever you set in `config.lua` - these examples use the shipped
defaults (`blackmarket_note`, `weed_bag`, `coke_bag`, `pills`, and `money` for the optional cash
item mode). Add whichever of these your setup actually needs - if `Config.payment.mode` is left
as `'account'`, you can skip the cash item entirely.

### ox_inventory (`data/items.lua`)

```lua
['blackmarket_note'] = {
    label = 'Scrawled Note',
    weight = 10,
    stack = false,
    close = true,
    client = {
        export = 'sd_blackmarket.blackmarket_note', -- see "Before you start it" above
    },
},

['weed_bag'] = {
    label = 'Bag of Weed',
    weight = 250,
    stack = true,
    close = true,
},

['coke_bag'] = {
    label = 'Bag of Coke',
    weight = 150,
    stack = true,
    close = true,
},

['pills'] = {
    label = 'Pills',
    weight = 50,
    stack = true,
    close = true,
},

-- Only needed if Config.payment.mode = 'item'. Most ox_inventory setups already ship a 'money'
-- item for exactly this purpose - check before adding a duplicate.
['money'] = {
    label = 'Cash',
    weight = 0,
    stack = true,
    close = true,
},
```

### qb-inventory (`qb-core`'s shared items, usually `shared/items.lua`)

```lua
['blackmarket_note'] = {
    name = 'blackmarket_note',
    label = 'Scrawled Note',
    weight = 10,
    type = 'item',
    image = 'blackmarket_note.png',
    unique = true,
    useable = true, -- this resource registers the actual use handler itself, see above
    shouldClose = true,
    description = 'A scrawled note. Someone wrote a number on it.',
},

['weed_bag'] = {
    name = 'weed_bag',
    label = 'Bag of Weed',
    weight = 250,
    type = 'item',
    image = 'weed_bag.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'A bag of weed.',
},

['coke_bag'] = {
    name = 'coke_bag',
    label = 'Bag of Coke',
    weight = 150,
    type = 'item',
    image = 'coke_bag.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'A bag of coke.',
},

['pills'] = {
    name = 'pills',
    label = 'Pills',
    weight = 50,
    type = 'item',
    image = 'pills.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Unmarked pills.',
},

-- Only needed if Config.payment.mode = 'item'. Most qb-inventory/qb-core setups already have a
-- 'money' (or similarly named) cash item - check before adding a duplicate, and point
-- Config.payment.cashItem at whatever yours is actually called.
['money'] = {
    name = 'money',
    label = 'Cash',
    weight = 0,
    type = 'item',
    image = 'money.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Cold hard cash.',
},
```

Every `image` field above needs a matching png in your inventory's own image folder
(`ox_inventory/web/images` or `qb-inventory`'s images resource) - this resource only registers
behaviour, it doesn't ship item art.

## How it plays

1. A player uses the sticky note item -> gets a notification with the dealer's number and a
   one-time code phrase unique to that note.
2. They text that number in the real Messages app. Until they say the right phrase, the dealer
   just gives wary one-liners ("who's this?" etc.) - no catalog, no ordering.
3. Once the phrase lands, the dealer "warms up" and lists the catalog. From then on that
   character is permanently vetted (persisted).
4. They text back an item name (or any of its `aliases` in `Config.catalog`, e.g. "cocaine" for
   coke), optionally with a quantity anywhere in the message ("can I get 10 bags of coke") -
   dealer confirms (price scales with quantity, capped at `Config.order.maxQuantity`) and sends a
   real location pin to a random configured drop spot. No charge yet.
5. They walk to the drop spot, where a ped is now waiting - `ox_target` on that ped ("Collect
   Order") is the only way to collect. Only at that point is the price actually checked/removed
   (cash account or cash item, per config) and the item added to their inventory. Not enough
   money on them and it just fails - the drop (and the ped) stays there until it expires.
6. One order at a time per player; an uncollected order auto-expires after
   `Config.order.expirySeconds`.
7. Replies aren't instant - `Config.conversation.replyDelay` randomizes how long the dealer takes
   to text back (a short-ish wait most of the time, occasionally a much longer one), so it reads
   like an actual person rather than a bot on a fixed timer.

## Known limitation - qb-inventory sticky notes

ox_inventory keeps real per-item metadata, so a note's code phrase is generated once and stays
attached to that specific physical item forever (even if you set `consumeOnUse = false`, so it
can be kept as a readable memento). qb-inventory doesn't expose that in a way this resource can
key off cleanly, so under qb-inventory a sticky note is **always consumed the instant it's used**,
regardless of the `consumeOnUse` setting - otherwise the same note could be reread for more
phrases indefinitely. If you're on qb-inventory and want the "keep it as a memento" behaviour,
switching to ox_inventory is the way to get it.

## Not in Phase 1 (see the roadmap doc)

- Trust/reputation levels, sting/police risk, scam chance - Phase 2.
- AI-generated dealer replies instead of the fixed lines in `config.lua` - Phase 3.
- Any voice/call version - Phase 4.

Everything above is config-driven on purpose - reply wording, phrases, prices, cooldowns, drop
spots - so none of it needs a code change to tune once it's running.
