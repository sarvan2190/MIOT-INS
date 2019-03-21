Step 1: 

run the remove command in Mongo DB
==================================
db.referencevalues.remove({domaincode :{$in:["DGFORM", "ROUTE", "ESSNDG", "FOLDTY", "TITLE", "NATNTY", "BLDGRP", "RHFACT", "PRFLAN", "OCCUPN", "NOKTYP", "NOKTYP", 
"ALSTYP", "IDTYPE", "RACE", "MARTST", "RELGON", "ADRTYP", "VSTTYP", "BOKMOD", "REFTYP", "PROVIDERTYPE", "TRNSMD", "CANRSN", 
"TRNSPT", "PATST", "SPCMTY", "COLMTD", "MEMRPT", "DLVYMD", "BODYSI", "BODYSI", "ABCANL", "VENANL", 
"CCTYPE", "PAYMOD", "CURNCY", "ARCATY", "TARIFF", "CRDTRM", "INVUOM", "ORDPRY", "INSTYP", "RESGRP", "PATTYP", "NATNTY", 
"TRNSMD", "BEDCAT", "VIPTYP", "PDOCTY", "REFTYP", "REFTYP","DGTAKE", "REFSTS", "REFREASON", 
"REFEVATYP", "REFERRERTYP", "EMPSTS", "VSTPRY", "FLDSTS", "BOKSTS", "OBSUOM", "PRDCAT", 
"LOCTYP","CODISC","FLDRQP","CONTYP","ERDTYP","PATSTS","INFTYP","ERDTYP","SRCTY","NRCDRG","ALRTYP","PYRTYP","DCODTY","AGEGRP"]}})

db.referencedomains.remove({code :{$in:["DGFORM", "ROUTE", "ESSNDG", "FOLDTY", "TITLE", "NATNTY", "BLDGRP", "RHFACT", "PRFLAN", "OCCUPN", "NOKTYP", "NOKTYP", 
"ALSTYP", "IDTYPE", "RACE", "MARTST", "RELGON", "ADRTYP", "VSTTYP", "BOKMOD", "REFTYP", "PROVIDERTYPE", "TRNSMD", "CANRSN", 
"TRNSPT", "PATST", "SPCMTY", "COLMTD", "MEMRPT", "DLVYMD", "BODYSI", "BODYSI", "ABCANL", "VENANL", 
"CCTYPE", "PAYMOD", "CURNCY", "ARCATY", "TARIFF", "CRDTRM", "INVUOM", "ORDPRY", "INSTYP", "RESGRP", "PATTYP", "NATNTY", 
"TRNSMD", "BEDCAT", "VIPTYP", "PDOCTY", "REFTYP", "REFTYP","DGTAKE", "REFSTS", "REFREASON", 
"REFEVATYP", "REFERRERTYP", "EMPSTS", "VSTPRY", "FLDSTS", "BOKSTS", "OBSUOM", "PRDCAT", 
"LOCTYP","CODISC","FLDRQP","CONTYP","ERDTYP","PATSTS","INFTYP","ERDTYP","SRCTY","NRCDRG","ALRTYP","PYRTYP","DCODTY","AGEGRP"]}})

Step2:

Step 2
======

Run all the DML queries before starting the migration scripts

update referencevalue set AlternateName ='LAB' WHERE numericvalue =1  and domaincode ='ORDCT'
update referencevalue set AlternateName ='RADIOLOGY' WHERE numericvalue =2 and domaincode ='ORDCT'
update referencevalue set AlternateName ='MEDICINE' WHERE numericvalue =3 and domaincode ='ORDCT'
update referencevalue set AlternateName ='SUPPLY' WHERE numericvalue =4 and domaincode ='ORDCT'
update referencevalue set AlternateName ='OTHERS' WHERE numericvalue =15 and domaincode ='ORDCT'
update referencevalue set AlternateName ='ROOMRENT' WHERE  domaincode ='ORDCT' AND VALUECODE='MIORD74'
update referencevalue set AlternateName ='DOCTORFEE' WHERE  domaincode ='ORDCT' AND VALUECODE='MIORD16'
update referencevalue set AlternateName ='DIET' WHERE  domaincode ='ORDCT' AND VALUECODE='DIET'
update referencevalue set AlternateName ='OTHERS' WHERE  domaincode ='ORDCT' and AlternateName is null
 
