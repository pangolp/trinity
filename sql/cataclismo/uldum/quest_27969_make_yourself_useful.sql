-- Make yourself useful (27969)
-- By Fearz & Stevej

SET @QUEST:=27969; -- Make yourself useful
SET @LABORER:=47292; -- Slacking laborer
SET @Spell:=88236; -- Refurbished trooper uniform
SET @GOSSIP:=12238;
SET @CREDIT:=88241; -- Spell Kill Credit

UPDATE `creature_template` SET `exp`=3, `faction_A`=2348, `faction_H`=2348, `mingold`=0, 
`maxgold`=0, `health_mod`=1 WHERE `entry` IN (47291, @LABORER);

UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI', `gossip_menu_id`=@GOSSIP WHERE `entry` IN (@LABORER);

UPDATE `gossip_menu_option` SET `option_id`=1, `npc_option_npcflag`=1 WHERE `menu_id` IN (@GOSSIP);

DELETE FROM `creature_text` WHERE `entry` IN (@LABORER) AND `groupid` IN (0, 1);

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,
`sound`,`comment`) VALUES
(@LABORER,0,0,"I should never have left Tanaris.",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,0,1,"I didn't sign up for this.",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,0,2,"Yeah, yeah. When aren't we behind schedule?",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,1,0,"I haven't been paid since I got here! I'm through with this place!",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,1,1,"I can't believe I fell for Schnottz lies! I'm out of here!",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,1,2,"I have a message for you to deliver to that tyrant!",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,1,3,"I'm not working for that maniac anymore!",12,0,100,1,0,0,'DIALOG slacking laborer'),
(@LABORER,1,4,"I'm done working in this heat!",12,0,100,1,0,0,'DIALOG slacking laborer');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@LABORER) AND `source_type` IN (0);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@LABORER*100+0, @LABORER*100+1) AND `source_type` IN (9);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@LABORER,0,0,0,4,0,100,0,0,0,0,0,11,14890,0,0,0,0,0,2,0,0,0,0,0,0,0,"AGGRO - CAST 14890 - VICTIM"),
(@LABORER,0,1,2,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"GOSSIP SELECT - CLOSE GOSSIP - ACTION INVOKER"),
(@LABORER,0,2,0,61,0,100,0,0,0,0,0,88,@LABORER*100+0,@LABORER*100+1,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - CALL RANDOM RANGE TIMED ACTIONLIST - SELF"),
-- LISTA 1
(@LABORER*100+0,9,0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"EVENT NONE - TALK - SELF"),
(@LABORER*100+0,9,1,0,0,0,100,0,0,0,0,0,85,@CREDIT,2,0,0,0,0,0,0,0,0,0,0,0,0,"EVENT NONE - CAST - NONE"),
-- LISTA 2
(@LABORER*100+1,9,0,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"EVENT NONE - TALK - SELF"),
(@LABORER*100+1,9,1,0,0,0,100,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,"EVENT NONE - SET FACTION - SELF"),
(@LABORER*100+1,9,2,0,0,0,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"EVENT NONE - ATTACK START - ACTION INVOKER");

DELETE FROM `locales_creature_text` WHERE `entry` IN (@LABORER) AND `groupid` IN (0, 1);

INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,
`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES
(@LABORER,0,0,"","","","","","Nunca debería haber dejado Tanaris","Nunca debería haber dejado Tanaris",""),
(@LABORER,0,1,"","","","","","No me inscribí para esto","No me inscribí para esto",""),
(@LABORER,0,2,"","","","","","Sí, sí. ¿Cuándo no estamos retrasados?","Sí, sí. ¿Cuándo no estamos retrasados?",""),
(@LABORER,1,0,"","","","","","¡No me pagaron desde que llegué aquí! ¡Estoy harto de este lugar!","¡No me pagaron desde que llegué aquí! ¡Estoy harto de este lugar!",""),
(@LABORER,1,1,"","","","","","¡No puedo creer que me haya enamorado de las mentiras de Schnottz! ¡Me voy de aquí!","¡No puedo creer que me haya enamorado de las mentiras de Schnottz! ¡Me voy de aquí!",""),
(@LABORER,1,2,"","","","","","¡Tengo un mensaje para que le entregues a ese tirano!","¡Tengo un mensaje para que le entregues a ese tirano!",""),
(@LABORER,1,3,"","","","","","¡Ya no trabajo para ese loco!","¡Ya no trabajo para ese loco!",""),
(@LABORER,1,4,"","","","","","¡He terminado de trabajar en este calor!","¡He terminado de trabajar en este calor!","");

DELETE FROM `conditions` WHERE `SourceGroup`=@GOSSIP AND `SourceTypeOrReferenceId` IN (15);

# Te muestra el gossip solo si tenes tomada la quest y no la terminaste.
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, 
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, 
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@GOSSIP,0,0,0,9,0,@QUEST,0,0,0,0,0,'','GOSSIP MENU OPTION - QUESTTAKEN');