-- NM Database for FFXI
-- Contains notorious monsters organized by expansion/region

local nm_database = {}

-- Create a set for fast lookup
nm_database.nm_set = {}
nm_database.nm_details = {}

-- Helper function to add NMs
local function add_nm(name, zone, level, family)
    nm_database.nm_set[name:lower()] = true
    nm_database.nm_details[name:lower()] = {
        name = name,
        zone = zone,
        level = level,
        family = family
    }
end

-- Rise of the Zilart NMs
add_nm("Fafnir", "Dragon's Aery", 85, "Dragon")
add_nm("Nidhogg", "Dragon's Aery", 85, "Dragon")
add_nm("Tiamat", "Attohwa Chasm", 85, "Dragon")
add_nm("Vrtra", "King Ranperre's Tomb", 85, "Dragon")
add_nm("Jormungand", "Uleguerand Range", 85, "Dragon")
add_nm("Aspidochelone", "Phomiuna Aqueducts", 75, "Adamantoise")
add_nm("Adamantoise", "Valley of Sorrows", 75, "Adamantoise")

-- Sky Gods
add_nm("Kirin", "Ru'Aun Gardens", 85, "Kirin")
add_nm("Suzaku", "Ru'Aun Gardens", 80, "Wyrm")
add_nm("Seiryu", "Ru'Aun Gardens", 80, "Wyrm")
add_nm("Genbu", "Ru'Aun Gardens", 80, "Wyrm")
add_nm("Byakko", "Ru'Aun Gardens", 80, "Wyrm")

-- Dynamis Lord NMs
add_nm("Dynamis Lord", "Dynamis - Xarcabard", 99, "Demon")
add_nm("Ying", "Dynamis - Beaucedine", 90, "Demon")
add_nm("Yang", "Dynamis - Beaucedine", 90, "Demon")

-- Chains of Promathia NMs
add_nm("Absolute Virtue", "The Empyrean Paradox", 99, "Avatar")
add_nm("Jailer of Love", "The Garden of Ru'Hmet", 95, "Jailer")
add_nm("Jailer of Hope", "Grand Palace of Hu'Xzoi", 95, "Jailer")
add_nm("Jailer of Faith", "Grand Palace of Hu'Xzoi", 95, "Jailer")
add_nm("Jailer of Fortitude", "Al'Taieu", 90, "Jailer")
add_nm("Jailer of Justice", "Al'Taieu", 90, "Jailer")
add_nm("Jailer of Prudence", "Al'Taieu", 90, "Jailer")

-- Limbus NMs
add_nm("Proto-Omega", "Apollyon", 85, "Weapon")
add_nm("Proto-Ultima", "Apollyon", 85, "Weapon")
add_nm("Arch-Omega", "Apollyon", 90, "Weapon")
add_nm("Arch-Ultima", "Apollyon", 90, "Weapon")

-- Einherjar NMs
add_nm("Odin", "Odin's Chamber", 99, "Avatar")

-- Notable Zone NMs
add_nm("King Arthro", "Crawlers' Nest", 45, "Crawler")
add_nm("Guivre", "Ifrit's Cauldron", 75, "Wyrm")
add_nm("Dune Widow", "Western Altepa Desert", 50, "Spider")
add_nm("Nue", "Labyrinth of Onzozo", 65, "Bat")
add_nm("Simurgh", "Ro'Maeve", 75, "Roc")
add_nm("Serket", "Quicksand Caves", 75, "Scorpion")
add_nm("Leaping Lizzy", "South Gustaberg", 10, "Lizard")
add_nm("Valkurm Emperor", "Valkurm Dunes", 20, "Fly")
add_nm("Stray Mary", "Gusgen Mines", 25, "Ghost")
add_nm("Mee Deggi the Punisher", "Jugner Forest", 30, "Orc")
add_nm("Argus", "Meriphataud Mountains", 30, "Fly")
add_nm("Jolly Green", "Rolanberry Fields", 35, "Goblin")
add_nm("Leech King", "Ordelle's Caves", 40, "Leech")
add_nm("Bloodtear Baldurf", "Davoi", 45, "Orc")
add_nm("Chonchon", "Pashhow Marshlands", 40, "Fly")
add_nm("Fraelissa", "Konschtat Highlands", 45, "Skeleton")
add_nm("Dum-a-lum", "La Theine Plateau", 50, "Goblin")
add_nm("Kreutzet", "Batallia Downs", 55, "Skeleton")
add_nm("Supplice", "Beaucedine Glacier", 60, "Demon")
add_nm("Shikigami Weapon", "Shrine of Ru'Avitau", 70, "Weapon")
add_nm("Steam Cleaner", "Zeruhn Mines", 15, "Bomb")
add_nm("Cargo Crab Colin", "Bibiki Bay", 55, "Crab")
add_nm("Deadly Dodo", "Lufaise Meadows", 60, "Dodo")

