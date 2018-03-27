-- Butcherbot (25112)
-- By Stevej & Fearz & Namek

SET @BUTCHERBOT:=39696;
SET @BUTCHERING:=74168; -- Spell Butcherbot butchering
SET @BASILISK:=5419; -- npc Glasshide Basilisk
SET @SPELL:=74175; -- Deploy butcherbot
SET @SUMMON:=74176; -- Summon butcherbot to corpse

SET @BASILISK_CREDIT:=39702; -- Tanaris basilisk kill credit bunny

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (@BUTCHERBOT, @BASILISK);

DELETE FROM `creature_text` WHERE `entry` IN (@BUTCHERBOT) AND `groupid` IN (0);

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,
`sound`,`comment`) VALUES
(@BUTCHERBOT,0,0,"Chop chop chop!",12,0,100,0,0,0,"Butcherbot Say 1"),
(@BUTCHERBOT,0,1,"Hooray for meat! HIP HIP HOORAY!",12,0,100,0,0,0,"Butcherbot Say 2"),
(@BUTCHERBOT,0,2,"No part goes to waste! Yay!",12,0,100,0,0,0,"Butcherbot Say 3"),
(@BUTCHERBOT,0,3,"VWHHHHHRRRRRRRRRRRRRRRRHHHHHHMNNNGHHHGH",12,0,100,0,0,0,"Butcherbot Say 4"),
(@BUTCHERBOT,0,4,"Yaaaaaaaaaaaaaaaaaaaaaay!",12,0,100,0,0,0,"Butcherbot Say 5");

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BUTCHERBOT, @BASILISK) AND `source_type` IN (0);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BUTCHERBOT,0,0,1,54,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"JUST SUMMONED - FOLLOW - ACTION INVOKER"),
(@BUTCHERBOT,0,1,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - TALK - SELF"),
(@BUTCHERBOT,0,2,0,1,0,100,1,4000,4000,0,0,11,@BUTCHERING,2,0,0,0,0,7,0,0,0,0,0,0,0,"UPDATE OOC - CAST - ACTION INVOKER"),

-- Glasshide Basilisk
(@BASILISK,0,0,0,0,0,100,0,4000,4500,15000,16000,11,5106,0,0,0,0,0,2,0,0,0,0,0,0,0,"UPDATE IC - CAST - VICTIM"),
(@BASILISK,0,1,2,8,0,100,1,74175,0,0,0,11,@SUMMON,2,0,0,0,0,1,0,0,0,0,0,0,0,"SPELLHIT - CAST - SELF"),
(@BASILISK,0,2,0,61,0,100,0,0,0,0,0,33,39702,0,0,0,0,0,7,0,0,0,0,0,0,0,"LINK - CAST - ACTION INVOKER");