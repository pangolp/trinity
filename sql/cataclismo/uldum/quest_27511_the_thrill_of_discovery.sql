-- The Thrill of Discovery (27511)
-- by Fearz & Stevej

SET @Quest:=27511; -- La emoción del descubrimiento

SET @AreaTriggerAncient:=6284; -- centro
SET @SpellKillCreditAncient:=85362;

SET @AreaTriggerSouthern:=6286; -- sur
SET @SpellKillCreditSouthern:=85364;

SET @AreaTriggerNorthern:=6287; -- Norte
SET @SpellKillCreditNorthern:=85366; 

-- Le borramos la flag de autocompletable.
UPDATE `quest_template` SET `Flags`=`Flags`&~65536 WHERE `id` IN (@Quest);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (@AreaTriggerAncient,@AreaTriggerSouthern,@AreaTriggerNorthern);

INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(@AreaTriggerAncient,'SmartTrigger'),
(@AreaTriggerSouthern, 'SmartTrigger'),
(@AreaTriggerNorthern, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@AreaTriggerAncient,@AreaTriggerSouthern,@AreaTriggerNorthern) 
AND `source_type` IN (2);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@AreaTriggerAncient,2,0,0,46,0,100,0,@AreaTriggerAncient,0,0,0,85,@SpellKillCreditAncient,2,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion central'),
(@AreaTriggerSouthern,2,0,0,46,0,100,0,@AreaTriggerSouthern,0,0,0,85,@SpellKillCreditSouthern,2,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion sur'),
(@AreaTriggerNorthern,2,0,0,46,0,100,0,@AreaTriggerNorthern,0,0,0,85,@SpellKillCreditNorthern,2,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion norte');


/* 

SET @Floor_Kill_Credit:=45757;
SET @Southern_Kill_Credit:=45759;
SET @Northern_Kill_Credit:=45760;

INSERT INTO smart_scripts VALUES
(@AreaTriggerAncient,2,0,0,46,0,100,0,@AreaTriggerAncient,0,0,0,33,@Floor_Kill_Credit,0,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion central'),
(@AreaTriggerSouthern,2,0,0,46,0,100,0,@AreaTriggerSouthern,0,0,0,33,@Southern_Kill_Credit,0,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion sur'),
(@AreaTriggerNorthern,2,0,0,46,0,100,0,@AreaTriggerNorthern,0,0,0,33,@Northern_Kill_Credit,0,0,0,0,0,7,0,0,0,0,0,0,0,'Al entrar al area, completa exploracion norte');

*/