-- Treasure Casket NMs
add_nm("Mimic", "Various", 75, "Mimic")
add_nm("Cursed Chest", "Various", 75, "Mimic")

-- Abyssea NMs
add_nm("Briareus", "Abyssea - Konschtat", 99, "Gigas")
add_nm("Sobek", "Abyssea - Grauberg", 99, "Peiste")
add_nm("Turul", "Abyssea - Uleguerand", 99, "Roc")
add_nm("Kutharei", "Abyssea - Attohwa", 99, "Wyvern")
add_nm("Cirein-croin", "Abyssea - Konschtat", 99, "Sea Monk")
add_nm("Sedna", "Abyssea - Tahrongi", 99, "Sea Monk")
add_nm("Hadhayosh", "Abyssea - Tahrongi", 99, "Buffalo")
add_nm("Apademak", "Abyssea - Tahrongi", 99, "Buffalo")
add_nm("Ulhuadshi", "Abyssea - Vunkerl", 99, "Peiste")
add_nm("Durinn", "Abyssea - Vunkerl", 99, "Dwarf")

-- Walk of Echoes NMs
add_nm("Rani", "Walk of Echoes", 99, "Mantis")
add_nm("Kaggen", "Walk of Echoes", 99, "Mantis")

-- Voidwatch NMs
add_nm("Pil", "Voidwatch", 99, "Hpemde")
add_nm("Provenance Watcher", "Voidwatch", 99, "Watcher")
add_nm("Void Hare", "Voidwatch", 99, "Rabbit")

-- Seekers of Adoulin NMs
add_nm("Kumhau", "Yahse Hunting Grounds", 99, "Tiger")
add_nm("Tchakka", "Yahse Hunting Grounds", 99, "Raaz")
add_nm("Kaggen", "Ceizak Battlegrounds", 99, "Mantis")
add_nm("Yumcax", "Yorcia Weald", 99, "Snapweed")
add_nm("Keesha Poppo", "Yorcia Weald", 99, "Poroggo")

-- Delve NMs
add_nm("Tojil", "Yorcia Weald [U]", 119, "Yorcia")
add_nm("Hapaimaru", "Morimar Basalt Fields [U]", 119, "Craklaw")
add_nm("Matamata", "Foret de Hennetiel [U]", 119, "Snapweed")
add_nm("Pazuzu", "Cirdas Caverns [U]", 119, "Demon")
add_nm("Leafkin", "Ra'Kaznar Inner Court [U]", 119, "Mandragora")
add_nm("Kyou", "Ra'Kaznar Turris [U]", 119, "Raaz")

-- Reisenjima NMs
add_nm("Schah", "Reisenjima", 130, "Wraith")
add_nm("Kouryu", "Reisenjima", 135, "Dragon")
add_nm("Azi Dahaka", "Escha - Ru'Aun", 135, "Khimaira")
add_nm("Vinipata", "Reisenjima", 128, "Panopts")
add_nm("Warder of Courage", "Reisenjima", 125, "Avatar")

-- Classic King HNMs
add_nm("King Behemoth", "Behemoth's Dominion", 85, "Behemoth")
add_nm("Behemoth", "Behemoth's Dominion", 75, "Behemoth")

-- Beastmen Kings
add_nm("Tzee Xicu the Manifest", "Den of Rancor", 80, "Yagudo")
add_nm("Shadow Lord", "Castle Zvahl Baileys", 80, "Demon")
add_nm("Archlich Taber'quoan", "Eldieme Necropolis", 75, "Skeleton")

-- BCNM/KSNM NMs
add_nm("Maat", "Balga's Dais", 70, "Hume")
add_nm("Tenzen", "Waughroon Shrine", 70, "Samurai")

-- Ambuscade NMs (recent content)
add_nm("Kin", "Ambuscade", 119, "Dragon")
add_nm("Gin", "Ambuscade", 119, "Dragon")

-- Legion NMs
add_nm("Arch Dynamis Lord", "Dynamis - Xarcabard", 99, "Demon")

-- Domain Invasion NMs
add_nm("Sinister Reign", "Various Domains", 119, "Demon")

-- Omen Bosses
add_nm("Fu", "Omen", 125, "Fu")
add_nm("Kyou", "Omen", 125, "Kyou")
add_nm("Kin", "Omen", 125, "Kin")
add_nm("Gin", "Omen", 125, "Gin")
add_nm("Kei", "Omen", 125, "Kei")

-- Helper functions
function nm_database.is_nm(name)
    if not name then return false end
    return nm_database.nm_set[name:lower()] == true
end

function nm_database.get_details(name)
    if not name then return nil end
    return nm_database.nm_details[name:lower()]
end

function nm_database.get_count()
    local count = 0
    for _ in pairs(nm_database.nm_set) do
        count = count + 1
    end
    return count
end

return nm_database
