-- Lessons From the Past (27541)
-- By Fearz & Stevej

SET @Schnottz:=45874; # Id del npc que te da la mision
SET @Quest:=27541; # Mision a tomar
SET @Gossip:=12058; # Menu que tiene el npc
SET @Spell_journal:=85796; # Spell para crear el libro
SET @Spell_broken:=85798; # Spell para crear los anteojos

UPDATE `creature_template` SET `ScriptName`='', `AIName`='SmartAI' WHERE `entry` IN (@Schnottz);

UPDATE `gossip_menu_option` SET `option_id`=1, `npc_option_npcflag`=1 WHERE `menu_id` IN (@Gossip);

UPDATE `quest_template` SET `SourceItemId`=0, `SourceItemCount`=0 WHERE `id` IN (@Quest);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@Schnottz) AND `source_type` IN (0);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@Schnottz,0,0,1,62,0,100,0,@Gossip,0,0,0,85,@Spell_journal,2,0,0,0,0,7,0,0,0,0,0,0,0,'Evento 62 gossip id 0 cast Spell_journal al ACTION_INVOKER'),
(@Schnottz,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Evento 62 gossip id 0 close gossip'),
(@Schnottz,0,2,3,62,0,100,0,@Gossip,1,0,0,85,@Spell_broken,2,0,0,0,0,7,0,0,0,0,0,0,0,'Evento 62 gossip id 1 cast spell Spell_broken al ACTION_INVOKER'),
(@Schnottz,0,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Evento 62 gossip id 1 close gossip');

DELETE FROM `conditions` WHERE `SourceGroup` IN (@Gossip) AND `SourceTypeOrReferenceId` IN (15);

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, 
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, 
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,@Gossip,0,0,0,9,0,@Quest,0,0,0,0,0,'','Le muestra el menu 0 si tiene tomada la quest'),
(15,@Gossip,1,0,0,9,0,@Quest,0,0,0,0,0,'','Le muestra el menu 1 si tiene tomada la quest');

-- 85559/cancel-mod-aura-vision
-- 85548/mod-aura-vision-scouts-journal