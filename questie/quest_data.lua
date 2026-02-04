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
    },
    {
      id = "mission_soa_1_1",
      name = "Seekers of Adoulin Mission 1-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 1,
      game_id = 110,
      repeatable = false,
      steps = {
        "Speak with Darcia at Lower Jeuno (H-7) Chamber of Commerce",
        "Select 'I would like to apply!' to receive Geomagnetron",
      }
    },
    {
      id = "mission_soa_1_2",
      name = "Seekers of Adoulin Mission 1-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 2,
      game_id = 112,
      repeatable = false,
      steps = {
        "Speak with Darcia at Lower Jeuno (H-7) Chamber of Commerce, select 'I would like to apply!'",
        "Travel to one location and attune Geomagnetron to the Geomagnetic Fount:",
        "Gustav Tunnel Map 1 (G-10) - pond near Cape Teriggan exit, close to Unity Warp 128",
        "Ranguemont Pass (J-10) - southeastern corner",
        "Yughott Grotto (J-7) - in the pond",
        "King Ranperre's Tomb (K-6) - nearest to Jugner Forest Proto-Waypoint",
        "Monastic Cavern (H-10) Map 1",
        "The Eldieme Necropolis (J-10) Map 2 - fall from first floor (F-8)",
        "Ordelle's Caves (F-12) - Hidden Apparatus Area",
        "Gusgen Mines (G-7) Map 3 - NW corner of last map",
        "Dangruf Wadi (E-11) - after falling in hole in hidden tunnel",
        "Korroloka Tunnel (G-9) Map 4 - Jammer Leech NM spot",
        "Palborough Mines (J-8) Map 2",
        "Labyrinth of Onzozo (J-5) - off map in northeast, access from south",
        "Maze of Shakhrami (K-9) Map 1",
        "Garlaige Citadel (G-8) Map 2 - behind banishing gate #1",
        "Crawlers' Nest (F-7) Map 1",
        "Outer Horutoto Ruins (G-7) Map 2 - enter from East Sarutabaruta (H-3)",
        "Inner Horutoto Ruins (G/H-7) Map 2 - enter from East Sarutabaruta (J-7)",
        "Toraimarai Canal (I-6) - towards Inner Horutoto Ruins",
        "Return to Darcia with attuned Geomagnetron to receive Adoulinian charter permit",
        "Alternative: Pay 1,000,000 Gil to skip this mission",
      }
    },
    {
      id = "mission_soa_1_3",
      name = "Seekers of Adoulin Mission 1-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 3,
      game_id = 116,
      repeatable = false,
      steps = {
        "Activate the Waypoint at Lower Jeuno (H-7)",
      }
    },
    {
      id = "mission_soa_1_4",
      name = "Seekers of Adoulin Mission 1-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 4,
      game_id = 120,
      repeatable = false,
      steps = {
        "Travel north/east through Ceizak Battlegrounds to Western Adoulin (K-7)",
      }
    },
    {
      id = "mission_soa_1_5",
      name = "Seekers of Adoulin Mission 1-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 5,
      game_id = 122,
      repeatable = false,
      steps = {
        "Speak with Brenton at Pioneers' Coalition, Western Adoulin (E-8)",
        "Talk to a Task Delegator NPC to begin accruing Imprimaturs",
        "Receive: Pioneer's Badge, Map of Adoulin, 1000 Bayld",
      }
    },
    {
      id = "mission_soa_1_6",
      name = "Seekers of Adoulin Mission 1-6",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 6,
      game_id = 124,
      repeatable = false,
      steps = {
        "Utilize 15 or more Imprimaturs on completed Coalition Assignments",
        "Talk to Brenton for cutscene and receive Dinner invitation",
        "Unlock ability to participate in Wildskeeper Reives",
        "Purchase Reive entry items from Dimmian in Eastern Adoulin (E-6)",
      }
    },
    {
      id = "mission_soa_1_7",
      name = "Seekers of Adoulin Mission 1-7",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 7,
      game_id = 126,
      repeatable = false,
      steps = {
        "Talk to Ploh Trishbahk at Gates of Castle Adoulin, Eastern Adoulin (K-9)",
        "Time: Between 15:00-22:00 game time",
        "Optional: Begin quest 'Flavors of Our Lives' and meet Teodor to avoid delays",
      }
    },
    {
      id = "mission_soa_1_8",
      name = "Seekers of Adoulin Mission 1-8",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 8,
      game_id = 128,
      repeatable = false,
      steps = {
        "Use Imprimaturs on Coalition Assignments (15+ with Fame 2 is sufficient)",
        "Speak to Levil at Pioneers' Coalition to complete mission",
        "Quick method: Trade Bloodthread (x3) for Gather Materials task at Inventors' Coalition",
        "Or do delivery assignments from Couriers' Coalition using waypoints",
      }
    },
    {
      id = "mission_soa_2_1",
      name = "Seekers of Adoulin Mission 2-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 9,
      game_id = 132,
      repeatable = false,
      steps = {
        "Talk to Levil at Pioneers' Coalition",
        "If not started 'Flavors of Our Lives': Talk to Berghent at (J-9) near Big Bridge",
        "Go to Mummers' Coalition and talk to Masad",
        "Wait until next in-game day and zone to receive cutscene from Masad",
      }
    },
    {
      id = "mission_soa_2_1_1",
      name = "Seekers of Adoulin Mission 2-1-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 10,
      game_id = 134,
      repeatable = false,
      steps = {
        "Talk to Levil at Pioneers' Coalition",
      }
    },
    {
      id = "mission_soa_2_1_2",
      name = "Seekers of Adoulin Mission 2-1-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 11,
      game_id = 136,
      repeatable = false,
      steps = {
        "Purchase Sickles from Tevigogo at Western Adoulin (D-9) near Entrance Gate",
        "Approach Eastern Adoulin Castle Gate for cutscene",
      }
    },
    {
      id = "mission_soa_2_2",
      name = "Seekers of Adoulin Mission 2-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 12,
      game_id = 138,
      repeatable = false,
      steps = {
        "Travel to Cirdas Caverns and approach Ergon Locus at (E-9)",
        "Clear Colonization Reive requiring 'Logging' to access",
        "Route options:",
        "- Ceizak Battlegrounds WP #3 -> Sih Gates -> Cirdas Caverns southeast",
        "- Foret de Hennetiel WP #3 -> clear reive north -> Dho Gates -> Cirdas Caverns southwest",
        "- Yorcia Frontier Station -> entrance -> clear reives as needed",
        "- Use Augural Conveyor from previous visit: waypoint teleport to (J-3) for 300 Units",
      }
    },
    {
      id = "mission_soa_2_2_1",
      name = "Seekers of Adoulin Mission 2-2-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 13,
      game_id = 140,
      repeatable = false,
      steps = {
        "Zone into Yorcia Weald for cutscene (waypoint or Home Point works)",
        "Note: Learn Watercrafting and Climbing survival skills to reach from Cirdas Caverns",
      }
    },
    {
      id = "mission_soa_2_2_2",
      name = "Seekers of Adoulin Mission 2-2-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 14,
      game_id = 142,
      repeatable = false,
      steps = {
        "Obtain Yorcia's tear via one of two methods:",
        "Option 1: Click Ergon Locus ??? at southern (I-8) in Yorcia Weald",
        "  - Enter (I-8) from the west; path may be blocked by wall that opens at 21:00",
        "Option 2: Harvest using Sickle on Harvesting Point (bring extras, may break)",
        "  - Harvesting Points are scarce and respawn elsewhere after time",
        "Go to (G-6) and click Pellucid Afflusion next to pond for cutscene",
        "  - Bush at corner (G-5/6)-(H-5/6) moves up/down blocking path every 5-10 minutes",
        "Receive Rosulatia's pome",
      }
    },
    {
      id = "mission_soa_2_3",
      name = "Seekers of Adoulin Mission 2-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 15,
      game_id = 144,
      repeatable = false,
      steps = {
        "Wait until next game day after previous mission",
        "Approach Oscairn at Eastern Adoulin (G-7), northeast of Peacekeepers' Coalition",
      }
    },
    {
      id = "mission_soa_2_4",
      name = "Seekers of Adoulin Mission 2-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 16,
      game_id = 146,
      repeatable = false,
      steps = {
        "Zone into Rala Waterways from Eastern Adoulin (F-7) for cutscene with Arciela",
      }
    },
    {
      id = "mission_soa_2_4_1",
      name = "Seekers of Adoulin Mission 2-4-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 17,
      game_id = 148,
      repeatable = false,
      steps = {
        "Head to center room at Rala Waterways (M-6)",
        "Speak to Yeggha Dolashi for cutscene",
        "Closest entrance: (F-7) from Eastern Adoulin",
      }
    },
    {
      id = "mission_soa_2_5",
      name = "Seekers of Adoulin Mission 2-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 18,
      game_id = 150,
      repeatable = false,
      steps = {
        "Wait until next game day after completing The Watergarden Coliseum",
        "Speak to Levil at Pioneers' Coalition (E-8), Western Adoulin",
      }
    },
    {
      id = "mission_soa_2_5_1",
      name = "Seekers of Adoulin Mission 2-5-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 19,
      game_id = 152,
      repeatable = false,
      steps = {
        "Go to Celennia Memorial Library at Eastern Adoulin (F-10)",
        "Talk to Eppel-Treppel to enter building",
        "Read all three options in 'History' book on bookshelf (between Yefafa and Vainrachault)",
        "If unable to read books: Complete quest 'Order Up' from Reja Ygridhi inside library",
        "  - Purchase Celennia Memorial Library card from Patient Snake (Eastern Adoulin F-9) for 1000 Bayld",
        "Return to Levil at Pioneers' Coalition, Western Adoulin",
      }
    },
    {
      id = "mission_soa_2_5_2",
      name = "Seekers of Adoulin Mission 2-5-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 20,
      game_id = 156,
      repeatable = false,
      steps = {
        "Enter Rala Waterways (closest: Western Adoulin F-5 near Adoulin Waterfront Waypoint)",
        "Go south to dead end at (C-6) and click Sluice Gate",
        "Enter password (case sensitive, all capitals): HGSI",
        "  - Password is first initial of each order leader who voted against Colonization",
        "  - H=Hildebert, G=Gratzigg, S=Svenja, I=Ikhi Askamot",
        "If incorrect password entered too many times: Return to library and read History book again",
        "Receive Note detailing seditious plans",
        "If failed to repeat password in cutscene: Click Sluice Gate again to get Key Item",
      }
    },
    {
      id = "mission_soa_2_6",
      name = "Seekers of Adoulin Mission 2-6",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 21,
      game_id = 162,
      repeatable = false,
      steps = {
        "Talk to Ploh Trishbahk at Castle Adoulin gates, Eastern Adoulin (K-9)",
        "If on RoV Mission 3-6 'Tears of the Generals': Speak twice to get both cutscenes",
      }
    },
    {
      id = "mission_soa_2_6_1",
      name = "Seekers of Adoulin Mission 2-6-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 22,
      game_id = 164,
      repeatable = false,
      steps = {
        "Go to Rala Waterways via Western Adoulin (I-12) entrance",
        "  - Near Rent-a-Room Waypoint and Home Point #2 (fastest route to Chalvava)",
        "Speak with Chalvava at (F-11) for cutscene",
        "Receive Box of Adoulinian tomatoes",
      }
    },
    {
      id = "mission_soa_2_6_2",
      name = "Seekers of Adoulin Mission 2-6-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 23,
      game_id = 168,
      repeatable = false,
      steps = {
        "Return to Castle Adoulin gates, Eastern Adoulin (K-9)",
        "Talk to Ploh Trishbahk for cutscene",
      }
    },
    {
      id = "mission_soa_2_7",
      name = "Seekers of Adoulin Mission 2-7",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 24,
      game_id = 170,
      repeatable = false,
      steps = {
        "Return to Sluice Gate at Rala Waterways (C-6) for cutscene",
        "Access: Western Adoulin (F-5) from Adoulin Waterfront Waypoint (easiest)",
        "Or: Rala Waterways Waypoint for 150 Kinetic Units to (C-6) - must walk around",
      }
    },
    {
      id = "mission_soa_2_7_1",
      name = "Seekers of Adoulin Mission 2-7-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 25,
      game_id = 172,
      repeatable = false,
      steps = {
        "Go to Rala Waterways (H-6) and retrieve Waterway facility crank from Storage Container",
        "Access: Western Adoulin (K-8) from Big Bridge Waypoint (easiest from town)",
        "Or: Run directly from Sluice Gate with Sneak (no Invisible needed)",
        "Return to Sluice Gate (C-6) for cutscene",
        "Click Sluice Gate to enter area behind gate",
        "Click Antiquated Sluice Gate to enter battlefield: Behind the Sluices (Battle)",
        "If failed: Return to (H-6) for another Waterway facility crank",
        "Reward: 15,000 Bayld (repeatable for helping others)",
        "Battle notes:",
        "- Fight 4 enemies: The Keeper (SCH/BLM), Mistdagger (NIN), The Briars (WAR), The Briars (RDM/BLM)",
        "- Arciela assists; mission fails if she dies",
        "- All 4 enemies run to random target for weapon skills (causes skillchains on players)",
        "- Alter Ego Trusts may be summoned",
        "- The Keeper: Uses Gust Slash, Cyclone, Aeolian Edge, casts Kaustra; most resistant; fight last",
        "- Mistdagger: Casts Ninjutsu, all Katana weapon skills",
        "- The Briars (WAR): All Great Axe weapon skills, uses Full Break and Fell Cleave",
        "- The Briars (RDM/BLM): Casts -aga 3 black magic and Slow II",
      }
    },
    {
      id = "mission_soa_2_7_2",
      name = "Seekers of Adoulin Mission 2-7-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 26,
      game_id = 178,
      repeatable = false,
      steps = {
        "Walk near Adoulin Castle gates in Eastern Adoulin for cutscene",
      }
    },
    {
      id = "mission_soa_2_7_3",
      name = "Seekers of Adoulin Mission 2-7-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 27,
      game_id = 180,
      repeatable = false,
      steps = {
        "Wait one game day after previous cutscene at Castle",
        "Speak to Levil at Pioneers' Coalition, Western Adoulin (E-8)",
        "If Imprimatur/fame required: 15 imps + Fame 2 (9 quests) is sufficient",
      }
    },
    {
      id = "mission_soa_3_1",
      name = "Seekers of Adoulin Mission 3-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 28,
      game_id = 184,
      repeatable = false,
      steps = {
        "Go to Western Adoulin Airship Docks (H-4 or Waypoint 8) for cutscene",
      }
    },
    {
      id = "mission_soa_3_1_1",
      name = "Seekers of Adoulin Mission 3-1-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 29,
      game_id = 186,
      repeatable = false,
      steps = {
        "Approach Castle Adoulin Gates in Eastern Adoulin for cutscene",
        "After completing: Speak to Rigobertine twice at Eastern Adoulin (J-7) to unlock Ingrid Trust",
        "  - Northern walkway between houses near Castle Gates",
      }
    },
    {
      id = "mission_soa_3_1_2",
      name = "Seekers of Adoulin Mission 3-1-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 30,
      game_id = 188,
      repeatable = false,
      steps = {
        "Speak to Ploh Trishbahk at Eastern Adoulin (K-9) to receive list of required items",
        "Speak to Rigobertine at Eastern Adoulin (J-7) southeast corner to receive Eternal flame",
        "  - Cannot obtain other items without this cutscene",
        "Click Fontis Xanira (water fountain H-8/9 border) at Platea Triumphus, Western Adoulin",
        "  - Receive Vial of untainted holy water",
        "Click Sunrise Beacon on tower at Western Adoulin Waterfront (J-4)",
        "  - Receive Piece of a stone wall",
        "Speak to Erminold at Eastern Adoulin (J-10) near Castle Gates to receive Weather vane wings",
        "  - This is always obtained last; requires having the other two items first",
      }
    },
    {
      id = "mission_soa_3_1_3",
      name = "Seekers of Adoulin Mission 3-1-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 31,
      game_id = 190,
      repeatable = false,
      steps = {
        "Approach Castle Adoulin Gates in Eastern Adoulin with 4 Key Items for cutscene",
      }
    },
    {
      id = "mission_soa_3_1_4",
      name = "Seekers of Adoulin Mission 3-1-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 32,
      game_id = 192,
      repeatable = false,
      steps = {
        "Wait until next game day after finishing previous mission",
        "Speak with Levil at Pioneers' Coalition",
      }
    },
    {
      id = "mission_soa_3_2",
      name = "Seekers of Adoulin Mission 3-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 33,
      game_id = 194,
      repeatable = false,
      steps = {
        "Zone into Celennia Memorial Library for cutscene",
        "Select 2nd option: 'What kind of sweets do you like?'",
      }
    },
    {
      id = "mission_soa_3_2_1",
      name = "Seekers of Adoulin Mission 3-2-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 34,
      game_id = 196,
      repeatable = false,
      steps = {
        "Speak with Levil at Pioneers' Coalition",
      }
    },
    {
      id = "mission_soa_3_2_2",
      name = "Seekers of Adoulin Mission 3-2-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 35,
      game_id = 198,
      repeatable = false,
      steps = {
        "Wait one game day from last mission",
        "Zone into Ceizak Battlegrounds from Western Adoulin (don't use waypoint)",
      }
    },
    {
      id = "mission_soa_3_3",
      name = "Seekers of Adoulin Mission 3-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 36,
      game_id = 200,
      repeatable = false,
      steps = {
        "Zone into Celennia Memorial Library for cutscene",
      }
    },
    {
      id = "mission_soa_3_3_1",
      name = "Seekers of Adoulin Mission 3-3-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 37,
      game_id = 202,
      repeatable = false,
      steps = {
        "Speak to Elmric at Frontier Station in Ceizak Battlegrounds",
      }
    },
    {
      id = "mission_soa_3_3_2",
      name = "Seekers of Adoulin Mission 3-3-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 38,
      game_id = 204,
      repeatable = false,
      steps = {
        "Check Boarding House Door at Eastern Adoulin (H-9) near Statue of Goddess Waypoint #3",
        "Note: Very long cutscene",
      }
    },
    {
      id = "mission_soa_3_3_3",
      name = "Seekers of Adoulin Mission 3-3-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 39,
      game_id = 206,
      repeatable = false,
      steps = {
        "Approach Ergon Locus (Torchbloom) in Foret de Hennetiel (J-7/K-7)",
        "  - Close to Frontier Station Waypoint",
        "Cutscene with Nyline",
      }
    },
    {
      id = "mission_soa_3_3_4",
      name = "Seekers of Adoulin Mission 3-3-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 40,
      game_id = 208,
      repeatable = false,
      steps = {
        "Return to Boarding House Door at Eastern Adoulin (H-9) Waypoint #3 for cutscene",
        "Receive: 1000 Experience Points, 1000 Bayld",
      }
    },
    {
      id = "mission_soa_3_3_5",
      name = "Seekers of Adoulin Mission 3-3-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 41,
      game_id = 210,
      repeatable = false,
      steps = {
        "Wait one game day from last mission",
        "Speak to Levil at Pioneers' Coalition to start next mission",
        "Receive: 100 Bayld",
      }
    },
    {
      id = "mission_soa_3_4",
      name = "Seekers of Adoulin Mission 3-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 42,
      game_id = 212,
      repeatable = false,
      steps = {
        "Go to Mummers' Coalition, Western Adoulin and speak to Masad for cutscene with Teodor",
        "Beat him at minigame 'Boom or Bust' - must win 3 rounds",
        "Game rules:",
        "  - Shoot: Increases roll like Corsair Phantom Roll; over 11 = bust and lose round",
        "  - Stay: Close round; both stay = highest closest to 11 wins",
        "  - Trick (one per round): Peek (see opponent roll), Swap (trade rolls), Crooked (force reroll)",
        "  - Fold: Lose round",
        "If you lose: Talk to Masad twice to try again",
        "Alternative: Purchase 'Card Jailer Teodor' from Curio Vendor Moogle for 1000 Gil to skip",
        "  - Must speak to Masad for final cutscene with Teodor if skipped",
      }
    },
    {
      id = "mission_soa_3_4_1",
      name = "Seekers of Adoulin Mission 3-4-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 43,
      game_id = 214,
      repeatable = false,
      steps = {
        "Beat Teodor at Boom or Bust minigame to complete mission",
        "Or: Purchase 'Card Jailer Teodor' to automatically win",
      }
    },
    {
      id = "mission_soa_3_4_2",
      name = "Seekers of Adoulin Mission 3-4-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 44,
      game_id = 216,
      repeatable = false,
      steps = {
        "Talk to Levil at Pioneers' Coalition",
        "Select first option: 'Ortharsyne'",
      }
    },
    {
      id = "mission_soa_3_4_3",
      name = "Seekers of Adoulin Mission 3-4-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 45,
      game_id = 220,
      repeatable = false,
      steps = {
        "Zone into Celennia Memorial Library for cutscene",
      }
    },
    {
      id = "mission_soa_3_4_4",
      name = "Seekers of Adoulin Mission 3-4-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 46,
      game_id = 222,
      repeatable = false,
      steps = {
        "Speak to Ploh Trishbahk at castle gate, Eastern Adoulin (K-9)",
      }
    },
    {
      id = "mission_soa_3_5",
      name = "Seekers of Adoulin Mission 3-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 47,
      game_id = 224,
      repeatable = false,
      steps = {
        "Go to Ceizak Battlegrounds intersection (I-7)/(J-8)",
        "Click Signs of Struggle target for cutscene",
        "Location: Southwest of Frontier Station, narrow pathway before Bight Uragnite",
        "  - Follow wall from Frontier Station",
        "  - Target is next to Twigtrip Lapinion and tree",
        "Receive: Pristine hair ribbon",
      }
    },
    {
      id = "mission_soa_3_5_1",
      name = "Seekers of Adoulin Mission 3-5-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 48,
      game_id = 226,
      repeatable = false,
      steps = {
        "Approach Castle Adoulin gates in Eastern Adoulin for cutscene",
      }
    },
    {
      id = "mission_soa_3_5_2",
      name = "Seekers of Adoulin Mission 3-5-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 49,
      game_id = 228,
      repeatable = false,
      steps = {
        "Speak to Levil at Pioneers' Coalition, Western Adoulin",
      }
    },
    {
      id = "mission_soa_3_5_3",
      name = "Seekers of Adoulin Mission 3-5-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 50,
      game_id = 232,
      repeatable = false,
      steps = {
        "Approach Wegellion at Scouts' Coalition, Eastern Adoulin (Waypoint #2)",
        "Receive Tintinnabulum after cutscene",
      }
    },
    {
      id = "mission_soa_3_6",
      name = "Seekers of Adoulin Mission 3-6",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 51,
      game_id = 234,
      repeatable = false,
      steps = {
        "Zone into Kamihr Drifts for cutscene",
        "  - Can use Woh Gates entrance, Home Point, or waypoint",
        "Bivouac #2 closest to next mission location",
      }
    },
    {
      id = "mission_soa_3_6_1",
      name = "Seekers of Adoulin Mission 3-6-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 52,
      game_id = 236,
      repeatable = false,
      steps = {
        "Examine Crawling Cave at Kamihr Drifts (F-11) for long cutscene",
        "To reach west side: Head through cave northwest of (G-10)",
        "  - Bivouac #2 is closest",
        "  - From Waypoint: Exit cave via west tunnel",
        "  - Turn right, head north to inlet at northernmost (G-10)",
        "  - Go down slope and through cave",
        "  - Travel southwest until you see 'Crawling Cave' target point and click it",
        "Receive Aureate ball of fur",
      }
    },
    {
      id = "mission_soa_3_6_2",
      name = "Seekers of Adoulin Mission 3-6-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 53,
      game_id = 242,
      repeatable = false,
      steps = {
        "Go to southwest corner of Kamihr Drifts (G-11)",
        "Click Hollowed Pathway and choose 'Proceed' for cutscene",
        "Note: This does not initiate BCNM",
      }
    },
    {
      id = "mission_soa_3_6_3",
      name = "Seekers of Adoulin Mission 3-6-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 54,
      game_id = 244,
      repeatable = false,
      steps = {
        "Click Hollowed Pathway again to enter 'Stonewalled' battlefield",
        "May enter solo and summon Trusts",
        "Time limit: 30 minutes; buffs except food wear on entry",
        "If failed: Return to Crawling Cave (F-11) Kamihr Drifts for another Aureate ball of fur",
        "Battle: Kill Primongenial Marolith to win",
        "  - Assisted by Gargouille Drudges (arrive one at a time, low HP, unlimited)",
        "Receive Soul siphon",
        "Tip: Don't warp after fight; next mission is cutscene at Crawling Cave",
      }
    },
    {
      id = "mission_soa_3_6_4",
      name = "Seekers of Adoulin Mission 3-6-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 55,
      game_id = 248,
      repeatable = false,
      steps = {
        "Return to Crawling Cave at Kamihr Drifts (F-11) for cutscene",
        "Select third option: 'Her hilt-clutching hands.'",
      }
    },
    {
      id = "mission_soa_3_6_5",
      name = "Seekers of Adoulin Mission 3-6-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 56,
      game_id = 250,
      repeatable = false,
      steps = {
        "Wait until next game day",
        "Speak to Levil at Pioneers' Coalition for cutscene with him humming",
        "Optional: If haven't acquired Ingrid Trust, speak to Rigobertine at Eastern Adoulin (J-7)",
      }
    },
    {
      id = "mission_soa_4_1",
      name = "Seekers of Adoulin Mission 4-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 57,
      game_id = 252,
      repeatable = false,
      steps = {
        "Speak to Kipligg at entrance of Couriers' Coalition",
        "Accept request to head to Waterfront in Western Adoulin",
      }
    },
    {
      id = "mission_soa_4_1_1",
      name = "Seekers of Adoulin Mission 4-1-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 58,
      game_id = 254,
      repeatable = false,
      steps = {
        "Go to Western Adoulin Waterfront (Waypoint #9)",
        "Examine Port Storage door at (J-4) for cutscene",
        "Bring ONE item to Guilberien (depends on bond with Arciela):",
        "  - Eft Skin (x5)",
        "  - Manticore Hair (x4)",
        "  - Buffalo Horn",
        "  - Manticore Leather",
        "  - Buffalo Leather",
        "Trade item to Port Storage door at (J-4) for cutscene with Guilberien",
      }
    },
    {
      id = "mission_soa_4_1_2",
      name = "Seekers of Adoulin Mission 4-1-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 59,
      game_id = 256,
      repeatable = false,
      steps = {
        "Trade ONE requested item to Port Storage door:",
        "  - Eft Skin (x5), Manticore Hair (x4), Buffalo Horn, Manticore Leather, or Buffalo Leather",
        "  - Item depends on bond with Arciela (Buffalo Horn = lowest)",
      }
    },
    {
      id = "mission_soa_4_1_3",
      name = "Seekers of Adoulin Mission 4-1-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 60,
      game_id = 258,
      repeatable = false,
      steps = {
        "Return and speak with Kipligg at entrance of Couriers' Coalition",
      }
    },
    {
      id = "mission_soa_4_1_4",
      name = "Seekers of Adoulin Mission 4-1-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 61,
      game_id = 260,
      repeatable = false,
      steps = {
        "Speak with Levil for reward",
        "Receive: 500 Bayld",
      }
    },
    {
      id = "mission_soa_4_1_5",
      name = "Seekers of Adoulin Mission 4-1-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 62,
      game_id = 262,
      repeatable = false,
      steps = {
        "Zone and wait until next game day",
        "Speak to Levil at Pioneers' Coalition for cutscene",
        "Select 'What happened after that?'",
      }
    },
    {
      id = "mission_soa_4_2",
      name = "Seekers of Adoulin Mission 4-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 63,
      game_id = 264,
      repeatable = false,
      steps = {
        "Examine Alpine Trail in Kamihr Drifts at (H-5) for cutscene",
        "  - Enters zone Mount Kamihr",
        "  - Very northern-middle point on map",
        "Fastest route: Bivouac #3 -> north tunnel -> follow left wall north",
        "Or: Use Home Point nearby",
      }
    },
    {
      id = "mission_soa_4_2_1",
      name = "Seekers of Adoulin Mission 4-2-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 64,
      game_id = 266,
      repeatable = false,
      steps = {
        "Zone into Celennia Memorial Library for cutscene",
        "Read different stories in cutscene to continue",
      }
    },
    {
      id = "mission_soa_4_2_2",
      name = "Seekers of Adoulin Mission 4-2-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 65,
      game_id = 268,
      repeatable = false,
      steps = {
        "Return to Alpine Trail in Kamihr Drifts at (H-5) north of Bivouac #3",
        "Answer questions correctly:",
        "  - Yorcia Weald",
        "  - Morimar",
        "  - The Serpentine Labyrinth.",
        "  - Yes it does.",
        "  - Who are 'They'?",
        "  - Unleash a feral scream.",
        "  - What are you proposing?",
      }
    },
    {
      id = "mission_soa_4_2_3",
      name = "Seekers of Adoulin Mission 4-2-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 66,
      game_id = 270,
      repeatable = false,
      steps = {
        "Enter Woh Gates from any entrance for cutscene",
        "Closest from zone: Frontier Station in Kamihr Drifts, entrance at (K-11)",
        "From city: Marjami Ravine WP #4, walk northwest",
      }
    },
    {
      id = "mission_soa_4_2_4",
      name = "Seekers of Adoulin Mission 4-2-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 67,
      game_id = 272,
      repeatable = false,
      steps = {
        "Examine Darkened Crevice in Woh Gates at (G-7)/(G-8) border for cutscene",
        "  - Slightly inside tunnel, just before downward slope",
        "From Kamihr Drifts: Fall at (I-5), fall again at (H-6), proceed to (G-7)/(G-8) border",
        "From Marjami Ravine: Follow left wall (skips reive at H-9, clear one at H-7)",
        "Before big room: Use Sneak+Invisible (Silent Oil & Prism Powder recommended)",
        "  - Bergschrund Gefryst aggros magic",
        "  - Metalcruncher Worm aggros sound",
        "  - Serac Rabbit and Powdery Snoll aggro sight",
        "Receive Tuft of golden fur (BCNM entry item, lost on entry)",
      }
    },
    {
      id = "mission_soa_4_3",
      name = "Seekers of Adoulin Mission 4-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 68,
      game_id = 274,
      repeatable = false,
      steps = {
        "Examine Darkened Crevice at Woh Gates (G-8) to enter 'The Gates' BCNM vs waves of Umbrils",
        "May attempt solo; battle starts after ~1 minute (time to buff/call Trusts)",
        "Assisted by: Arciela, Darrcuiln, Noble Warrior, Resolute Leafkins",
        "  - Arciela casts Haste, Protect V, Shell V on party and NPCs",
        "Fight lost if any NPCs die",
        "  - Buff/heal NPCs with Blood Pact: Wards or Accession (cast on Trust for Regen V)",
        "  - Curaga on Trust affects entire group (not on PC)",
        "Fight won even if all players dead but NPCs kill monsters",
        "If failed: Re-acquire Tuft of golden fur at Woh Gates (J-8)/(K-8) border near Yorcia Weald exit",
        "All players on mission need Key Item to enter; completed players don't",
      }
    },
    {
      id = "mission_soa_4_3_1",
      name = "Seekers of Adoulin Mission 4-3-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 69,
      game_id = 278,
      repeatable = false,
      steps = {
        "Return to Kamihr Drifts and examine Alpine Trail at (H-5) north of Bivouac #3",
        "If defeated WKR: Scene references it; if have Naakual crest, you'll look at it",
        "Receive Sajj'aka's protective ward",
        "Aged Riptide Naakual crest",
        "Aged Firebrand Naakual crest",
        "Aged Ligneous Naakual crest",
        "Aged Booming Naakual crest",
        "Aged Flashfrost Naakual crest",
      }
    },
    {
      id = "mission_soa_4_3_2",
      name = "Seekers of Adoulin Mission 4-3-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 70,
      game_id = 280,
      repeatable = false,
      steps = {
        "Head to Outer Ra'Kaznar via Liseran Door: Entrance in Kamihr Drifts (F-8)",
        "  - Or use Waypoint: Enigmatic Device → Outer Ra'Kaznar if unlocked",
        "For Colonization Reives: Talk to Lerene at (N-7) near Kamihr Drifts zone for quest Lerene's Lament",
        "  - Trade 2 Ancestral Cloth to receive 'Pulverizing' Key Item to destroy Amaranth Barriers",
        "Collect items in Outer Ra'Kaznar (recommended order):",
        "  1. Effigy of Sealing at (I-11) Upstairs Map 1 → Starblessed scale",
        "  2. Silvery Plate at (C-7) Upstairs Map 1 → Silvery plate (required for elevator at I-6)",
        "  3. Effigy of Sealing at (H-2) Upstairs Map 1 → Moontouched scale",
        "  4. Demonic Architrave at (C-8) Basement Map 2 → Sunkissed scale",
        "Return to Kamihr Drifts Bivouac #3 (or Home Point)",
        "Examine Alpine Trail at (H-5) for cutscene and World Tree sapling",
      }
    },
    {
      id = "mission_soa_4_3_3",
      name = "Seekers of Adoulin Mission 4-3-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 71,
      game_id = 282,
      repeatable = false,
      steps = {
        "Speak to Ploh Trishbahk at Castle Gates, Eastern Adoulin (L-9)",
        "Select 'Tree Grafting.'",
      }
    },
    {
      id = "mission_soa_4_3_4",
      name = "Seekers of Adoulin Mission 4-3-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 72,
      game_id = 284,
      repeatable = false,
      steps = {
        "Talk to Levil at Pioneers' Coalition, Western Adoulin",
      }
    },
    {
      id = "mission_soa_4_3_5",
      name = "Seekers of Adoulin Mission 4-3-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 73,
      game_id = 286,
      repeatable = false,
      steps = {
        "Travel to Kamihr Drifts (G-11) and click Blockaded Path to enter Leafallia",
        "  - Bivouac #2 is closest teleport",
        "  - Southeast of Hollowed Pathway from mission 3-6-2",
        "Receive: Access to Leafallia",
      }
    },
    {
      id = "mission_soa_4_3_6",
      name = "Seekers of Adoulin Mission 4-3-6",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 74,
      game_id = 288,
      repeatable = false,
      steps = {
        "Examine Aged Stump at Leafallia (H-8) for cutscene",
      }
    },
    {
      id = "mission_soa_4_3_7",
      name = "Seekers of Adoulin Mission 4-3-7",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 75,
      game_id = 290,
      repeatable = false,
      steps = {
        "Click Heroic Footprints at Leafallia (H-8) for lengthy cutscene",
        "  - Next to tree, behind and across river from Aged Stump",
      }
    },
    {
      id = "mission_soa_4_3_8",
      name = "Seekers of Adoulin Mission 4-3-8",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 76,
      game_id = 292,
      repeatable = false,
      steps = {
        "Return to Ploh Trishbahk at Adoulin Castle gates, Eastern Adoulin for cutscene",
        "Select necklace reward (must select to progress):",
        "  - Adoulin's Refuge",
        "  - Arciela's Grace",
        "  - Ygnas's Resolve",
        "Note: Choice doesn't affect +1 version later; will trade in necklace for +1",
      }
    },
    {
      id = "mission_soa_4_3_9",
      name = "Seekers of Adoulin Mission 4-3-9",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 77,
      game_id = 294,
      repeatable = false,
      steps = {
        "Wait until next game day from previous mission",
        "Talk to Levil at Pioneers' Coalition (E-8) Western Adoulin",
        "Receive: 500 Experience Points",
      }
    },
    {
      id = "mission_soa_4_4",
      name = "Seekers of Adoulin Mission 4-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 78,
      game_id = 296,
      repeatable = false,
      steps = {
        "Approach Adoulin Castle gates at Eastern Adoulin (K-9) for cutscene",
      }
    },
    {
      id = "mission_soa_4_4_1",
      name = "Seekers of Adoulin Mission 4-4-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 79,
      game_id = 298,
      repeatable = false,
      steps = {
        "Enter Rala Waterways from Western Adoulin (I-12) near Residential Area",
        "Head to (F-11) and speak to Chalvava for cutscene",
        "Closest: Waypoint #6 or Home Point #2",
      }
    },
    {
      id = "mission_soa_4_4_2",
      name = "Seekers of Adoulin Mission 4-4-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 80,
      game_id = 300,
      repeatable = false,
      steps = {
        "Return to Adoulin Castle and talk to Ploh Trishbahk",
        "Extended cutscene with Arciela and Order of Renaye",
      }
    },
    {
      id = "mission_soa_4_4_3",
      name = "Seekers of Adoulin Mission 4-4-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 81,
      game_id = 302,
      repeatable = false,
      steps = {
        "Enter Rala Waterways and click 3 points:",
        "  - Sainene at (N-7)",
        "  - Waterway Overlook at (I-6)",
        "  - Stout Weir at (D-8)",
        "Entrance: Eastern Adoulin (F-7) puts you at (K-5), close to 2 points",
        "Receive Broken fuse from Stout Weir",
        "Return to Castle Adoulin and speak to Ploh Trishbahk",
      }
    },
    {
      id = "mission_soa_4_4_4",
      name = "Seekers of Adoulin Mission 4-4-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 82,
      game_id = 306,
      repeatable = false,
      steps = {
        "Zone out of Eastern Adoulin then return.",
        "Speak with Ploh Trishbahk for cutscene.",
      }
    },
    {
      id = "mission_soa_4_5",
      name = "Seekers of Adoulin Mission 4-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 83,
      game_id = 308,
      repeatable = false,
      steps = {
        "Wait until next game day.",
        "Speak with Ploh Trishbahk for cutscene.",
      }
    },
    {
      id = "mission_soa_4_5_1",
      name = "Seekers of Adoulin Mission 4-5-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 84,
      game_id = 310,
      repeatable = false,
      steps = {
        "Trade Ploh Trishbahk necklace from earlier mission: Adoulin's Refuge, Arciela's Grace, or Ygnas's Resolve.",
        "If you lost the necklace, speak with Ploh Trishbahk to continue.",
      }
    },
    {
      id = "mission_soa_4_5_2",
      name = "Seekers of Adoulin Mission 4-5-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 85,
      game_id = 312,
      repeatable = false,
      steps = {
        "Enter Celennia Memorial Library, Eastern Adoulin.",
        "Speak with Andreine for cutscene. Receive \"Suffering Sacchariferous\".",
      }
    },
    {
      id = "mission_soa_4_5_3",
      name = "Seekers of Adoulin Mission 4-5-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 86,
      game_id = 314,
      repeatable = false,
      steps = {
        "Return to Ploh Trishbahk for cutscene.",
        "Receive Sepulcher ensign.",
      }
    },
    {
      id = "mission_soa_4_5_4",
      name = "Seekers of Adoulin Mission 4-5-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 87,
      game_id = 316,
      repeatable = false,
      steps = {
        "Enter Rala Waterways from Eastern Adoulin (F-7), near Waypoint #1 and #4.",
        "Go to (N-10) and click Royal Sepulcher for cutscene.",
      }
    },
    {
      id = "mission_soa_4_6",
      name = "Seekers of Adoulin Mission 4-6",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 88,
      game_id = 318,
      repeatable = false,
      steps = {
        "Kill enemies in Rala Waterways until you receive Consummate simulacrum.",
        "Higher drop rate from Waterway Pugils and New Moon Bats.",
        "All party members in zone on mission receive key item simultaneously.",
        "Go to Augural Conveyor (B-6) and select it.",
        "Choose \"The Charlatan\" to enter battle immediately.",
        "Fight Balamor and three Dullahan. Arciela assists you.",
        "Defeat Balamor only (surrenders at 20% HP).",
        "Battle lost if Arciela falls. Trust Magic allowed.",
        "Regicidal Dullahan always targets Arciela. Balamor and Sycophants share hate.",
        "After victory, return to Royal Sepulcher.",
        "Repeating costs 20k Bayld.",
      }
    },
    {
      id = "mission_soa_4_6_1",
      name = "Seekers of Adoulin Mission 4-6-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 89,
      game_id = 320,
      repeatable = false,
      steps = {
        "Return to Ploh Trishbahk to receive upgraded necklace.",
        "Choose: Adoulin's Refuge +1, Arciela's Grace +1, or Ygnas's Resolve +1.",
        "Choice is permanent. Can choose any regardless of previous selection.",
        "Note: If on Rhapsodies mission Solemnity, complete that first.",
        "Rewards: 500 Experience Points.",
      }
    },
    {
      id = "mission_soa_4_6_2",
      name = "Seekers of Adoulin Mission 4-6-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 90,
      game_id = 324,
      repeatable = false,
      steps = {
        "Wait until next game day.",
        "Speak with Levil at Pioneers' Coalition, Western Adoulin (E-8).",
        "Select \"'Strange'? Can you be more specific?\" then \"Of course they will!\" to continue.",
      }
    },
    {
      id = "mission_soa_5_1",
      name = "Seekers of Adoulin Mission 5-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 91,
      game_id = 326,
      repeatable = false,
      steps = {
        "Go to Castle Adoulin gates, Eastern Adoulin.",
        "Speak with Ploh Trishbahk (K-9) for cutscene.",
        "Select \"I just want to see Arciela.\" Receive Hastily scribbled note.",
      }
    },
    {
      id = "mission_soa_5_1_1",
      name = "Seekers of Adoulin Mission 5-1-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 92,
      game_id = 328,
      repeatable = false,
      steps = {
        "Open Hastily scribbled note in Temporary Key Items (required to proceed).",
        "Go to Waterfront, Western Adoulin, Waypoint #9.",
        "Examine Sunrise Beacon (J-4) for cutscene.",
      }
    },
    {
      id = "mission_soa_5_1_2",
      name = "Seekers of Adoulin Mission 5-1-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 93,
      game_id = 330,
      repeatable = false,
      steps = {
        "Go to Kamihr Drifts (Bivouac #3 or Home Point #1 recommended).",
        "Examine Alpine Trail (H-5) for cutscene.",
      }
    },
    {
      id = "mission_soa_5_1_3",
      name = "Seekers of Adoulin Mission 5-1-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 94,
      game_id = 332,
      repeatable = false,
      steps = {
        "Enter Leafallia via Blockaded Path (G-11) in Kamihr Drifts, Home Point #1 (Eastern Ulbuka), or Home Point #1 (Leafallia).",
        "Click Aged Stump for cutscene.",
        "Receive Sky blue pome and Sun yellow pome.",
      }
    },
    {
      id = "mission_soa_5_2",
      name = "Seekers of Adoulin Mission 5-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 95,
      game_id = 334,
      repeatable = false,
      steps = {
        "Complete two BCNM fights in either order. Win by bringing target to 10% HP.",
        "Drawing weapon starts battle immediately.",
        "If you fail, return to Leafallia and click Aged Stump to reacquire key item.",
        "Fight 1 - Dhokmak:",
        "Go to (K-11) in Cirdas Caverns. Routes: Waypoint → Yorcia Weald Frontier Station → west to Cirdas Caverns; Waypoint → Enigmatic Device → Cirdas Caverns; or via Ceizak Battlegrounds.",
        "Examine Wavering Flux for cutscene then examine again.",
        "Fight Dhokmak and 3 Malignant Acuex. Darrcuiln assists (battle lost if he dies).",
        "Defeat Dhokmak (100k HP, surrenders below 10%).",
        "Receive Dhokmak's blood sigil and title \"Vanquisher of Dhokmak\".",
        "Fight 2 - Ashrakk:",
        "Go to southeastern (H-6) in Yorcia Weald. Fastest: Waypoint → Yorcia Weald → Frontier Bivouac #1.",
        "Examine Wavering Flux for cutscene then examine again.",
        "Fight Ashrakk (summons Hell-spawned Orthrus below 50%). Morimar assists (battle lost if he dies).",
        "Defeat Ashrakk (100k HP, surrenders below 10%).",
        "Receive Ashrakk's blood sigil and title \"Vanquisher of Ashrakk\".",
        "Repeating battles: 20,000 Bayld per fight.",
      }
    },
    {
      id = "mission_soa_5_2_1",
      name = "Seekers of Adoulin Mission 5-2-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 96,
      game_id = 336,
      repeatable = false,
      steps = {
        "Enter Leafallia via Blockaded Path (G-11) in Kamihr Drifts or Home Point.",
        "Select \"Ask for forgiveness.\" then \"I promise.\" to continue.",
      }
    },
    {
      id = "mission_soa_5_2_2",
      name = "Seekers of Adoulin Mission 5-2-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 97,
      game_id = 338,
      repeatable = false,
      steps = {
        "Reach bottom of Ra'Kaznar Turris and examine Ominous Postern for cutscene.",
        "Quick route: Use Ra'Kaznar Inner Court Home Point #1 then Vertical Transit Device to Ra'Kaznar Turris.",
        "Alternative routes (choose one based on cleared Naakual crests):",
        "1. Yumcax cleared (Aged Ligneous Naakual crest): Yorcia Weald (I-11) → Cirdas Caverns Map 2 (H-6) → Ra'Kaznar Inner Court Map 2.",
        "2. Tchakka cleared (Aged Riptide Naakual crest): Foret de Hennetiel → Dho Gates Map 2.",
        "3. Hurkan cleared (Aged Booming Naakual crest): Marjami Ravine (F-11) Waypoint 3 → Woh Gates Map 2 → Ra'Kaznar Inner Court.",
        "4. Achuka cleared (Aged Firebrand Naakual crest): Morimar Basalt Fields → Moh Gates Map 2.",
        "5. Colkhab cleared (Aged Matriarch Naakual crest): Ceizak Battlegrounds → Sih Gates Map 2.",
        "6. Kumhau cleared (Aged Flashfrost Naakual crest): Woh Gates (D-8) Map 1 → Outer Map 2 (L-8) → elevator to Inner (I-8).",
        "7. No Naakual cleared: Full traversal from Outer Ra'Kaznar (Augural Conveyor) → Inner Court. Requires Demolishing and Silvery plate from ??? (C-7) Map 1.",
        "From Ra'Kaznar Inner Court Map 2, follow left wall and use Vertical Transit Device to enter Ra'Kaznar Turris.",
        "Descend to bottom and examine Ominous Postern for cutscene.",
        "After cutscene, you'll be in Kamihr Drifts at (F-8) entrance to Outer Ra'Kaznar.",
      }
    },
    {
      id = "mission_soa_5_3",
      name = "Seekers of Adoulin Mission 5-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 98,
      game_id = 342,
      repeatable = false,
      steps = {
        "After previous cutscene, you'll be in Kamihr Drifts.",
        "Go to Kamihr Drifts (H-5). Fastest: Warp then Bivouac #3 or Home Point.",
        "Examine Alpine Trail for cutscene.",
        "Select \"I thought he was a libertine, myself.\" to continue.",
        "Receive Ash runic board.",
      }
    },
    {
      id = "mission_soa_5_3_2",
      name = "Seekers of Adoulin Mission 5-3-2",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 99,
      game_id = 344,
      repeatable = false,
      steps = {
        "Examine Entrance: Coliseum at Rala Waterways (M-6) for cutscene.",
        "Ash runic board becomes Blank ash runic board upon entry.",
        "Fight Teodor (surrenders below 10% HP).",
        "Takes magic and physical damage. Dispel Dread Spikes or melee swings will kill you.",
        "If you fail, wait until next game day and re-enter Rala Waterways. Blank ash runic board converts back to Ash runic board.",
        "Rewards: Aged undying Naakual crest, Teodor's blood sigil, Crystallized psyche.",
        "Unlocks Prototype sigil pearl for Vagary.",
        "Repeating costs 20,000 Bayld.",
      }
    },
    {
      id = "mission_soa_5_3_3",
      name = "Seekers of Adoulin Mission 5-3-3",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 100,
      game_id = 346,
      repeatable = false,
      steps = {
        "Go to bottom of Ra'Kaznar Turris.",
        "Examine Ominous Postern for cutscene.",
        "Note: Ra'Kaznar Inner Court Home Point #1 is near entrance if you have it.",
      }
    },
    {
      id = "mission_soa_5_4",
      name = "Seekers of Adoulin Mission 5-4",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 101,
      game_id = 350,
      repeatable = false,
      steps = {
        "Examine Ominous Postern to enter fight against Hades (First Form).",
        "Arciela assists. Mission fails if she dies.",
        "Drawing weapon starts battle immediately.",
        "Trusts allowed.",
        "After victory, receive Awakened crystallized psyche.",
        "If you lose, re-zone to Ra'Kaznar Inner Court for another Crystallized psyche.",
        "Repeating costs 20k Bayld.",
      }
    },
    {
      id = "mission_soa_5_4_1",
      name = "Seekers of Adoulin Mission 5-4-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 102,
      game_id = 352,
      repeatable = false,
      steps = {
        "Examine Ominous Postern in Ra'Kaznar Turris to enter fight against Hades (Second Form).",
        "Arciela and Teodor assist. Mission fails if either dies.",
        "Can only cure Arciela. Cannot target Teodor. Hades' HP bar hidden.",
        "Drawing weapon starts battle immediately.",
        "After victory, cutscene then return to Ceizak Battlegrounds.",
        "If you lose, re-zone to Ra'Kaznar Inner Court for another Awakened crystallized psyche.",
        "Repeating costs 25k Bayld.",
      }
    },
    {
      id = "mission_soa_5_5",
      name = "Seekers of Adoulin Mission 5-5",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 103,
      game_id = 356,
      repeatable = false,
      steps = {
        "Zone into Western Adoulin from Ceizak Battlegrounds for cutscene.",
        "Go to Castle Gates, Eastern Adoulin.",
        "Speak with Ploh Trishbahk for cutscenes.",
      }
    },
    {
      id = "mission_soa_5_5_1",
      name = "Seekers of Adoulin Mission 5-5-1",
      type = "mission",
      location = "seekers_of_adoulin",
      nation = "seekers_of_adoulin",
      mission_index = 104,
      game_id = 360,
      repeatable = false,
      steps = {
        "Note: Cutscene may freeze at 60fps. Use //config FrameRateDivisor 2 or press PrtScr to unfreeze.",
        "Wait one game day after previous mission.",
        "Zone into Ceizak Battlegrounds for cutscene.",
        "Optional: Select \"No?\" ~12 times for extra dialogue and Arciela's spare bonnet (lowers bond to minimum).",
        "Return to Castle Gates, Eastern Adoulin.",
        "Speak with Ploh Trishbahk for final cutscene and reward.",
        "Choose one ring: Adoulin, Gorney, Haverton, Janniston, Karieyh, Orvail, Renaye, Shneddick, Thurandaut, Vocane, Weatherspoon, or Woltaris Ring.",
        "If you drop ring or Councilor's gear, wait until next game day. Ploh returns one item per day: Councilor's Garb → Cuffs → ring.",
        "To change ring: Have 300,000 Bayld and trade current ring to Ploh.",
        "Rewards: 1,000 Experience Points, Councilor's Cuffs, Councilor's Garb, chosen ring, Arciela's skirt.",
        "After final cutscene, speak with Ploh Trishbahk again.",
        "Examine Sandy Overlook in Ceizak Battlegrounds (J-10) for cutscene to obtain Arciela's Trust.",
        "Unlocks: Quest chain \"No Mercy for the Wicked\", Sortie battle content, updated Celennia Memorial Library books.",
      }
    },
  }
}


