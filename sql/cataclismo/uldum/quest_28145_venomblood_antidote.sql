-- Venomblood Antidote (28145)
-- By Fearz & Stevej

SET @QUEST:=28145; -- id de la quest
SET @SPELL:=88882; -- spell del item
SET @SCORPID:=45859; -- npc al que se le utiliza el spell
SET @THUNDERSTOMP:=63900; -- Pisotón de trueno
SET @DRAINED:=47750; -- npc que deberia aparecer al utilizar el spell

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (@SCORPID);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@SCORPID) AND `source_type` IN (0);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@SCORPID,0,0,0,9,0,100,0,0,5,12000,15000,11,@THUNDERSTOMP,0,0,0,0,0,1,0,0,0,0,0,0,0,'RANGE - CAST THUNDERSTOMP - SELF'),
(@SCORPID,0,1,2,8,0,100,0,@SPELL,0,0,0,3,@DRAINED,0,0,0,0,0,1,0,0,0,0,0,0,0,'SPELLHIT - MORPH TO ENTRY OR MODEL - SELF'),
(@SCORPID,0,2,0,61,0,100,0,0,0,0,0,41,2000,0,0,0,0,0,1,0,0,0,0,0,0,0,'LINK - FORCE DESPAWN 2s - SELF');

DELETE FROM `conditions` WHERE `SourceEntry`=@SPELL AND `SourceTypeOrReferenceId`=17;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, 
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, 
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,@SPELL,0,0,36,1,0,0,0,1,0,0,'','El spell solo puede utilizarse si el npc esta muerto'),
(17,0,@SPELL,0,0,31,1,3,@SCORPID,0,0,0,0,'','El spell solo puede utilizarse sobre el target SCORPID'),
(17,0,@SPELL,0,0,9,0,@QUEST,0,0,0,0,0,'','El spell solo puede utilizarse si tenemos la quest tomada e incompleta');

DELETE FROM creature WHERE id IN (@DRAINED);

/*
SELECT * FROM creature WHERE id IN (@DRAINED);
INSERT INTO creature  VALUES
(330729,@DRAINED,1,0,0,1,1,3247,0,-8982.85,-634.25,150.23,2.56,300,3,0,53681,0,1,0,0,0),
(330730,@DRAINED,1,0,0,1,1,3247,0,-9080.08,-783.7,143.77,6.11,300,3,0,53681,0,1,0,0,0),
(330731,@DRAINED,1,0,0,1,1,3247,0,-9051.83,-709.66,147.93,2.83,300,3,0,53681,0,1,0,0,0),
(330732,@DRAINED,1,0,0,1,1,3247,0,-8910.23,-696.46,163.73,2.4,300,3,0,53681,0,1,0,0,0);
*/