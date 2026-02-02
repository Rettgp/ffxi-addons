return {
  quests = {
    {
      id = "mission_bastok_1_1",
      name = "The Zeruhn Report (1-1)",
      type = "mission",
      location = "Bastok",
      nation = "bastok",
      mission_index = 1,  -- Sequential index within nation (1-based)
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
      id = "mission_windurst_1_1",
      name = "The Horutoto Ruins Experiment (1-1)",
      type = "mission",
      location = "Windurst",
      nation = "windurst",
      game_id = 1,
      repeatable = false,
      steps = {
        "Speak with Apururu in Heavens Tower to accept mission",
        "Enter Horutoto Ruins from East Sarutabaruta",
        "Defeat the enemies and complete the objective",
        "Return to Apururu in Heavens Tower"
      }
    },
    {
      id = "jeuno_1",
      name = "Chocobo's Wounds",
      type = "quest",
      location = "Jeuno",
      repeatable = false,
      steps = {
        "Speak with Dietmund in Lower Jeuno (H-8)",
        "Obtain a Gysahl Greens from the Auction House or farm",
        "Trade the Gysahl Greens to Dietmund",
        "Wait one game day (approximately 1 real hour)",
        "Return to Dietmund for your reward"
      }
    }
  }
}