update referencevalue set ALTERNATENAME='TEXTUAL' WHERE DOMAINCODE='RVTYP' AND VALUECODE='TXTRS'
update referencevalue set ALTERNATENAME='REFERENCEVALUE' WHERE DOMAINCODE='RVTYP' AND VALUECODE='REFVL'
update referencevalue set ALTERNATENAME='ORGANISM' WHERE DOMAINCODE='RVTYP' AND VALUECODE='ORN'
update referencevalue set ALTERNATENAME='NUMERIC' WHERE DOMAINCODE='RVTYP' AND VALUECODE='NUMRC'
update referencevalue set ALTERNATENAME='ATTACHMENT' WHERE DOMAINCODE='RVTYP' AND VALUECODE='IMGRS'
update referencevalue set ALTERNATENAME='FREETEXT' WHERE DOMAINCODE='RVTYP' AND VALUECODE='FTF'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL1'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'
update referencevalue set ALTERNATENAME='NUTRITION' WHERE DOMAINCODE='RVTYP' AND VALUECODE='FDINGT'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'

SELECT * FROM BILLABLEITEM WHERE BSMDDUID IN(1410,1642,4358,1164,4466,1646,1163)
ALTER TABLE FREQUENCYDEFINITION ADD TYPE NVARCHAR(20)
UPDATE FREQUENCYDEFINITION SET TYPE = 'PRN' WHERE FREQTPUID='68003'
UPDATE FREQUENCYDEFINITION SET TYPE = 'STAT' WHERE FREQTPUID='68024'
UPDATE FREQUENCYDEFINITION SET TYPE = 'SPECIFIC DAY OF WEEK' WHERE FREQTPUID='68004'
UPDATE FREQUENCYDEFINITION SET TYPE = 'APPROX TIME' WHERE FREQTPUID='70232'
--UPDATE FREQUENCYDEFINITION SET TYPE = 'REPEAT EVERY' WHERE FREQTPUID='68024'
UPDATE FREQUENCYDEFINITION SET TYPE = 'EXACT TIME' WHERE FREQTPUID='68002'
UPDATE FREQUENCYDEFINITION SET TYPE = 'HOURS INTERVAL' WHERE FREQTPUID='68005'

UPDATE HealthOrganisation SET NAME ='MIOT HOSPITAL -CORPORATE' ,StatusFlag='A' ,ParentHealthOrganisationUID=1, guid ='569794170946a3d0d588efe6' where uid=2;
--EDTA Container Reference must be loaded into reference tables
SET IDENTITY_INSERT dbo.REFERENCEVALUE ON;  
INSERT INTO REFERENCEVALUE( UID,ValueCode,Description,ReferenceDomainUID,DisplayOrder,ActiveFrom,CUser,CWhen,MUser,MWhen,StatusFlag,OwnerOrganisationUID,DomainCode,guid)values 
(1,'01','EDTA Container',	228,1,'2010-11-01 00:00:00.000',1,'2010-11-01 20:37:00.207',1,'2010-11-01 20:37:00.207','A',0,'CONTP','5c7a7fd25d836f29be403fa8')
INSERT INTO REFERENCEVALUE(uid, ValueCode,Description,ReferenceDomainUID,DisplayOrder,ActiveFrom,CUser,CWhen,MUser,MWhen,StatusFlag,OwnerOrganisationUID,DomainCode,guid)values 
(2,'plasma','citrate plasma',	228,1,'2010-11-01 00:00:00.000',1,'2010-11-01 20:37:00.207',1,'2010-11-01 20:37:00.207','A',0,'CONTP','5c7a7fd25d836f29be403fad')
INSERT INTO REFERENCEVALUE(uid, ValueCode,Description,ReferenceDomainUID,DisplayOrder,ActiveFrom,CUser,CWhen,MUser,MWhen,StatusFlag,OwnerOrganisationUID,DomainCode,guid)values 
(3,'01','EDTA Container',	228,1,'2010-11-01 00:00:00.000',1,'2010-11-01 20:37:00.207',1,'2010-11-01 20:37:00.207','A',0,'CONTP','5c7a7fd25d836f29be403fb2')

--storebin default mappings guid
UPDATE StoreBin SET GUID ='5c41483f7a1964135201fba3' WHERE UID=1;
UPDATE StoreBin SET GUID ='5c41485d78f12e13405a13fd' WHERE UID=2;
UPDATE StoreBin SET GUID ='5c414b330600031319f7a769' WHERE UID=3;
UPDATE StoreBin SET GUID ='5c414bb87a1964135201fbbd' WHERE UID=4;
--Drug generic master guid mappings
update DRUGGENERICMASTER set guid='5c6e97f0dc3b807a9e55a2aa' where uid=1;

update referencevalue set guid ='569ce2b8aff90071f0952af6' where uid=55630;
update referencevalue set guid ='569ce2b8aff90071f0952af7' where uid=55631;
update referencevalue set guid ='5b3243a71a1d357b2e79bbf4' where uid=1706;
update referencevalue set guid ='5902b56a0b8203ef6b897004' where uid=10063;
update referencevalue set guid ='571dedc5ff50bbb2b2686916' where uid=1379;
update referencevalue set guid ='571dedc5ff50bbb2b2686915' where uid=1705;
 
