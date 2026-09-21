Config = {
    -- Language: any file in locales/ (locales/en.lua = English). Copy en.lua to add a language.
    locale = 'en',

    -- 'auto' detects qbx_core / qb-core / es_extended / falls back to 'standalone'.
    -- 'standalone' has no real money accounts - balance checks are skipped (always allowed).
    framework = 'auto',

    -- 'auto' detects ox_inventory / qb-inventory. Decides how the sticky note item and (if
    -- payment.mode = 'item') the cash item are read, given and removed.
    inventory = 'auto',

    dealer = {
        -- Bare digits, matching sd-phone's own number shape now that its config generates and
        -- displays UK-style numbers: 10 stored digits starting with 7, shown as 07XXX XXXXXX
        -- (the leading 0 is added at display time - see configs/phone.lua's Number section).
        number = '7911123456',
        -- Display name shown at the top of the player's Messages thread with this number.
        name = 'Unknown',
    },

    stickyNote = {
        -- Must already exist as a real, usable item in your inventory's item config - this
        -- resource does not create item definitions, only registers the "use" behaviour.
        item = 'blackmarket_note',
        -- Consumed the moment it's used (you've read it, you know the number/phrase now) vs.
        -- kept in your inventory as a readable memento. Doesn't change how it functions either way.
        consumeOnUse = true,
        -- Pool a note's referral is randomly drawn from the first time it's used and has none
        -- yet. `text` is what's printed on the note (flavour only); `name` is the one word that
        -- actually has to appear in the player's message to the dealer - just "Wolf", not the
        -- whole sentence - matched case-insensitively as a substring. See server/main.lua's
        -- ensureNoteMeta for why duplicate names across two different notes still can't cause a
        -- conflict (each note is tracked by its own hidden id, never by the name text).
        phrases = {
            { name = 'Wolf',     text = 'tell him Wolf sent you' },
            { name = 'Ricky',    text = 'say Ricky sent you' },
            { name = 'Snake',    text = 'mention Snake gave you this' },
            { name = 'Chops',    text = 'say you got this off Chops' },
            { name = 'Ghost',    text = 'tell him Ghost sent you' },
            { name = 'Preacher', text = 'say Preacher pointed you here' },
        },
    },

    conversation = {
        -- Rotated randomly for a stranger's every message, so it doesn't feel like one fixed line.
        strangerReplies = {
            "Who's this?",
            "Do I know you?",
            "Wrong number.",
            "...who gave you this number?",
            "Not interested.",
        },
        -- How long the dealer takes to text back. Most replies land somewhere in min/max; every
        -- reply also has a longPauseChance of instead taking somewhere in longMin/longMax -
        -- reads like he's actually busy/cautious rather than replying on a fixed timer.
        replyDelay = {
            min = 5000,
            max = 20000,
            longPauseChance = 0.15,
            longMin = 30000,
            longMax = 120000,
        },
        -- How long a wrong guess keeps you on cooldown before the dealer answers again -
        -- stops someone machine-gunning every phrase they can think of.
        wrongPhraseCooldownMs = 4000,
        -- Sent once, the moment a phrase lands and the player is newly vetted.
        vettedIntro = "...alright. Here's what I've got. Just say what you want.",
        -- Sent whenever a vetted player's message doesn't match a catalog item.
        vettedFallback = "Didn't catch that. Say what you're after.",
    },

    -- No hardcoded/fake items - whatever's listed here is what's actually sellable, and this is
    -- the only place prices live (per unit - see order.maxQuantity below for ordering more than
    -- one). `item` must already exist in your inventory's item config. `aliases` are the other
    -- words a player might use for it ("can I get a bag of coke", "cocaine", etc) - the id and
    -- label are always matched too, aliases are just extra ones. Keep them lowercase.
    catalog = {
        { id = 'weed',  label = 'Bag of Weed', item = 'weed_bag',  price = 150, aliases = { 'weed', 'bud', 'marijuana', 'kush' } },
        { id = 'coke',  label = 'Bag of Coke', item = 'coke_bag',  price = 400, aliases = { 'coke', 'cocaine', 'blow', 'snow' } },
        { id = 'pills', label = 'Pills',       item = 'pills',     price = 90,  aliases = { 'pills', 'molly', 'mdma', 'ecstasy' } },
    },

    payment = {
        -- 'account' removes from a money account/balance (framework's cash account by default).
        -- 'item' removes a physical cash item from inventory instead. Cash is only ever
        -- checked/removed at COLLECTION, never at order time - see server/main.lua.
        mode = 'account',
        account = 'cash',
        cashItem = 'money',
    },

    order = {
        -- Minimum gap between two orders from the same player.
        cooldownMs = 60000,
        -- A number written anywhere in the order message ("10 bags of coke", "get me 5 pills")
        -- orders that many, capped at this. No number mentioned = 1. price and item count both
        -- scale with it.
        maxQuantity = 10,
        -- An order nobody collects auto-cancels after this long (no charge was ever taken, so
        -- there's nothing to refund).
        expirySeconds = 600,
        -- How close you need to be to the drop point to collect.
        collectDistance = 2.0,
        -- A ped spawns at the drop point for the player to hand cash to via ox_target, instead of
        -- collecting off thin air. Picked at random per order. Frozen, invincible, no combat -
        -- it's a prop with a target option on it, not an NPC that can be interacted with any
        -- other way or that reacts to being shot/shoved.
        npcModels = {
            'a_m_m_skidrow_01',
            'a_m_o_soucent_03',
            'g_m_y_ballaeast_01',
            'g_m_y_families_01',
        },
        -- Scenario the ped plays while waiting (leaning/loitering). '' spawns it idle with no
        -- scenario at all.
        npcScenario = 'WORLD_HUMAN_LEANING',
        -- Preset drop spots the dealer picks from at random for each order. Add your own -
        -- picking real, sensible coordinates is on you; this resource won't guess a good spot.
        dropSpots = {
            vector3(126.87, -1281.14, 29.27),
            vector3(-124.66, -1683.68, 33.34),
            vector3(729.86, -968.87, 24.62),
            vector3(-1108.9, -1668.7, 4.4),
        },
    },
}
