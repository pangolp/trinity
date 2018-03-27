-- Fashionism (27941)
-- by Fearz & Stevej
-- date: 07/06/2017

-- http://www.wowhead.com/quest=27941/fashionism
-- http://es.wowhead.com/quest=27941/moda-uniforme
-- http://www.wowhead.com/spell=87983/dead-trooper-transform-01
-- http://www.wowhead.com/spell=87984/dead-trooper-transform-02
-- http://www.wowhead.com/spell=87986/dead-trooper-transform-03
-- http://www.wowhead.com/spell=87987/dead-trooper-transform-04
-- http://www.wowhead.com/spell=88068/create-uniform

-- Dead Trooper - ID: 47216
-- Dead Trooper - ID: 47213
-- Dead Trooper - ID: 47219
-- Dead Trooper - ID: 47207

SET @Quest:=27941; -- Mision
SET @AuraMochilla:=85500;
SET @TrooperUniform:=62789; -- Uniforme de soldado
SET @DeadTrooperOne:=47207; -- Soldado muerto 1
SET @DeadTrooperTwo:=47213; -- Soldado muerto 2
SET @DeadTrooperThree:=47216; -- Soldado muerto 3
SET @DeadTrooperFour:=47219; -- Soldado muerto 4
SET @DeadTrooperTransformOne:=87983; -- Transformacion 1
SET @DeadTrooperTransformTwo:=87984; -- Transformacion 2
SET @DeadTrooperTransformThree:=87986; -- Transformacion 3
SET @DeadTrooperTransformFour:=87987; -- Transformacion 4
SET @NpcSpellClick:=16777216; -- Flag para que un npc tenga un spell click
SET @CreateUniform:=88068; -- Spell crear uniforme


UPDATE `quest_template` SET `RequiredItemId1`=@TrooperUniform, `RequiredItemCount1`=10 WHERE `Id` IN (@Quest);

UPDATE `creature_template` SET `maxlevel`=85, `exp`=3, `unit_flags`=537133056, `health_mod`=1 WHERE `entry` 
IN (@DeadTrooperOne, @DeadTrooperTwo, @DeadTrooperThree, @DeadTrooperFour);

UPDATE `creature_template` SET `ScriptName`='', AIName='SmartAI' WHERE `entry`
IN (@DeadTrooperOne, @DeadTrooperTwo, @DeadTrooperThree, @DeadTrooperFour);

UPDATE `creature_template` SET `npcflag`=`npcflag`|@NpcSpellClick WHERE `entry`
IN (@DeadTrooperOne, @DeadTrooperTwo, @DeadTrooperThree, @DeadTrooperFour);

DELETE FROM `smart_scripts` WHERE `entryorguid` 
IN (@DeadTrooperOne, @DeadTrooperTwo, @DeadTrooperThree, @DeadTrooperFour) AND `source_type` IN (0);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- NPC 1
(@DeadTrooperOne,0,0,1,73,0,100,0,0,0,0,0,85,@CreateUniform,2,0,0,0,0,7,0,0,0,0,0,0,0,"ON_SPELLCLICK - INVOKER_CAST - ACTION_INVOKER"),
(@DeadTrooperOne,0,1,2,61,0,100,0,0,0,0,0,28,@AuraMochilla,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVEAURASFROMSPELL - SELF"),
(@DeadTrooperOne,0,2,3,61,0,100,0,0,0,0,0,83,@NpcSpellClick,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVE_NPC_FLAG - SELF"),
(@DeadTrooperOne,0,3,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - FORCE_DESPAWN - SELF"),
-- NPC 2
(@DeadTrooperTwo,0,0,1,73,0,100,0,0,0,0,0,56,@TrooperUniform,1,0,0,0,0,7,0,0,0,0,0,0,0,"ON_SPELLCLICK - ADD_ITEM - ACTION_INVOKER"),
(@DeadTrooperTwo,0,1,2,61,0,100,0,0,0,0,0,28,@AuraMochilla,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVEAURASFROMSPELL - SELF"),
(@DeadTrooperTwo,0,2,3,61,0,100,0,0,0,0,0,83,@NpcSpellClick,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVE_NPC_FLAG - SELF"),
(@DeadTrooperTwo,0,3,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - FORCE_DESPAWN - SELF"),
-- NPC 3
(@DeadTrooperThree,0,0,1,73,0,100,0,0,0,0,0,56,@TrooperUniform,1,0,0,0,0,7,0,0,0,0,0,0,0,"ON_SPELLCLICK - ADD_ITEM - ACTION_INVOKER"),
(@DeadTrooperThree,0,1,2,61,0,100,0,0,0,0,0,28,@AuraMochilla,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVEAURASFROMSPELL - SELF"),
(@DeadTrooperThree,0,2,3,61,0,100,0,0,0,0,0,83,@NpcSpellClick,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVE_NPC_FLAG - SELF"),
(@DeadTrooperThree,0,3,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - FORCE_DESPAWN - SELF"),
-- NPC 4
(@DeadTrooperFour,0,0,1,73,0,100,0,0,0,0,0,56,@TrooperUniform,1,0,0,0,0,7,0,0,0,0,0,0,0,"ON_SPELLCLICK - ADD_ITEM - ACTION_INVOKER"),
(@DeadTrooperFour,0,1,2,61,0,100,0,0,0,0,0,28,@AuraMochilla,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVEAURASFROMSPELL - SELF"),
(@DeadTrooperFour,0,2,3,61,0,100,0,0,0,0,0,83,@NpcSpellClick,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - REMOVE_NPC_FLAG - SELF"),
(@DeadTrooperFour,0,3,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - FORCE_DESPAWN - SELF");


DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN 
(@DeadTrooperOne, @DeadTrooperTwo, @DeadTrooperThree, @DeadTrooperFour);

INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(@DeadTrooperOne,@DeadTrooperTransformOne,2,0),
(@DeadTrooperTwo,@DeadTrooperTransformTwo,2,0),
(@DeadTrooperThree,@DeadTrooperTransformThree,2,0),
(@DeadTrooperFour,@DeadTrooperTransformFour,2,0);

DELETE FROM `conditions` WHERE `SourceEntry` IN 
(@DeadTrooperTransformOne, @DeadTrooperTransformTwo, @DeadTrooperTransformThree, @DeadTrooperTransformFour) 
AND SourceTypeOrReferenceId IN (18);

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, 
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, 
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18,@DeadTrooperOne,@DeadTrooperTransformOne,0,0,9,0,@Quest,0,0,0,0,0,"","SPELL CLICK EVENT - QUESTTAKEN"),
(18,@DeadTrooperTwo,@DeadTrooperTransformTwo,0,0,9,0,@Quest,0,0,0,0,0,"","SPELL CLICK EVENT - QUESTTAKEN"),
(18,@DeadTrooperThree,@DeadTrooperTransformThree,0,0,9,0,@Quest,0,0,0,0,0,"","SPELL CLICK EVENT - QUESTTAKEN"),
(18,@DeadTrooperFour,@DeadTrooperTransformFour,0,0,9,0,@Quest,0,0,0,0,0,"","SPELL CLICK EVENT - QUESTTAKEN");