update ReferenceValue set guid ='58747237fad94fa3250ec8ae' where uid =1732
update ReferenceValue set guid ='58747237fad94fa3250ec8af' where uid =160375
update ReferenceValue set guid ='58747237fad94fa3250ec8b2' where uid =79276
update ReferenceValue set guid ='58747237fad94fa3250ec8b3' where uid =79277
update ReferenceValue set guid ='58747237fad94fa3250ec8b6' where uid =5154
update ReferenceValue set guid ='59faec84823a076c785686f9' where uid =1594
update ReferenceValue set guid ='5a746ad64a3e0a06e74cac98' where uid =69901
 
update referencevalue set ALTERNATENAME='TEXTUAL' WHERE DOMAINCODE='RVTYP' AND VALUECODE='TXTRS'
update referencevalue set ALTERNATENAME='REFERENCEVALUE' WHERE DOMAINCODE='RVTYP' AND VALUECODE='REFVL'
update referencevalue set ALTERNATENAME='ORGANISM' WHERE DOMAINCODE='RVTYP' AND VALUECODE='ORN'
update referencevalue set ALTERNATENAME='NUMERIC' WHERE DOMAINCODE='RVTYP' AND VALUECODE='NUMRC'
update referencevalue set ALTERNATENAME='ATTACHMENT' WHERE DOMAINCODE='RVTYP' AND VALUECODE='IMGRS'
update referencevalue set ALTERNATENAME='FREETEXT' WHERE DOMAINCODE='RVTYP' AND VALUECODE='FTF'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL1'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'
update referencevalue set ALTERNATENAME='NUTRITION' WHERE DOMAINCODE='RVTYP' AND VALUECODE='FDINGT'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'
update referencevalue set ALTERNATENAME='HEADING' WHERE DOMAINCODE='RVTYP' AND VALUECODE='HEDVL2'

DML Scripts for ReferenceValue bug fix JIRA 2269
================================================
update referencedomain set guid='5c87e2485d836f29be63d3b8' WHERE UID=352
update referencedomain set guid='5c87e2485d836f29be63d3b9' WHERE UID=11421
update referencedomain set guid='5c87e2485d836f29be63d3ba' WHERE UID=11386
update referencedomain set guid='5c87e2485d836f29be63d3bb' WHERE UID=354
update referencedomain set guid='5c87e2485d836f29be63d3bc' WHERE UID=10374
update referencedomain set guid='5c87e2485d836f29be63d3bd' WHERE UID=10292
update referencedomain set guid='5c87e2485d836f29be63d3be' WHERE UID=10182
update referencedomain set guid='5c87e2485d836f29be63d3bf' WHERE UID=10345
update referencedomain set guid='5c87e2485d836f29be63d3c0' WHERE UID=10379
update referencedomain set guid='5c87e2485d836f29be63d3c1' WHERE UID=374
update referencedomain set guid='5c87e2485d836f29be63d3a6' WHERE UID=11406
update referencedomain set guid='5c87e2485d836f29be63d3a7' WHERE UID=10378
update referencedomain set guid='5c87e2485d836f29be63d3a8' WHERE UID=10380
update referencedomain set guid='5c87e2485d836f29be63d3a9' WHERE UID=10338
update referencedomain set guid='5c87e2485d836f29be63d3aa' WHERE UID=375
update referencedomain set guid='5c87e2485d836f29be63d3ab' WHERE UID=353
update referencedomain set guid='5c87e2485d836f29be63d3ac' WHERE UID=386
update referencedomain set guid='5c87e2485d836f29be63d3ad' WHERE UID=11409
update referencedomain set guid='5c87e2485d836f29be63d3ae' WHERE UID=11420
update referencedomain set guid='5c87e2485d836f29be63d3af' WHERE UID=392
update referencedomain set guid='5c87e2485d836f29be63d3b0' WHERE UID=11384
update referencedomain set guid='5c87e2485d836f29be63d3b1' WHERE UID=11407
update referencedomain set guid='5c87e2485d836f29be63d3b2' WHERE UID=10339
update referencedomain set guid='5c87e2485d836f29be63d3b3' WHERE UID=373
update referencedomain set guid='5c87e2485d836f29be63d3b4' WHERE UID=10375
update referencedomain set guid='5c87e2485d836f29be63d3b5' WHERE UID=10377
update referencedomain set guid='5c87e2485d836f29be63d3b6' WHERE UID=11422
update referencedomain set guid='5c87e2485d836f29be63d3b7' WHERE UID=11387
alter table storeuomconversion add  guid nvarchar(50)