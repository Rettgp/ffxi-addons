-- Jobs module - handles all job-related data and lookups
-- Provides job short names, colors, and trust job mappings

local Jobs = {}

-- Job ID to short name mapping
Jobs.short_names = {
    [1] = 'war',
    [2] = 'mnk',
    [3] = 'whm',
    [4] = 'blm',
    [5] = 'rdm',
    [6] = 'thf',
    [7] = 'pld',
    [8] = 'drk',
    [9] = 'bst',
    [10] = 'brd',
    [11] = 'rng',
    [12] = 'sam',
    [13] = 'nin',
    [14] = 'drg',
    [15] = 'smn',
    [16] = 'blu',
    [17] = 'cor',
    [18] = 'pup',
    [19] = 'dnc',
    [20] = 'sch',
    [21] = 'geo',
    [22] = 'run',
    [23] = 'mon'
}

-- Job colors inspired by WoW Details!
Jobs.colors = {
    war = { 255, 100, 100 },
    mnk = { 255, 200, 100 },
    whm = { 255, 255, 200 },
    blm = { 150, 100, 255 },
    rdm = { 255, 150, 150 },
    thf = { 255, 255, 100 },
    pld = { 200, 200, 255 },
    drk = { 200, 100, 150 },
    bst = { 180, 150, 100 },
    brd = { 100, 255, 200 },
    rng = { 180, 255, 100 },
    sam = { 255, 150, 100 },
    nin = { 150, 150, 200 },
    drg = { 100, 150, 255 },
    smn = { 100, 255, 150 },
    blu = { 100, 200, 255 },
    cor = { 200, 150, 100 },
    pup = { 200, 180, 150 },
    dnc = { 255, 150, 200 },
    sch = { 180, 150, 255 },
    geo = { 200, 200, 150 },
    run = { 150, 200, 200 },
    mon = { 200, 200, 200 },
    default = { 128, 128, 128 }
}

-- Trust name to job mapping (names have no spaces in-game)
Jobs.trusts = {
    -- Tanks
    ['Amchuchu'] = 'run',
    ['ArkEV'] = 'pld',
    ['ArkHM'] = 'war',
    ['August'] = 'pld',
    ['Curilla'] = 'pld',
    ['Gessho'] = 'nin',
    ['Mnejing'] = 'pld',
    ['Rahal'] = 'pld',
    ['Rughadjeen'] = 'pld',
    ['Trion'] = 'pld',
    ['Valaineral'] = 'pld',
    -- Melee
    ['Abenzio'] = 'thf',
    ['Abquhbah'] = 'war',
    ['Aldo'] = 'thf',
    ['Areuhat'] = 'war',
    ['ArkGK'] = 'sam',
    ['ArkMR'] = 'bst',
    ['Ayame'] = 'sam',
    ['BabbanMheillea'] = 'mnk',
    ['Balamor'] = 'drk',
    ['Chacharoon'] = 'thf',
    ['Cid'] = 'war',
    ['Darrcuiln'] = 'bst',
    ['Excenmille'] = 'pld',
    ['Fablinix'] = 'rdm',
    ['Gilgamesh'] = 'sam',
    ['Halver'] = 'pld',
    ['Ingrid'] = 'whm',
    ['Iroha'] = 'sam',
    ['IronEater'] = 'war',
    ['Klara'] = 'war',
    ['LehkoHabhoka'] = 'thf',
    ['LheLhangavo'] = 'mnk',
    ['LhuMhakaracca'] = 'bst',
    ['Lilisette'] = 'dnc',
    ['Lion'] = 'thf',
    ['Luzaf'] = 'cor',
    ['Maat'] = 'mnk',
    ['Maximilian'] = 'war',
    ['Mayakov'] = 'dnc',
    ['Mildaurion'] = 'pld',
    ['Morimar'] = 'bst',
    ['Mumor'] = 'dnc',
    ['NajaSalaheem'] = 'mnk',
    ['Naji'] = 'war',
    ['NanaaMihgo'] = 'thf',
    ['Nashmeira'] = 'pup',
    ['Noillurie'] = 'sam',
    ['Prishe'] = 'mnk',
    ['Rainemard'] = 'rdm',
    ['RomaaMihgo'] = 'thf',
    ['Rongelouts'] = 'war',
    ["Selh'teus"] = 'whm',
    ['ShikareeZ'] = 'drg',
    ['Tenzen'] = 'sam',
    ['Teodor'] = 'sam',
    ['UkaTotlihn'] = 'dnc',
    ['Volker'] = 'war',
    ['Zazarg'] = 'mnk',
    ['Zeid'] = 'drk',
    ['Matsui-P'] = 'nin',
    -- Ranged
    ['Elivira'] = 'rng',
    ['Makki-Chebukki'] = 'rng',
    ['Margret'] = 'rng',
    ['Najelith'] = 'rng',
    ['SemihLafihna'] = 'rng',
    -- Caster
    ['Adelheid'] = 'sch',
    ['Ajido-Marujido'] = 'blm',
    ['ArkTT'] = 'blm',
    ['D.Shantotto'] = 'blm',
    ['Gadalar'] = 'blm',
    ['Kayeel-Payeel'] = 'blm',
    ['Kukki-Chebukki'] = 'blm',
    ['Leonoyne'] = 'blm',
    ['Ovjang'] = 'rdm',
    ['Robel-Akbel'] = 'blm',
    ['Rosulatia'] = 'blm',
    ['Shantotto'] = 'blm',
    ['Ullegore'] = 'blm',
    -- Healer
    ['Cherukiki'] = 'whm',
    ['FerreousCoffin'] = 'whm',
    ['Karaha-Baruha'] = 'whm',
    ['Kupipi'] = 'whm',
    ['MihliAliapoh'] = 'whm',
    ['Monberaux'] = 'whm',
    ['Ygnas'] = 'whm',
    -- Support
    ['Arciela'] = 'rdm',
    ['Joachim'] = 'brd',
    ['KingOfHearts'] = 'rdm',
    ['Koru-Moru'] = 'rdm',
    ['Qultada'] = 'cor',
    ['Ulmia'] = 'brd',
    -- Special/Geo
    ['Brygid'] = 'geo',
    ['Cornelia'] = 'geo',
    ['Kupofried'] = 'geo',
    ['KuyinHathdenna'] = 'geo',
    ['Moogle'] = 'geo',
    ['Sakura'] = 'geo',
    ['StarSibyl'] = 'geo',
    -- Unity
    ['Apururu'] = 'whm',
    ['Flaviria'] = 'drg',
    ['InvincibleShield'] = 'war',
    ['JakohWahcondalo'] = 'thf',
    ['Pieuje'] = 'whm',
    ['Sylvie'] = 'geo',
    ['Yoran-Oran'] = 'whm',
}

-- Get job short name from job ID
function Jobs.get_short_name(job_id)
    return Jobs.short_names[job_id]
end

-- Get job color RGB table, returns default if not found
function Jobs.get_color(job_short)
    if job_short and Jobs.colors[job_short] then
        return Jobs.colors[job_short]
    end
    return Jobs.colors.default
end

-- Get trust's job by name
function Jobs.get_trust_job(name)
    return Jobs.trusts[name]
end

-- Check if a name is a known trust
function Jobs.is_trust(name)
    return Jobs.trusts[name] ~= nil
end

return Jobs
