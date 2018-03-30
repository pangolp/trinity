-- Secrets in the Oasis (25032)
-- by Stevej

SET @CREDIT:=39159; -- Mazoga Credit Stalker
SET @MAZOGA:=38968; -- npc Mazoga
SET @JANGTHRAZE:=202441; -- Object Jang'thraze the Protector

-- minlevel and maxlevel 1
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14, `minlevel`=45, `maxlevel`=45, 
 `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (@MAZOGA);
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN (@JANGTHRAZE);

DELETE FROM `creature_text` WHERE `entry` IN (@MAZOGA) AND `id` BETWEEN 0 AND 3;

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,
`sound`,`comment`) VALUES
(@MAZOGA,0,0,"Behold! Sul'thraze the Lasher be rejoined!",12,0,100,0,0,0,""),
(@MAZOGA,1,0,"Enough'a dis...Chief Sandscalp can't reward me if I'm dead, yah? Farewell, mon...for good.",12,0,100,0,0,0,""),
(@MAZOGA,2,0,"Joke's on you, mon. I found Jang'thraze long ago. Had both of de halves...'til some wily one come and steal one away in de night.",12,0,100,0,0,0,""),
(@MAZOGA,3,0,"Now dat Sang'thraze is mine again, de only thing ya be findin' here...is ya own fresh grave.",12,0,100,0,0,0,"");

DELETE FROM `locales_creature_text` WHERE `entry` IN (@MAZOGA) AND `groupid` BETWEEN 0 AND 3;

INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,
`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES
(@MAZOGA,0,0,"","","","","","¡Mirad! ¡Sul'thraze la Azotadora se reincorpora!","¡Mirad! ¡Sul'thraze la Azotadora se reincorpora!",""),
(@MAZOGA,1,0,"","","","","","Suficiente de esto ... El Jefe Sandscalp no puede recompensarme si estoy muerto, ¿eh? Adiós, mon... para siempre.","Suficiente de esto ... El Jefe Sandscalp no puede recompensarme si estoy muerto, ¿eh? Adiós, mon... para siempre.",""),
(@MAZOGA,2,0,"","","","","","La broma cae en ti, mon. Encontré a Jang'thraze hace mucho tiempo. Tuve las dos mitades... hasta que algún astuto vino y robó uno en la noche.","La broma cae en ti, mon. Encontré a Jang'thraze hace mucho tiempo. Tuve las dos mitades... hasta que algún astuto vino y robó uno en la noche.",""),
(@MAZOGA,3,0,"","","","","","Ahora que Sang'thraze es mía otra vez, la única cosa que puedes encontrar aquí... es tu propia tumba fresca.","Ahora que Sang'thraze es mía otra vez, la única cosa que puedes encontrar aquí... es tu propia tumba fresca.","");

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@MAZOGA) AND `source_type` IN (0);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@JANGTHRAZE) AND `source_type` IN (1);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Object Jang'thraze the Protector
(@JANGTHRAZE,1,0,0,64,0,100,1,0,0,0,0,12,@MAZOGA,8,0,0,0,0,8,0,0,0,-7435.89,-2880.44,8.79,3.28,"GOSSIP HELLO - SUMMON CREATURE - POSITION"),
-- Mazoga
(@MAZOGA,0,0,1,63,0,100,0,0,0,0,0,42,5,5,0,0,0,0,1,0,0,0,0,0,0,0,"JUST CREATED - SET INVINCIBILITY HP LEVEL - SELF"),
(@MAZOGA,0,1,2,61,0,100,0,0,0,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - SET UNIT FLAG - SELF"),
(@MAZOGA,0,2,0,61,0,100,0,0,0,0,0,1,2,6000,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - TALK - SELF"),
(@MAZOGA,0,3,0,52,0,100,0,2,0,0,0,1,3,6000,0,0,0,0,1,0,0,0,0,0,0,0,"TEXT OVER - TALK - SELF"),
(@MAZOGA,0,4,0,52,0,100,0,3,0,0,0,1,0,6000,0,0,0,0,1,0,0,0,0,0,0,0,"TEXT OVER - TALK - SELF"),
(@MAZOGA,0,5,6,52,0,100,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"TEXT OVER - REMOVE UNIT FLAG - SELF"),
(@MAZOGA,0,6,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,18,20,0,0,0,0,0,0,"LINK - ATTACK START - PLAYER DISTANCE"),
(@MAZOGA,0,7,8,2,0,100,1,0,10,0,0,18,768,0,0,0,0,0,1,0,0,0,0,0,0,0,"HEALT PCT - SET UNIT FLAG - SELF"),
(@MAZOGA,0,8,9,61,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - SET FACTION - SELF"),
(@MAZOGA,0,9,10,61,0,100,0,0,0,0,0,1,1,8000,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - TALK - SELF"),
(@MAZOGA,0,10,0,61,0,100,0,0,0,0,0,33,@CREDIT,0,0,0,0,0,24/*18*/,0,0,0,0,0,0,0,"LINK - CALL KILLEDMONSTER - THREAT LIST"),
(@MAZOGA,0,11,0,52,0,100,0,1,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"TEXT OVER - FORCE DESPAWN - SELF");

DELETE FROM `creature` WHERE `id` IN (@MAZOGA);

/* MAZOGA borrado
333248	38968	1	0	0	1	1	31217	1	-7435.9	-2880.45	8.79371	3.28122	300	0	0	3696	0	0	0	0	0
*/