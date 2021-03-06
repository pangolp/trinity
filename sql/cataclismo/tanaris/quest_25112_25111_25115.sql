-- Butcherbot (25112)
-- Scavengers Scavenged (25111)
-- Blisterpaw Butchery (25115)
-- By Stevej & Fearz & Namek

SET @BUTCHERBOT:=39696;
SET @BUTCHERING:=74168; -- Spell Butcherbot butchering
SET @SPELL:=74175; -- Deploy butcherbot
SET @SUMMON:=74176; -- Summon butcherbot to corpse

-- QUEST 1
SET @BASILISK:=5419; -- npc Glasshide Basilisk
SET @BASILISK_CREDIT:=39702; -- Tanaris basilisk kill credit bunny
SET @QUEST1:=25112;

-- QUEST 2
SET @ROC:=5429; -- Fire Roc
SET @FIRE_CREDIT:=40507; -- Tanaris Fire Roc Kill Credit Bunny
SET @QUEST2:=25111;

-- QUEST 3
SET @HYENA:=5426; -- Blisterpaw Hyena
SET @HYENA_CREDIT:=40509; -- Hyena 01 Blisterpaw Kill Credit Bunny
SET @QUEST3:=25115;

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry` IN (@BUTCHERBOT, @BASILISK, @ROC, @HYENA);
UPDATE `creature_template` SET `speed_run`=1/*1.14286*/ WHERE `entry` IN (@BUTCHERBOT);

DELETE FROM `creature_text` WHERE `entry` IN (@BUTCHERBOT) AND `groupid` IN (0);

INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,
`sound`,`comment`) VALUES
(@BUTCHERBOT,0,0,"Chop chop chop!",12,0,100,0,0,0,"Butcherbot Say 1"),
(@BUTCHERBOT,0,1,"Hooray for meat! HIP HIP HOORAY!",12,0,100,0,0,0,"Butcherbot Say 2"),
(@BUTCHERBOT,0,2,"No part goes to waste! Yay!",12,0,100,0,0,0,"Butcherbot Say 3"),
(@BUTCHERBOT,0,3,"VWHHHHHRRRRRRRRRRRRRRRRHHHHHHMNNNGHHHGH",12,0,100,0,0,0,"Butcherbot Say 4"),
(@BUTCHERBOT,0,4,"Yaaaaaaaaaaaaaaaaaaaaaay!",12,0,100,0,0,0,"Butcherbot Say 5");

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BUTCHERBOT, @BASILISK, @ROC, @HYENA) AND `source_type` IN (0);

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,
`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,
`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@BUTCHERBOT,0,0,1,54,0,100,0,0,0,0,0,29,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"JUST SUMMONED - FOLLOW - ACTION INVOKER"),
(@BUTCHERBOT,0,1,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"LINK - TALK - SELF"),
(@BUTCHERBOT,0,2,0,1,0,100,1,4000,4000,0,0,11,@BUTCHERING,2,0,0,0,0,7,0,0,0,0,0,0,0,"UPDATE OOC - CAST - ACTION INVOKER"),

-- Glasshide Basilisk
(@BASILISK,0,0,0,0,0,100,0,4000,4500,15000,16000,11,5106,0,0,0,0,0,2,0,0,0,0,0,0,0,"UPDATE IC - CAST - VICTIM"),
(@BASILISK,0,1,2,8,0,100,1,@SPELL,0,0,0,11,@SUMMON,2,0,0,0,0,1,0,0,0,0,0,0,0,"SPELLHIT - CAST SUMMON - SELF"),
(@BASILISK,0,2,0,61,0,100,0,0,0,0,0,33,@BASILISK_CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,"LINK - CALL KILLEDMONSTER - ACTION INVOKER"),

-- Fire Roc
(@ROC,0,0,0,9,0,100,0,0,8,19000,22000,11,24423,0,0,0,0,0,1,0,0,0,0,0,0,0,"RANGE - CAST - SELF"),
(@ROC,0,1,0,0,0,100,0,6000,9000,15000,15500,11,11021,0,0,0,0,0,2,0,0,0,0,0,0,0,"UPDATE IC - CAST - VICTIM"),
(@ROC,0,2,3,8,0,100,1,@SPELL,0,0,0,11,@SUMMON,2,0,0,0,0,1,0,0,0,0,0,0,0,"SPELLHIT - CAST SUMMON - SELF"),
(@ROC,0,3,0,61,0,100,0,0,0,0,0,33,@FIRE_CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,"LINK - CALL KILLEDMONSTER - ACTION INVOKER"),

-- Blisterpaw Hyena
(@HYENA,0,0,0,9,0,100,0,0,9,15000,17800,11,82797,0,0,0,0,0,2,0,0,0,0,0,0,0,"RANGE - CAST - VICTIM"),
(@HYENA,0,1,2,8,0,100,1,@SPELL,0,0,0,11,@SUMMON,2,0,0,0,0,1,0,0,0,0,0,0,0,"SPELLHIT - CAST SUMMON - SELF"),
(@HYENA,0,2,0,61,0,100,0,0,0,0,0,33,@HYENA_CREDIT,0,0,0,0,0,7,0,0,0,0,0,0,0,"LINK - CALL KILLEDMONSTER - ACTION INVOKER");

DELETE FROM `conditions` WHERE `SourceEntry`=@SPELL AND `SourceTypeOrReferenceId`=17;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, 
`ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, 
`NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,@SPELL,0,0,36,1,0,0,0,1,0,0,'','El spell solo puede utilizarse si el npc esta muerto'),
(17,0,@SPELL,0,0,31,1,3,@BASILISK,0,0,0,0,'','El spell solo puede utilizarse sobre el target BASILISK'),
(17,0,@SPELL,0,0,9,0,@QUEST1,0,0,0,0,0,'','El spell solo puede utilizarse si tenemos la quest tomada e incompleta'),

(17,0,@SPELL,0,1,36,1,0,0,0,1,0,0,'','El spell solo puede utilizarse si el npc esta muerto'),
(17,0,@SPELL,0,1,31,1,3,@ROC,0,0,0,0,'','El spell solo puede utilizarse sobre el target ROC'),
(17,0,@SPELL,0,1,9,0,@QUEST2,0,0,0,0,0,'','El spell solo puede utilizarse si tenemos la quest tomada e incompleta'),

(17,0,@SPELL,0,2,36,1,0,0,0,1,0,0,'','El spell solo puede utilizarse si el npc esta muerto'),
(17,0,@SPELL,0,2,31,1,3,@HYENA,0,0,0,0,'','El spell solo puede utilizarse sobre el target HYENA'),
(17,0,@SPELL,0,2,9,0,@QUEST3,0,0,0,0,0,'','El spell solo puede utilizarse si tenemos la quest tomada e incompleta');


-- Borramos los ROC que tienen un model id diferente de 0.
DELETE FROM creature WHERE id IN (@ROC) AND modelid<>0;

-- Borramos los BASILISK que tienen un model id diferente de 0.
DELETE FROM creature WHERE id IN (@BASILISK) AND modelid<>0;

-- Borramos los HYENA que tienen un model id diferente de 0.
DELETE FROM creature WHERE id IN (@HYENA) AND modelid<>0;

-- No debería estar respawn.
DELETE FROM creature WHERE id IN (@BUTCHERBOT);

/* BUTCHERBOT BORRADO
331858	39696	1	0	0	1	1	1159	0	-7552.81	-3679.68	8.91688	4.55326	300	0	0	1848	0	0	0	0	0
*/



/*    BASILISK BORRADOS
72859	5419	1	0	0	1	1	7345	0	-6324.49	-2573.91	9.00178	4.41216	90	10	0	1848	0	1	0	0	0
72953	5419	1	0	0	1	1	7345	0	-7145.81	-3455.15	10.0695	2.02458	90	10	0	1848	0	1	0	0	0
72966	5419	1	0	0	1	1	7345	0	-7303.08	-3440.12	8.98825	0.942478	90	10	0	1848	0	1	0	0	0
72985	5419	1	0	0	1	1	7345	0	-7681.63	-3867.89	3.9595	4.70262	90	10	0	1782	0	1	0	0	0
72999	5419	1	0	0	1	1	7345	0	-7555.52	-3515.49	14.1658	6.16368	90	10	0	1782	0	1	0	0	0
73079	5419	1	0	0	1	1	7345	0	-6099.33	-2587.57	9.00179	1.80602	90	10	0	1782	0	1	0	0	0
73111	5419	1	0	0	1	1	7345	0	-7620.21	-3723.36	17.1588	1.6309	90	10	0	1848	0	1	0	0	0
73206	5419	1	0	0	1	1	7345	0	-6993.6	-3548.7	13.6284	4.06662	90	10	0	1782	0	1	0	0	0
73274	5419	1	0	0	1	1	7345	0	-7817.92	-3749.11	47.8699	4.6557	90	10	0	1782	0	1	0	0	0
73383	5419	1	0	0	1	1	7345	0	-6489.29	-2931.98	8.7134	1.52765	90	10	0	1782	0	1	0	0	0
73405	5419	1	0	0	1	1	7345	0	-8014.56	-3626.14	69.5126	4.97916	90	10	0	1848	0	1	0	0	0
73431	5419	1	0	0	1	1	7345	0	-7088.92	-3582.03	11.0812	1.69297	90	10	0	1782	0	1	0	0	0
73437	5419	1	0	0	1	1	7345	0	-7744.73	-3430.3	41.9385	2.04318	90	10	0	1848	0	1	0	0	0
73456	5419	1	0	0	1	1	7345	0	-6761.79	-2905.53	9.00176	2.89491	90	10	0	1782	0	1	0	0	0
73526	5419	1	0	0	1	1	7345	0	-7801.68	-3849.91	22.934	3.20216	90	10	0	1848	0	1	0	0	0
73546	5419	1	0	0	1	1	7345	0	-7635.7	-3547.78	20.2584	3.53443	90	10	0	1848	0	1	0	0	0
73639	5419	1	0	0	1	1	7345	0	-7178.8	-3553.6	9.99127	0.20944	90	10	0	1782	0	1	0	0	0
73652	5419	1	0	0	1	1	7345	0	-7681.74	-3694	32.1632	1.76743	90	10	0	1848	0	1	0	0	0
73719	5419	1	0	0	1	1	7345	0	-6141.28	-2908.82	22.399	2.72952	90	10	0	1782	0	1	0	0	0
73915	5419	1	0	0	1	1	7345	0	-6116.95	-2690.13	9.37089	2.04981	90	10	0	1782	0	1	0	0	0
73947	5419	1	0	0	1	1	7345	0	-7419.59	-3484.14	12.8445	4.28824	90	10	0	1782	0	1	0	0	0
87170	5419	1	0	0	1	1	7345	0	-6424.5	-2876.43	9.01583	0.283273	90	10	0	1848	0	1	0	0	0
87205	5419	1	0	0	1	1	7345	0	-6298.25	-2490.63	9.17325	3.6542	90	10	0	1848	0	1	0	0	0
87248	5419	1	0	0	1	1	7345	0	-6186.98	-2533.85	16.1125	2.52713	90	10	0	1848	0	1	0	0	0
87288	5419	1	0	0	1	1	7345	0	-7742.21	-3748.94	32.5663	2.98302	90	10	0	1848	0	1	0	0	0
87322	5419	1	0	0	1	1	7345	0	-6370.66	-2511.12	19.5018	1.53014	90	10	0	1782	0	1	0	0	0
87336	5419	1	0	0	1	1	7345	0	-6371.95	-2864.18	9.96473	5.94227	90	10	0	1782	0	1	0	0	0
104491	5419	1	0	0	1	1	7345	0	-7661.64	-3624.77	27.7805	2.87671	90	10	0	1782	0	1	0	0	0
104507	5419	1	0	0	1	1	7345	0	-7344.18	-3519.38	10.3624	5.55167	90	10	0	1848	0	1	0	0	0
104535	5419	1	0	0	1	1	7345	0	-7344.78	-3610.26	9.11427	0.998519	90	10	0	1848	0	1	0	0	0
104545	5419	1	0	0	1	1	7345	0	-7755.68	-3526.52	41.0728	-0.26539	90	10	0	0	0	1	0	0	0
104573	5419	1	0	0	1	1	7345	0	-7280.81	-3564.91	8.85048	4.74363	90	10	0	1782	0	1	0	0	0
104578	5419	1	0	0	1	1	7345	0	-6550.64	-2930.75	16.0678	5.7575	90	10	0	1782	0	1	0	0	0
104583	5419	1	0	0	1	1	7345	0	-7757.42	-3353.1	58.3133	1.63918	90	10	0	1782	0	1	0	0	0
104638	5419	1	0	0	1	1	7345	0	-6119.84	-2619.29	9.42181	2.18099	90	10	0	1848	0	1	0	0	0
104698	5419	1	0	0	1	1	7345	0	-7747.6	-3815.99	26.4631	3.09183	90	10	0	1848	0	1	0	0	0
104727	5419	1	0	0	1	1	7345	0	-6404.25	-2627.67	9.00178	0.830873	90	10	0	1782	0	1	0	0	0
104773	5419	1	0	0	1	1	7345	0	-6248.88	-2731.86	53.5915	1.37211	90	10	0	1782	0	1	0	0	0
104776	5419	1	0	0	1	1	7345	0	-7848.29	-3487.37	65.561	0.020699	90	10	0	0	0	1	0	0	0
104888	5419	1	0	0	1	1	7345	0	-7811.87	-3810.1	36.5554	0.195812	90	10	0	1848	0	1	0	0	0
105051	5419	1	0	0	1	1	7345	0	-6729.98	-2907.21	9.12721	3.07145	90	10	0	1782	0	1	0	0	0
105098	5419	1	0	0	1	1	7345	0	-7082.32	-3450.5	10.9401	0.575959	90	10	0	1782	0	1	0	0	0
*/

/*  HYENA BORRADOS
72844	5426	1	0	0	1	1	1536	0	-7046.35	-3422.15	9.21897	3.13434	90	10	0	1782	0	1	0	0	0
72900	5426	1	0	0	1	1	1536	0	-6994.61	-3545.88	13.4651	5.05776	90	10	0	1782	0	1	0	0	0
72976	5426	1	0	0	1	1	1536	0	-7086.81	-3584.16	10.968	2.35202	90	10	0	1848	0	1	0	0	0
73068	5426	1	0	0	1	1	1536	0	-7066.01	-3531.79	11.0243	1.81599	90	10	0	1782	0	1	0	0	0
73092	5426	1	0	0	1	1	1536	0	-7179.82	-3550.79	10.3322	5.05694	90	10	0	1782	0	1	0	0	0
73433	5426	1	0	0	1	1	1536	0	-7073.41	-3393.06	10.1393	2.31496	90	10	0	1848	0	1	0	0	0
73527	5426	1	0	0	1	1	1536	0	-7320.92	-3380.93	9.81281	5.07763	90	10	0	1848	0	1	0	0	0
73899	5426	1	0	0	1	1	1536	0	-7147.86	-3380.59	9.8567	5.12839	90	10	0	1848	0	1	0	0	0
73938	5426	1	0	0	1	1	1536	0	-7214.12	-3370.64	9.91913	0.964465	90	10	0	1848	0	1	0	0	0
73971	5426	1	0	0	1	1	1536	0	-7005.82	-3497.41	9.27319	3.35035	90	10	0	1782	0	1	0	0	0
87147	5426	1	0	0	1	1	1536	0	-7054.21	-3473.16	10.6745	0.856288	90	10	0	1782	0	1	0	0	0
87175	5426	1	0	0	1	1	1536	0	-7263.53	-3389.39	9.93518	2.64771	90	10	0	1782	0	1	0	0	0
87228	5426	1	0	0	1	1	1536	0	-7116.05	-3417.35	11.9347	0.242596	90	10	0	1782	0	1	0	0	0
87249	5426	1	0	0	1	1	1536	0	-7115.02	-3552.03	11.6939	6.18387	90	10	0	1782	0	1	0	0	0
87299	5426	1	0	0	1	1	1536	0	-7116.6	-3483.79	9.36121	2.74607	90	10	0	1782	0	1	0	0	0
104401	5426	1	0	0	1	1	1536	0	-7305.25	-3438.06	9.14403	5.52297	90	10	0	1782	0	1	0	0	0
104455	5426	1	0	0	1	1	1536	0	-7028.9	-3603.35	11.3429	4.36291	90	10	0	1848	0	1	0	0	0
104457	5426	1	0	0	1	1	1536	0	-7219.21	-3514.17	10.6647	1.17801	90	10	0	1848	0	1	0	0	0
104463	5426	1	0	0	1	1	1536	0	-6976.12	-3377.86	11.1064	6.22905	90	10	0	1848	0	1	0	0	0
104495	5426	1	0	0	1	1	1536	0	-7257.93	-3344.54	9.84177	1.35795	90	10	0	1848	0	1	0	0	0
104558	5426	1	0	0	1	1	1536	0	-7180.5	-3417.78	11.738	1.23016	90	10	0	1848	0	1	0	0	0
104700	5426	1	0	0	1	1	1536	0	-7158.73	-3513.96	10.7034	2.88843	90	10	0	1848	0	1	0	0	0
104807	5426	1	0	0	1	1	1536	0	-7549.6	-3382.68	32.3183	6.17587	90	10	0	1782	0	1	0	0	0
104830	5426	1	0	0	1	1	1536	0	-7271.95	-3491.53	9.65494	5.36714	90	10	0	1782	0	1	0	0	0
104839	5426	1	0	0	1	1	1536	0	-7142.59	-3320.25	14.3532	6.04868	90	10	0	1848	0	1	0	0	0
104893	5426	1	0	0	1	1	1536	0	-6992.55	-3440.96	9.66536	1.45734	90	10	0	1848	0	1	0	0	0
104922	5426	1	0	0	1	1	1536	0	-7080.03	-3448.6	11.4245	3.83429	90	10	0	1848	0	1	0	0	0
104958	5426	1	0	0	1	1	1536	0	-7357.04	-3416.33	14.924	3.9695	90	10	0	1782	0	1	0	0	0
105002	5426	1	0	0	1	1	1536	0	-7147.05	-3452.43	10.2463	5.13936	90	10	0	1848	0	1	0	0	0
*/