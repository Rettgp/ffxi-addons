return {
  quests = {
    {
      id = "mission_bastok_1_1",
      name = "The Zeruhn Report (1-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 1, -- Sequential index within nation (1-based)
      repeatable = false,
      steps = {
        "Receive mission from any Bastok Gate Guard",
        "Go to Bastok Mines (D-7) and enter Zeruhn Mines",
        "Talk to Makarim (H-11) in Zeruhn Mines for Zeruhn Report",
        "Deliver the report to Naji (J-8) in Metalworks"
      }
    },
    {
      id = "mission_bastok_1_2",
      name = "A Geological Survey (1-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 2,
      repeatable = false,
      steps = {
        "Talk to Bastok Gate Guard to receive mission",
        "Talk to Cid (H-8) in Metalworks for Blue Acidity Tester",
        "Go to Dangruf Wadi geyser (I-8) and stand on it",
        "Return to Cid in Metalworks"
      }
    },
    {
      id = "mission_bastok_1_3",
      name = "Fetichism (1-3)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 3,
      repeatable = false,
      steps = {
        "Receive mission from Bastok Gate Guard",
        "Obtain Fetich Head, Arms, Torso, and Legs from Quadav",
        "Trade all 4 fetich parts to a Bastok Gate Guard",
        "(Optional) Talk to Gumbah (J-7) in Bastok Mines"
      }
    },
    {
      id = "mission_bastok_2_1",
      name = "The Crystal Line (2-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 4,
      repeatable = false,
      steps = {
        "Talk to Cid (H-8) in Metalworks",
        "Trade a crystal to Crag of Dem telepoint (Konschtat Highlands)",
        "Trade the Faded Crystal to Cid for C.L. Report",
        "Talk to Ayame (K-7) in Metalworks to complete"
      }
    },
    {
      id = "mission_bastok_2_2",
      name = "Wading Beasts (2-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 5,
      repeatable = true,
      steps = {
        "Talk to Bastok Gate Guard for mission",
        "Trade 1 crystal to complete (repeatable rank missions)"
      }
    },
    {
      id = "mission_bastok_2_3",
      name = "The Emissary (2-3)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 6,
      repeatable = false,
      steps = {
        "Talk to Naji (J-8) in Metalworks",
        "Visit San d'Oria: Talk to Helaku/Halver, defeat Warchief Vatgit",
        "Visit Windurst: Talk to Melek/Kupipi, enter BCNM at Balga's Dais",
        "Return to Naji with Kindred Report to complete"
      }
    },
    {
      id = "mission_bastok_3_1",
      name = "The Four Musketeers (3-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 7,
      repeatable = false,
      steps = {
        "Talk to Bastok Gate Guard to receive mission",
        "Talk to Iron Eater twice in Metalworks (J-8)",
        "Zone into Beadeaux for cutscene",
        "Kill 20 Copper Quadav in Beadeaux",
        "Zone into Pashhow Marshlands to complete"
      }
    },
    {
      id = "mission_bastok_3_2",
      name = "To the Forsaken Mines (3-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 8,
      repeatable = false,
      steps = {
        "Talk to Bastok Gate Guard to receive mission",
        "(Optional) Talk to Davyad in Bastok Mines (K-6)",
        "Obtain Hare Meat (from rabbits or Auction House)",
        "Trade Hare Meat to ??? at Gusgen Mines (J-7)",
        "Defeat Blind Moby for Glocolite",
        "Trade Glocolite to Bastok Gate Guard"
      }
    },
    {
      id = "mission_bastok_3_3",
      name = "Jeuno (3-3)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 9,
      repeatable = false,
      steps = {
        "Talk to Bastok Gate Guard to receive mission",
        "Talk to Lucius in Metalworks (I-9) for Letter to Ambassador",
        "Talk to Goggehn in Ru'Lude Gardens (H-10)",
        "Obtain Delkfutt Key from Porphyrion (10th floor)",
        "Use key at basement Cermet Door (L-9) for cutscene",
        "Return to Bastokan Embassy in Ru'Lude Gardens"
      }
    },
    {
      id = "mission_bastok_4_1",
      name = "Magicite (4-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 10,
      repeatable = false,
      steps = {
        "Talk to Aldo (J-8) in Lower Jeuno at Neptune's Spire to get Silver Bell",
        "Obtain key items: Crest of Davoi, Yagudo Torch, Coruscant Rosary, Black Matinee Necklace",
        "Davoi: Disable Wall of Dark Arts (G-7), check Magicite for Optistone",
        "Beadeaux: Enter Qulun Dome (I-7), check Magicite for Aurastone",
        "Castle Oztroja: Light Yagudo Torch (H-9/H-10), enter Altar Room, check Magicite for Orastone",
        "Return to Audience Chamber in Ru'Lude Gardens for Airship Pass",
        "Complete mission at embassy receptionist for Rank 5"
      }
    },
    {
      id = "mission_bastok_5_1",
      name = "Darkness Rising (5-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 11,
      repeatable = false,
      steps = {
        "Talk to Naji (J-8) in Metalworks to accept mission and get New Fei'Yin Seal",
        "Zone into Fei'Yin from Beaucedine Glacier for cutscene",
        "Enter Qu'Bia Arena (K-8) in Fei'Yin",
        "Examine Burning Circle to enter BCNM 'The Rank 5 Mission'",
        "Defeat Archlich Taber'quoan (can Silence him) to get Burnt Seal",
        "Return to Naji in Metalworks to complete mission"
      }
    },
    {
      id = "mission_bastok_5_2",
      name = "Xarcabard Land of Truths (5-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 12,
      repeatable = false,
      steps = {
        "Accept mission from gate guard, talk to President Karst (K-8) in Metalworks",
        "Travel to Xarcabard (from Beaucedine Glacier F-6)",
        "Enter Castle Zvahl Baileys (D-7/D-8), navigate to Castle Zvahl Keep",
        "Navigate Map 3 teleport daises to reach Throne Room (G-7 on Map 4)",
        "Enter battlefield and defeat Shadow Lord to receive Shadow Fragment",
        "Return to President Karst to complete mission for Rank 6"
      }
    },
    {
      id = "mission_bastok_6_1",
      name = "Return of the Talekeeper (6-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 13,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission",
        "Talk to Medicine Eagle (H-5) in Bastok Mines",
        "Talk to Drake Fang (H-6) in Zeruhn Mines near boat for approval from Iron Eater",
        "Go to Western Altepa Desert, examine ??? (G-8) to spawn Western and Eastern Sphinx",
        "Defeat at least one Sphinx, check ??? again for Altepa Moonpebble",
        "Talk to Tall Mountain (J-7) in Bastok Mines to complete mission"
      }
    },
    {
      id = "mission_bastok_6_2",
      name = "The Pirate's Cove (6-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 14,
      repeatable = false,
      steps = {
        "Talk to Naji in Metalworks for cutscene",
        "Talk to Gilgamesh in Norg (through Oaken Door at K-8) for briefing",
        "Travel to Ifrit's Cauldron (I-5 entrance from Yhoator Jungle)",
        "At lava puddle (H-7), trade Adaman Ore to ??? to spawn Magma and Salamander",
        "Defeat Magma to obtain Frag Rock (up to 6 drop)",
        "Trade Frag Rock to Gilgamesh in Norg for cutscene",
        "Return to Naji in Metalworks to complete mission for Rank 7"
      }
    },
    {
      id = "mission_bastok_7_1",
      name = "The Final Image (7-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 15,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission, talk to Cid in Metalworks",
        "Travel to Ro'Maeve (bring Silent Oils for sound aggro)",
        "Find and target ??? at one of multiple spawn points (D-10, E-9, E-10, etc.)",
        "Clear area, check ??? to spawn 2 NM Golems (Mokkurkalfi)",
        "Defeat at least one Golem (immune to Sleep)",
        "Track down moved ??? to receive Reinforced Cermet (don't leave zone first!)",
        "Return to Cid in Metalworks for cutscene"
      }
    },
    {
      id = "mission_bastok_7_2",
      name = "On My Way (7-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 16,
      repeatable = false,
      steps = {
        "Talk to President Karst in Metalworks for briefing",
        "Talk to Hilda (E-6) at Steaming Sheep restaurant in Port Bastok",
        "Travel to Waughroon Shrine through Palborough Mines",
        "Enter BCNM 'On My Way' (6-person uncapped)",
        "Defeat Quadav: Go'Bha Slaughterer (DRK), Ku'Jhu Graniteskin (WAR), Da'Shu Knightslayer (RDM), Sa'Nha Soulsaver (WHM)",
        "Receive Letter From Werei after victory",
        "Talk to Gumbah (J-7) in Bastok Mines and President Karst for Rank 8"
      }
    },
    {
      id = "mission_bastok_8_1",
      name = "The Chains That Bind Us (8-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 17,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission, talk to Iron Eater (J-8) in Metalworks",
        "Travel to Western Altepa Desert (G-5) and enter Quicksand Caves",
        "Pass Weight Detection doors (H-8, H-10) to reach Galka Statue ??? (G-11)",
        "Clear room, check ??? to spawn Triarius IV-XIV (BLM), Princeps IV-XLV (PLD), Centurio IV-VII (WAR)",
        "Defeat NMs (can Sleep them), touch ??? for cutscene",
        "Travel to D-12 entrance, navigate weighted doors to mural room",
        "Check ??? at mural for cutscene with Zeid",
        "Return to Iron Eater in Metalworks for cutscene"
      }
    },
    {
      id = "mission_bastok_8_2",
      name = "Enter the Talekeeper (8-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 18,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission",
        "Talk to Drake Fang (H-6) in Zeruhn Mines for cutscene",
        "Travel to Kuftal Tunnel (H-4 from Western Altepa Desert)",
        "Examine ??? (H-8) on cliff top near entrance - piece of wood falls",
        "Clear lower area, check ??? (H-7) at bottom to spawn Dervo's/Gizerl's/Gordov's Ghost",
        "Defeat NM ghosts (wait ~1 min), check ??? for cutscene and Old Piece of Wood",
        "Return to Drake Fang in Zeruhn Mines to complete mission for Rank 9"
      }
    },
    {
      id = "mission_bastok_9_1",
      name = "The Salt of the Earth (9-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 19,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission",
        "Talk to Iron Eater in Metalworks for briefing",
        "Complete mission objectives",
        "Return to Iron Eater to complete"
      }
    },
    {
      id = "mission_bastok_9_2",
      name = "Where Two Paths Converge (9-2)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 20,
      repeatable = false,
      steps = {
        "Talk to gate guard to receive mission, talk to Iron Eater for cutscene",
        "Travel to Throne Room in Castle Zvahl Keep (Home Point available)",
        "Enter BCNM 'Where Two Paths Converge' (6-person uncapped)",
        "Fight Zeid (uses Great Sword WS, Absorb spells, Abyssal Strike/Drain)",
        "At 70% HP Volker joins (keep him alive!), Shadow of Rage spawns later",
        "Defeat Zeid, watch cutscene",
        "Return to Iron Eater in President's Office to complete mission for Rank 10"
      }
    },
    {
      id = "mission_rhapsodies_1_1",
      name = "Rhapsodies of Vanadiel Mission 1-1",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 1,
      game_id = 110,
      repeatable = false,
      steps = {
        "Zone into any starter city (Level 3+) for cutscene",
        "Or check Tales' Beginning in any starter city zone",
        "Unlocks Escha - Zi'Tah and Escha - Ru'Aun"
      }
    },
    {
      id = "mission_rhapsodies_1_2",
      name = "Rhapsodies of Vanadiel Mission 1-2",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 2,
      game_id = 111,
      repeatable = false,
      steps = {
        "Zone into Selbina or Mhaura for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_1_3",
      name = "Rhapsodies of Vanadiel Mission 1-3",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 3,
      game_id = 112,
      repeatable = false,
      steps = {
        "Selbina: Talk to Naillina (F-9) in Mayor's Residence",
        "Mhaura: Talk to Numi Adaligo (F-9) in Governor's House"
      }
    },
    {
      id = "mission_rhapsodies_1_4",
      name = "Rhapsodies of Vanadiel Mission 1-4",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 4,
      game_id = 114,
      repeatable = false,
      steps = {
        "Selbina: Get 3 Bee Pollen from Huge Wasps (La Theine/Konschtat), trade to Abelard",
        "Mhaura: Get 3 Mandragora Dewdrops from Pygmaioi (Tahrongi), trade to Ekokoko"
      }
    },
    {
      id = "mission_rhapsodies_1_5",
      name = "Rhapsodies of Vanadiel Mission 1-5",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 5,
      game_id = 118,
      repeatable = false,
      steps = {
        "Selbina: Talk to Pacomart (H-10) to go to Norg",
        "Mhaura: Talk to Tonasav (H-9) to go to Norg",
        "Examine Oaken Door (K-8) in Norg"
      }
    },
    {
      id = "mission_rhapsodies_1_6",
      name = "Rhapsodies of Vanadiel Mission 1-6",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 6,
      game_id = 120,
      repeatable = false,
      steps = {
        "Examine Oaken Door (K-8) in Norg again"
      }
    },
    {
      id = "mission_rhapsodies_1_7",
      name = "Rhapsodies of Vanadiel Mission 1-7",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 7,
      game_id = 124,
      repeatable = false,
      steps = {
        "Examine Shattered Telepoint at any Crag (Nation Rank 3+)",
        "Select Qufim Island option"
      }
    },
    {
      id = "mission_rhapsodies_1_8",
      name = "Rhapsodies of Vanadiel Mission 1-8",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 8,
      game_id = 126,
      repeatable = false,
      steps = {
        "Examine Undulating Confluence (G-8) in Qufim Island"
      }
    },
    {
      id = "mission_rhapsodies_1_9",
      name = "Rhapsodies of Vanadiel Mission 1-9",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 9,
      game_id = 128,
      repeatable = false,
      steps = {
        "Battle Ophiotaurus at Undulating Confluence (Level 40-50 recommended)",
        "Examine Undulating Confluence again after victory"
      }
    },
    {
      id = "mission_rhapsodies_1_10",
      name = "Rhapsodies of Vanadiel Mission 1-10",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 10,
      game_id = 130,
      repeatable = false,
      steps = {
        "Examine Undulating Confluence to teleport to Escha - Zi'Tah"
      }
    },
    {
      id = "mission_rhapsodies_1_11",
      name = "Rhapsodies of Vanadiel Mission 1-11",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 11,
      game_id = 134,
      repeatable = false,
      steps = {
        "Return to Shattered Telepoint at any Crag"
      }
    },
    {
      id = "mission_rhapsodies_1_12",
      name = "Rhapsodies of Vanadiel Mission 1-12",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 12,
      game_id = 136,
      repeatable = false,
      steps = {
        "Zone into any starter city for cutscene (need nation rank 5-2 complete)"
      }
    },
    {
      id = "mission_rhapsodies_1_13",
      name = "Rhapsodies of Vanadiel Mission 1-13",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 13,
      game_id = 138,
      repeatable = false,
      steps = {
        "Zone into Norg for cutscene",
        "Examine Gilgamesh's Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_1_14",
      name = "Rhapsodies of Vanadiel Mission 1-14",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 14,
      game_id = 140,
      repeatable = false,
      steps = {
        "Examine sparkling ??? (J-12) in Sea Serpent Grotto"
      }
    },
    {
      id = "mission_rhapsodies_1_15",
      name = "Rhapsodies of Vanadiel Mission 1-15",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 15,
      game_id = 142,
      repeatable = false,
      steps = {
        "Examine sparkling ??? (F-11) in Yuhtunga Jungle"
      }
    },
    {
      id = "mission_rhapsodies_1_16",
      name = "Rhapsodies of Vanadiel Mission 1-16",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 16,
      game_id = 144,
      repeatable = false,
      steps = {
        "Battle Siren at ??? (Level 80+ recommended)",
        "Examine ??? after victory for Rhapsody in Azure"
      }
    },
    {
      id = "mission_rhapsodies_1_17",
      name = "Rhapsodies of Vanadiel Mission 1-17",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 17,
      game_id = 148,
      repeatable = false,
      steps = {
        "Examine Gilgamesh's Oaken Door in Norg for Cipher: Zeid II"
      }
    },
    {
      id = "mission_rhapsodies_1_18",
      name = "Rhapsodies of Vanadiel Mission 1-18",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 18,
      game_id = 150,
      repeatable = false,
      steps = {
        "Examine Gilgamesh's door in Norg multiple times",
        "Enter and talk to Gilgamesh for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_1",
      name = "Rhapsodies of Vanadiel Mission 2-1",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 19,
      game_id = 152,
      repeatable = false,
      steps = {
        "Zone into Lower Delkfutt's Tower from Qufim for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_2",
      name = "Rhapsodies of Vanadiel Mission 2-2",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 20,
      game_id = 154,
      repeatable = false,
      steps = {
        "Go to Ru'Lude Gardens (H-7) for cutscene (need Promathia 3-2)",
        "Obtain Cipher: Tenzen II (check Mystic Retriever if missed)"
      }
    },
    {
      id = "mission_rhapsodies_2_3",
      name = "Rhapsodies of Vanadiel Mission 2-3",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 21,
      game_id = 156,
      repeatable = false,
      steps = {
        "Zone into Port Jeuno for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_4",
      name = "Rhapsodies of Vanadiel Mission 2-4",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 22,
      game_id = 158,
      repeatable = false,
      steps = {
        "Examine Door: Marble Bridge (F-7) in Upper Jeuno"
      }
    },
    {
      id = "mission_rhapsodies_2_5",
      name = "Rhapsodies of Vanadiel Mission 2-5",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 23,
      game_id = 160,
      repeatable = false,
      steps = {
        "Zone into Aht Urhgan Whitegate for cutscene",
        "Or talk to Faursel (J-8) in Lower Jeuno Tenshodo for access"
      }
    },
    {
      id = "mission_rhapsodies_2_6",
      name = "Rhapsodies of Vanadiel Mission 2-6",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 24,
      game_id = 162,
      repeatable = false,
      steps = {
        "Obtain boarding permit from Tenshodo"
      }
    },
    {
      id = "mission_rhapsodies_2_7",
      name = "Rhapsodies of Vanadiel Mission 2-7",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 25,
      game_id = 164,
      repeatable = false,
      steps = {
        "Return to your home nation for a cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_8",
      name = "Rhapsodies of Vanadiel Mission 2-8",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 26,
      game_id = 168,
      repeatable = false,
      steps = {
        "Complete Mission 12 - Royal Puppeteer' in the Aht Urhgan to progress"
      }
    },
    {
      id = "mission_rhapsodies_2_9",
      name = "Rhapsodies of Vanadiel Mission 2-9",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 27,
      game_id = 170,
      repeatable = false,
      steps = {
        "Examine Imperial Whitegate (L-8/9) when Aphmau is in town"
      }
    },
    {
      id = "mission_rhapsodies_2_10",
      name = "Rhapsodies of Vanadiel Mission 2-10",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 28,
      game_id = 172,
      repeatable = false,
      steps = {
        "Enter Walahra Temple and talk to Nadeey"
      }
    },
    {
      id = "mission_rhapsodies_2_11",
      name = "Rhapsodies of Vanadiel Mission 2-11",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 29,
      game_id = 174,
      repeatable = false,
      steps = {
        "Go to Shararat Teahouse (K-12) for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_12",
      name = "Rhapsodies of Vanadiel Mission 2-12",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 30,
      game_id = 176,
      repeatable = false,
      steps = {
        "Zone into Alzadaal Undersea Ruins",
        "Go to Nyzul Isle Staging Point (200 Imperial Standing)"
      }
    },
    {
      id = "mission_rhapsodies_2_13",
      name = "Rhapsodies of Vanadiel Mission 2-13",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 31,
      game_id = 178,
      repeatable = false,
      steps = {
        "Click Imperial Whitegate in Aht Urhgan for Rhapsody in Crimson",
        "With all Aht Urhgan complete: Re-enter Alzadaal Ruins",
        "With Promathia 3-5 complete: Zone into The Shrouded Maw",
        "With all Promathia complete: Enter The Garden of Ru'Hmet"
      }
    },
    {
      id = "mission_rhapsodies_2_14",
      name = "Rhapsodies of Vanadiel Mission 2-14",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 32,
      game_id = 180,
      repeatable = false,
      steps = {
        "Examine ??? at Cavernous Maw (Batallia/Rolanberry/Sauromugue)",
        "May need WotG Mission 8+ and quests Champion/Forbidden Reunion"
      }
    },
    {
      id = "mission_rhapsodies_2_15",
      name = "Rhapsodies of Vanadiel Mission 2-15",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 33,
      game_id = 186,
      repeatable = false,
      steps = {
        "Examine blue ??? next to Cavernous Maw"
      }
    },
    {
      id = "mission_rhapsodies_2_16",
      name = "Rhapsodies of Vanadiel Mission 2-16",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 34,
      game_id = 188,
      repeatable = false,
      steps = {
        "If Wings of Goddess not completed: Zone into Southern San d'Oria (S) for a cutscene.",
        "If Wings of Goddess Completed: Examine the ??? next to one of the Cavernous Maws in Batallia Downs, Rolanberry Fields or Sauromugue Champaign for a cutscene."
      }
    },
    {
      id = "mission_rhapsodies_2_17",
      name = "Rhapsodies of Vanadiel Mission 2-17",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 35,
      game_id = 192,
      repeatable = false,
      steps = {
        "With WotG 45 complete: Enter Walk of Echoes from Pashhow/Grauberg (S)",
        "Or use Lightsworm at ??? near Cavernous Maw outside Jeuno",
        "Examine Ornate Door in Walk of Echoes"
      }
    },
    {
      id = "mission_rhapsodies_2_18",
      name = "Rhapsodies of Vanadiel Mission 2-18",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 36,
      game_id = 194,
      repeatable = false,
      steps = {
        "Arrive at Grauberg (S) Witchfire Glen",
        "Examine blue ??? NE of Veridical Conflux to spawn Cetus",
        "Defeat Cetus and re-examine ???",
        "Re-enter Walk of Echoes via ??? for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_19",
      name = "Rhapsodies of Vanadiel Mission 2-19",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 37,
      game_id = 200,
      repeatable = false,
      steps = {
        "Examine Gilgamesh's Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_2_20",
      name = "Rhapsodies of Vanadiel Mission 2-20",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 38,
      game_id = 202,
      repeatable = false,
      steps = {
        "Examine ??? (G-5) next to Undulating Confluence in Misareaux Coast"
      }
    },
    {
      id = "mission_rhapsodies_2_21",
      name = "Rhapsodies of Vanadiel Mission 2-21",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 39,
      game_id = 204,
      repeatable = false,
      steps = {
        "Examine ??? at Undulating Confluence again"
      }
    },
    {
      id = "mission_rhapsodies_2_22",
      name = "Rhapsodies of Vanadiel Mission 2-22",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 40,
      game_id = 206,
      repeatable = false,
      steps = {
        "Trade food to ??? in Misareaux Coast (15,000 Gil)",
        "Strength: Beef Stewpot, Style: 30x Spicy Crackers, Endurance: Zaru Soba"
      }
    },
    {
      id = "mission_rhapsodies_2_23",
      name = "Rhapsodies of Vanadiel Mission 2-23",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 41,
      game_id = 208,
      repeatable = false,
      steps = {
        "Return to Oaken Door in Norg for cutscene",
        "If on Zilart 3: Talk to Jakoh Wahcondalo in Kazham (J-9) first"
      }
    },
    {
      id = "mission_rhapsodies_2_24",
      name = "Rhapsodies of Vanadiel Mission 2-24",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 42,
      game_id = 210,
      repeatable = false,
      steps = {
        "Enter Temple of Uggalepih (need Zilart 4 complete)",
        "Navigate to Granite Door (J-6) on Map 3"
      }
    },
    {
      id = "mission_rhapsodies_2_25",
      name = "Rhapsodies of Vanadiel Mission 2-25",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 43,
      game_id = 211,
      repeatable = false,
      steps = {
        "Examine Granite Door for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_26",
      name = "Rhapsodies of Vanadiel Mission 2-26",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 44,
      game_id = 212,
      repeatable = false,
      steps = {
        "Enter Hall of Transference via Shattered Telepoint at any Crag"
      }
    },
    {
      id = "mission_rhapsodies_2_27",
      name = "Rhapsodies of Vanadiel Mission 2-27",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 45,
      game_id = 214,
      repeatable = false,
      steps = {
        "Cutscene in Hall of Transference"
      }
    },
    {
      id = "mission_rhapsodies_2_28",
      name = "Rhapsodies of Vanadiel Mission 2-28",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 46,
      game_id = 216,
      repeatable = false,
      steps = {
        "Return to Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_2_29",
      name = "Rhapsodies of Vanadiel Mission 2-29",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 47,
      game_id = 218,
      repeatable = false,
      steps = {
        "Click Undulating Confluence (G-5) in Misareaux Coast",
        "Enter Escha - Ru'Aun via Undulating Confluence"
      }
    },
    {
      id = "mission_rhapsodies_2_30",
      name = "Rhapsodies of Vanadiel Mission 2-30",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 48,
      game_id = 222,
      repeatable = false,
      steps = {
        "Examine blue ??? (H-10) at top of stairs for Siren's plume"
      }
    },
    {
      id = "mission_rhapsodies_2_31",
      name = "Rhapsodies of Vanadiel Mission 2-31",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 49,
      game_id = 224,
      repeatable = false,
      steps = {
        "Examine Shattered Telepoint at any Crag"
      }
    },
    {
      id = "mission_rhapsodies_2_32",
      name = "Rhapsodies of Vanadiel Mission 2-32",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 50,
      game_id = 226,
      repeatable = false,
      steps = {
        "Examine Gilgamesh's Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_2_33",
      name = "Rhapsodies of Vanadiel Mission 2-33",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 51,
      game_id = 228,
      repeatable = false,
      steps = {
        "Talk to Shantotto at Manor (K-7) in Windurst Walls"
      }
    },
    {
      id = "mission_rhapsodies_2_34",
      name = "Rhapsodies of Vanadiel Mission 2-34",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 52,
      game_id = 230,
      repeatable = false,
      steps = {
        "Enter Escha - Ru'Aun via Undulating Confluence"
      }
    },
    {
      id = "mission_rhapsodies_2_35",
      name = "Rhapsodies of Vanadiel Mission 2-35",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 53,
      game_id = 232,
      repeatable = false,
      steps = {
        "Collect Eschan Droplets at each Portal (1-14) to unlock teleports",
        "Examine ??? at Portal #15 for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_2_36",
      name = "Rhapsodies of Vanadiel Mission 2-36",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 54,
      game_id = 234,
      repeatable = false,
      steps = {
        "Battle Balamor at Portal #15 ???",
        "Check ??? again after victory",
        "Get Eschan Droplets near portal to return to start"
      }
    },
    {
      id = "mission_rhapsodies_2_37",
      name = "Rhapsodies of Vanadiel Mission 2-37",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 55,
      game_id = 238,
      repeatable = false,
      steps = {
        "Return to Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_2_38",
      name = "Rhapsodies of Vanadiel Mission 2-38",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 56,
      game_id = 240,
      repeatable = false,
      steps = {
        "Click Dimensional Portal at any Crag",
        "Obtain Cipher: Selh'teus (check Mystic Retriever if missed)"
      }
    },
    {
      id = "mission_rhapsodies_2_39",
      name = "Rhapsodies of Vanadiel Mission 2-39",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 57,
      game_id = 244,
      repeatable = false,
      steps = {
        "Examine Transcendental Radiance in Empyreal Paradox",
        "Battle Disjoined One (15 min limit, easily soloable)"
      }
    },
    {
      id = "mission_rhapsodies_2_40",
      name = "Rhapsodies of Vanadiel Mission 2-40",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 58,
      game_id = 250,
      repeatable = false,
      steps = {
        "Examine Oaken Door in Norg"
      }
    },
    {
      id = "mission_rhapsodies_2_41",
      name = "Rhapsodies of Vanadiel Mission 2-41",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 59,
      game_id = 252,
      repeatable = false,
      steps = {
        "Zone into starter city with Mog House for Song of hope"
      }
    },
    {
      id = "mission_rhapsodies_3_1",
      name = "Rhapsodies of Vanadiel Mission 3-1",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 60,
      game_id = 254,
      repeatable = false,
      steps = {
        "Examine Dimensional Portal at any Crag to travel to Reisenjima",
        "Talk to Shiftrix for Oseem augmentation access",
        "Go to Etched Rock (K-9) for cutscene",
        "Unlock Ethereal Ingress teleports along the way"
      }
    },
    {
      id = "mission_rhapsodies_3_2",
      name = "Rhapsodies of Vanadiel Mission 3-2",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 61,
      game_id = 258,
      repeatable = false,
      steps = {
        "Defeat 3 Perfervid Narakas near #6 (20:00-4:00, bring Mollifier)"
      }
    },
    {
      id = "mission_rhapsodies_3_3",
      name = "Rhapsodies of Vanadiel Mission 3-3",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 62,
      game_id = 260,
      repeatable = false,
      steps = {
        "Examine Etched Rock (K-9) in Reisenjima"
      }
    },
    {
      id = "mission_rhapsodies_3_4",
      name = "Rhapsodies of Vanadiel Mission 3-4",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 63,
      game_id = 262,
      repeatable = false,
      steps = {
        "Enter Ceizak Battlegrounds (via Waypoint/Home Point)"
      }
    },
    {
      id = "mission_rhapsodies_3_5",
      name = "Rhapsodies of Vanadiel Mission 3-5",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 64,
      game_id = 263,
      repeatable = false,
      steps = {
        "Zone into Ceizak Battlegrounds for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_6",
      name = "Rhapsodies of Vanadiel Mission 3-6",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 65,
      game_id = 264,
      repeatable = false,
      steps = {
        "Talk to Ploh Trishbahk at Castle gates (need SoA 2-2 complete)"
      }
    },
    {
      id = "mission_rhapsodies_3_7",
      name = "Rhapsodies of Vanadiel Mission 3-7",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 66,
      game_id = 266,
      repeatable = false,
      steps = {
        "Go to Augural Conveyor (B-6) in Rala Waterways",
        "Examine ??? for cutscene (or use enigmatic device Waypoint)",
        "Receive Cipher: Arciela II"
      }
    },
    {
      id = "mission_rhapsodies_3_8",
      name = "Rhapsodies of Vanadiel Mission 3-8",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 67,
      game_id = 268,
      repeatable = false,
      steps = {
        "Examine Sluice Gate (C-6) in Rala Waterways (need SoA 2-7-1)",
        "Examine Inconspicuous Barrel for Founder king's orb"
      }
    },
    {
      id = "mission_rhapsodies_3_9",
      name = "Rhapsodies of Vanadiel Mission 3-9",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 68,
      game_id = 269,
      repeatable = false,
      steps = {
        "Return to ??? near Augural Conveyor (B-6) in Rala Waterways"
      }
    },
    {
      id = "mission_rhapsodies_3_10",
      name = "Rhapsodies of Vanadiel Mission 3-10",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 69,
      game_id = 270,
      repeatable = false,
      steps = {
        "Zone into Celennia Memorial Library in Eastern Adoulin"
      }
    },
    {
      id = "mission_rhapsodies_3_11",
      name = "Rhapsodies of Vanadiel Mission 3-11",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 70,
      game_id = 272,
      repeatable = false,
      steps = {
        "Zone into Hall of the Gods for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_12",
      name = "Rhapsodies of Vanadiel Mission 3-12",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 71,
      game_id = 274,
      repeatable = false,
      steps = {
        "Examine Cermet Grate in Hall of the Gods"
      }
    },
    {
      id = "mission_rhapsodies_3_13",
      name = "Rhapsodies of Vanadiel Mission 3-13",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 72,
      game_id = 278,
      repeatable = false,
      steps = {
        "Return to Reisenjima Sanctorium for Dimensional Compass"
      }
    },
    {
      id = "mission_rhapsodies_3_14",
      name = "Rhapsodies of Vanadiel Mission 3-14",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 73,
      game_id = 280,
      repeatable = false,
      steps = {
        "Enter Walk of Echoes (not from Batallia Downs)",
        "May need to complete Champion of Dawn / Forbidden Reunion quests"
      }
    },
    {
      id = "mission_rhapsodies_3_15",
      name = "Rhapsodies of Vanadiel Mission 3-15",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 74,
      game_id = 282,
      repeatable = false,
      steps = {
        "Examine white ??? in Walk of Echoes (toward Atomos)",
        "Teleported to Desuetia for Cait Sith's whisker"
      }
    },
    {
      id = "mission_rhapsodies_3_16",
      name = "Rhapsodies of Vanadiel Mission 3-16",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 75,
      game_id = 286,
      repeatable = false,
      steps = {
        "Examine Transcendental Radiance for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_17",
      name = "Rhapsodies of Vanadiel Mission 3-17",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 76,
      game_id = 288,
      repeatable = false,
      steps = {
        "Battle in No Time Like the Future BCNM",
        "Get new whisker from Cait Sith if you lose"
      }
    },
    {
      id = "mission_rhapsodies_3_18",
      name = "Rhapsodies of Vanadiel Mission 3-18",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 77,
      game_id = 292,
      repeatable = false,
      steps = {
        "Examine Transcendental Radiance after battle for long cutscene",
        "Replay at Goblin Footprints in Reisenjima (Penance)"
      }
    },
    {
      id = "mission_rhapsodies_3_19",
      name = "Rhapsodies of Vanadiel Mission 3-19",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 78,
      game_id = 296,
      repeatable = false,
      steps = {
        "Complete previous cutscene for Rhapsody in Puce"
      }
    },
    {
      id = "mission_rhapsodies_3_20",
      name = "Rhapsodies of Vanadiel Mission 3-20",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 79,
      game_id = 298,
      repeatable = false,
      steps = {
        "Return to Reisenjima Sanctorium for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_21",
      name = "Rhapsodies of Vanadiel Mission 3-21",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 80,
      game_id = 300,
      repeatable = false,
      steps = {
        "Examine ??? (H-5) on hill near ruins in Reisenjima",
        "Warp to Ethereal Ingress #5 and go west"
      }
    },
    {
      id = "mission_rhapsodies_3_22",
      name = "Rhapsodies of Vanadiel Mission 3-22",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 81,
      game_id = 302,
      repeatable = false,
      steps = {
        "Defeat 11 Obstreperous Panopts (F-11, bring Mollifier)",
        "Rhapsody in Fuschia reduces level to 112"
      }
    },
    {
      id = "mission_rhapsodies_3_23",
      name = "Rhapsodies of Vanadiel Mission 3-23",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 82,
      game_id = 304,
      repeatable = false,
      steps = {
        "Examine Etched Rock (K-9) in Reisenjima near Ethereal Ingress #6"
      }
    },
    {
      id = "mission_rhapsodies_3_24",
      name = "Rhapsodies of Vanadiel Mission 3-24",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 83,
      game_id = 306,
      repeatable = false,
      steps = {
        "Examine Reisen Crystal in Reisenjima Sanctorium"
      }
    },
    {
      id = "mission_rhapsodies_3_25",
      name = "Rhapsodies of Vanadiel Mission 3-25",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 84,
      game_id = 308,
      repeatable = false,
      steps = {
        "Watch cutscene from previous mission",
        "Transported to Empyreal Paradox during cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_26",
      name = "Rhapsodies of Vanadiel Mission 3-26",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 85,
      game_id = 310,
      repeatable = false,
      steps = {
        "Enter The Winds of Time at Transcendental Radiance in Empyreal Paradox",
        "Defeat Metus (can use Trusts)",
        "Cutscene after battle starts next mission"
      }
    },
    {
      id = "mission_rhapsodies_3_27",
      name = "Rhapsodies of Vanadiel Mission 3-27",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 86,
      game_id = 314,
      repeatable = false,
      steps = {
        "Watch cutscene after previous battle",
        "If Tenzen occupied, examine Resume Point in Empyreal Paradox"
      }
    },
    {
      id = "mission_rhapsodies_3_28",
      name = "Rhapsodies of Vanadiel Mission 3-28",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 87,
      game_id = 318,
      repeatable = false,
      steps = {
        "Continue watching cutscene for rewards and next mission"
      }
    },
    {
      id = "mission_rhapsodies_3_29",
      name = "Rhapsodies of Vanadiel Mission 3-29",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 88,
      game_id = 320,
      repeatable = false,
      steps = {
        "Get Cipher of Iroha from Mystic Retriever if inventory was full",
        "Zone into starting Nation (Bastok/Windurst/San d'Oria) with Mog House"
      }
    },
    {
      id = "mission_rhapsodies_3_30",
      name = "Rhapsodies of Vanadiel Mission 3-30",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 89,
      game_id = 324,
      repeatable = false,
      steps = {
        "Go to Reisenjima Sanctorium for cutscene",
        "Shortcut: Garden of Ru'Hmet → Empyreal Paradox → Dimensional Portal"
      }
    },
    {
      id = "mission_rhapsodies_3_31",
      name = "Rhapsodies of Vanadiel Mission 3-31",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 90,
      game_id = 326,
      repeatable = false,
      steps = {
        "Examine ??? at Stone Circle (G-6) in La Theine Plateau"
      }
    },
    {
      id = "mission_rhapsodies_3_32",
      name = "Rhapsodies of Vanadiel Mission 3-32",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 91,
      game_id = 328,
      repeatable = false,
      steps = {
        "Return to Reisenjima Sanctorium for cutscene",
        "Receive Rhapsody in Mauve (all Rise of the Zilart memories unlocked)"
      }
    },
    {
      id = "mission_rhapsodies_3_33",
      name = "Rhapsodies of Vanadiel Mission 3-33",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 92,
      game_id = 330,
      repeatable = false,
      steps = {
        "Touch Reisen Crystal for cutscene"
      }
    },
    {
      id = "mission_rhapsodies_3_34",
      name = "Rhapsodies of Vanadiel Mission 3-34",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 93,
      game_id = 332,
      repeatable = false,
      steps = {
        "Examine Reisen Crystal to battle Cloud of Darkness",
        "If fail, get new Breath of avatars at Stone Circle (G-6) La Theine"
      }
    },
    {
      id = "mission_rhapsodies_3_35",
      name = "Rhapsodies of Vanadiel Mission 3-35",
      type = "mission",
      location = "rhapsodies_of_vanadiel",
      nation = "rhapsodies_of_vanadiel",
      mission_index = 94,
      game_id = 334,
      repeatable = false,
      steps = {
        "Congratulations! You have completed Rhapsodies of Vanadiel!"
      }
    }
  }
}


