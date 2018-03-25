SET @HAZZALI:=39081; -- Hazzali Cocoon
SET @GOBLIN:=39082; -- Captured Goblin Bughunter
SET @SPELL_SUMMON:=73441; -- Summon Captured Bughunter

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (@HAZZALI, @GOBLIN);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@HAZZALI, @GOBLIN) AND `source_type` IN (0);

INSERT INTO smart_scripts (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HAZZALI,0,0,0,6,0,100,1,0,0,0,0,11,@SPELL_SUMMON,3,0,0,0,0,1,0,0,0,0,0,0,0,'EVENT DEATH - CAST SUMMON - SELF'),
(@HAZZALI,0,1,0,25,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'EVENT RESET - ROOT - SELF'),
(@GOBLIN,0,0,1,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'EVENT JUST SUMMONED - TALK - SELF'),
(@GOBLIN,0,1,0,61,0,100,0,0,0,0,0,41,4000,0,0,0,0,0,1,0,0,0,0,0,0,0,'EVENT LINK - FORCE DESPAWN 4s - SELF');

DELETE FROM `creature_text` WHERE `entry` IN (@GOBLIN) AND `groupid` IN (0);

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,
`sound`,`comment`) VALUES
(@GOBLIN,0,0,"Hey! Those bugs took my watch!",12,0,100,0,0,0,"GOBLIN SAY 1"),
(@GOBLIN,0,1,"I can breathe!",12,0,100,0,0,0,"GOBLIN SAY 2"),
(@GOBLIN,0,2,"I'm alive!",12,0,100,0,0,0,"GOBLIN SAY 3"),
(@GOBLIN,0,3,"Thanks a ton, pal!",12,0,100,0,0,0,"GOBLIN SAY 4"),
(@GOBLIN,0,4,"What day is it?",12,0,100,0,0,0,"GOBLIN SAY 5");

DELETE FROM `locales_creature_text` WHERE `entry` IN (@GOBLIN) AND `groupid` IN (0);

INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,
`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES
(@GOBLIN,0,1,"","","","","","¡Oye! ¡Esos insectos tomaron mi reloj!","¡Oye! ¡Esos insectos tomaron mi reloj!",""),
(@GOBLIN,0,2,"","","","","","¡Puedo respirar!","¡Puedo respirar!",""),
(@GOBLIN,0,3,"","","","","","¡Estoy vivo!","¡Estoy vivo!",""),
(@GOBLIN,0,4,"","","","","","Muchas gracias, amigo!","Muchas gracias, amigo!",""),
(@GOBLIN,0,5,"","","","","","¿Qué día es?","¿Qué día es?","");

-- Criaturas que no deberían estar, porque son sumoneadas por el spell.
DELETE FROM `creature` WHERE `id` IN (@GOBLIN);
-- Alguna trampas superpuestas
DELETE FROM `creature` WHERE `guid` IN (73039, 104465, 72860, 87233, 104940, 73658, 104737) AND `id` IN (@HAZZALI);

/*
guid	id	map	zone	area	spawnMask	phaseMask	modelid	equipment_id	position_x	position_y	position_z	orientation	spawntimesecs	spawndist	currentwaypoint	curhealth	curmana	MovementType	npcflag	unit_flags	dynamicflags
333249	39082	1	0	0	1	1	31331	1	-8820.79	-4009.38	12.8727	0	300	3	0	1990	0	1	0	0	0
333250	39082	1	0	0	1	1	31331	1	-8845.88	-4047.04	14.4215	0	300	3	0	1990	0	1	0	0	0
333251	39082	1	0	0	1	1	31331	1	-8793.33	-4048	15.6413	0	300	3	0	1990	0	1	0	0	0
333252	39082	1	0	0	1	1	31331	1	-8713.12	-3985.32	15.1731	0	300	3	0	1990	0	1	0	0	0
333253	39082	1	0	0	1	1	31331	1	-8750.26	-3948.41	14.4099	0	300	3	0	1990	0	1	0	0	0
333254	39082	1	0	0	1	1	31331	1	-8847.84	-3881.61	13.5206	0	300	3	0	1990	0	1	0	0	0
333255	39082	1	0	0	1	1	31331	1	-8908.06	-3887.11	15.0711	0	300	3	0	1990	0	1	0	0	0
333256	39082	1	0	0	1	1	31331	1	-8890.93	-3917.78	15.3432	0	300	3	0	1990	0	1	0	0	0
333259	39082	1	0	0	1	1	31331	1	-8923.9	-3991.7	14.2992	0	300	3	0	1990	0	1	0	0	0
*/


/*
guid	id	map	zone	area	spawnMask	phaseMask	modelid	equipment_id	position_x	position_y	position_z	orientation	spawntimesecs	spawndist	currentwaypoint	curhealth	curmana	MovementType	npcflag	unit_flags	dynamicflags
72860	39081	1	0	0	1	1	16213	0	-8992.34	-3846.16	15.7584	0	90	0	0	185	0	0	0	0	0
73039	39081	1	0	0	1	1	16213	0	-9052.02	-3859.67	12.5513	0	90	0	0	185	0	0	0	0	0
73658	39081	1	0	0	1	1	16213	0	-8793.33	-4048	15.558	0	90	0	0	185	0	0	0	0	0
87233	39081	1	0	0	1	1	16213	0	-8891.63	-4125.2	15.654	0	90	0	0	185	0	0	0	0	0
104465	39081	1	0	0	1	1	16213	0	-9041.7	-3818.7	15.1254	0	90	0	0	185	0	0	0	0	0
104737	39081	1	0	0	1	1	16213	0	-8845.88	-4047.04	14.3381	0	90	0	0	185	0	0	0	0	0
104940	39081	1	0	0	1	1	16213	0	-8915.6	-4039.14	13.612	0	90	0	0	185	0	0	0	0	0
*/