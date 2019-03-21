Data Migration Scripts 

*********************************************GUID MAPPING SCRIPTS*****************************

Step 2 --Map all the guids in the below master tables and keep the object  id ready for mongo migration

vairreferencevaluesguids
=======================
bcp "select * from HEALTHOBJECT_TEST..vairreferencevaluesguids" queryout "F:\DM\import\vairreferencevaluesguids.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vairreferencevaluesguids  --file vairreferencevaluesguids.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vairreferencevaluesguids  --out e:\vairreferencevaluesguids.csv --type=csv --fields _id,externaluid

update vairreferencevaluesguids12 set _id=replace(_id,'ObjectId(','')
update vairreferencevaluesguids12 set _id=replace(_id,')','')

UPDATE R  SET R.guid=TR._id  FROM referencevalue R  INNER JOIN vairreferencevaluesguids12 TR ON TR.externalUID=R.UID 

users guid mappings
==================
bcp "select * from HEALTHOBJECT_TEST..vAirusersguidmapping" queryout "F:\DM\import\vAirusersguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirusersguidmappingguid  --file vAirusersguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirusersguidmappingguid  --out vAirusersguidmappingguid.csv --type=csv --fields _id,orguid,ForeName

update vAirusersguidmappingguid1 set _id=replace(_id,'ObjectId(','')
update vAirusersguidmappingguid1 set _id=replace(_id,')','')

UPDATE R  SET R.guid=TR._id  FROM CAREPROVIDER R  INNER JOIN vAirusersguidmappingguid1 TR ON TR.orguid=R.UID 

ROLE guid mappings
==================
bcp "select * from HEALTHOBJECT_TEST..vRole" queryout "F:\DM\import\role.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c roleguidmappings  --file role.json --drop --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection roleguidmappings  --out roleguidmappings1.csv --type=csv --fields _id,externaluid,ForeName

update roleguidmappings1 set _id=replace(_id,'ObjectId(','')
update roleguidmappings1 set _id=replace(_id,')','')

UPDATE R  SET R.guid=TR._id  FROM ROLE R  INNER JOIN roleguidmappings1 TR ON TR.externaluid=R.UID


vAirlocationguidmapping
=======================
bcp "select * from HEALTHOBJECT_TEST..vAirlocationguidmapping" queryout "F:\DM\import\vAirlocationguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirlocationguidmapping  --file vAirlocationguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirlocationguidmapping  --out vAirlocationguidmapping.csv --type=csv --fields _id,orgid

update vAirlocationguidmapping1 set _id=replace(_id,'ObjectId(','')
update vAirlocationguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM LOCATION R  INNER JOIN vAirlocationguidmapping1 TR ON TR.orgid=R.UID

specialty guid mappings
=======================
bcp "select * from HEALTHOBJECT_TEST..specialtyguid" queryout "D:\DM\specialtyguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c specialtyguid  --file specialtyguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection specialtyguid  --out specialtyguid1.csv --type=csv --fields _id,externaluid

update specialtyguid1 set _id=replace(_id,'ObjectId(','')
update specialtyguid1 set _id=replace(_id,')','')

UPDATE R  SET R.guid=TR._id  FROM Speciality R  INNER JOIN specialtyguid1 TR ON TR.externalUID=R.UID 


vAirserviceguidmapping
======================
bcp "select * from HEALTHOBJECT_TEST..vAirserviceguidmapping" queryout "F:\DM\import\vAirserviceguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirserviceguidmapping  --file vAirserviceguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirserviceguidmapping  --out vAirserviceguidmapping.csv --type=csv --fields _id,externaluid

update vAirserviceguidmapping1 set _id=replace(_id,'ObjectId(','')
update vAirserviceguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM SERVICE R  INNER JOIN vAirserviceguidmapping1 TR ON TR.externaluid=R.UID

billableitemguidmapping
=======================
bcp "select * from HEALTHOBJECT_TEST..billableitemguidmapping" queryout "F:\DM\import\billableitemguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c billableitemguidmapping  --file billableitemguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection billableitemguidmapping  --out billableitemguidmapping.csv --type=csv --fields _id,externaluid

update billableitemguidmappingguid set _id=replace(_id,'ObjectId(','')
update billableitemguidmappingguid set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM BILLABLEITEM R  INNER JOIN billableitemguidmappingguid TR ON TR.externaluid=R.UID

ordercatalogitemguidmappings
============================

bcp "select * from HEALTHOBJECT_TEST..ordercatalogitemguidmapping" queryout "F:\DM\import\ordercatalogitemguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordercatalogitemguidmapping  --file ordercatalogitemguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection ordercatalogitemguidmapping  --out ordercatalogitemguidmapping.csv --type=csv --fields _id,externaluid

update ordercatalogitemguidmapping1 set _id=replace(_id,'ObjectId(','')
update ordercatalogitemguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM ORDERCATALOGITEM R  INNER JOIN ordercatalogitemguidmapping1 TR ON TR.externaluid=R.UID

ordercateogryguidmappings
=========================

bcp "select * from HEALTHOBJECT_TEST..OrderCategoryguidmapping" queryout "F:\DM\import\OrderCategoryguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c OrderCategoryguidmapping  --file OrderCategoryguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection OrderCategoryguidmapping  --out OrderCategoryguidmapping1.csv --type=csv --fields _id,externaluid

update OrderCategoryguidmapping1 set _id=replace(_id,'ObjectId(','')
update OrderCategoryguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM OrderCategory R  INNER JOIN OrderCategoryguidmapping1 TR ON TR.externaluid=R.UID

orderset guid mapping
=====================
bcp "select * from HEALTHOBJECT_TEST..ordersetguidmapping" queryout "F:\DM\import\ordersetguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordersetguidmapping  --file ordersetguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection ordersetguidmapping  --out ordersetguidmapping1.csv --type=csv --fields _id,externaluid

update ordersetguidmapping1 set _id=replace(_id,'ObjectId(','')
update ordersetguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM orderset R  INNER JOIN ordersetguidmapping1 TR ON TR.externaluid=R.UID

AGE MASTER MAPPING guid mapping
===============================
bcp "select * from HEALTHOBJECT_TEST..vAiragemasterguid" queryout "F:\DM\import\vAiragemasterguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAiragemasterguid  --file vAiragemasterguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAiragemasterguid  --out vAiragemasterguid1.csv --type=csv --fields _id,externaluid

update vAiragemasterguid1 set _id=replace(_id,'ObjectId(','')
update vAiragemasterguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM agemaster R  INNER JOIN vAiragemasterguid1 TR ON TR.externaluid=R.UID

REQUESTITEM MAPPING guid mapping
================================
bcp "select * from HEALTHOBJECT_TEST..REQUESTITEMguid" queryout "D:\DM\REQUESTITEMguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c REQUESTITEMguid  --file REQUESTITEMguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection REQUESTITEMguid  --out REQUESTITEMguid1.csv --type=csv --fields _id,externaluid

update REQUESTITEMguid1 set _id=replace(_id,'ObjectId(','')
update REQUESTITEMguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM REQUESTITEM R  INNER JOIN REQUESTITEMguid1 TR ON TR.externaluid=R.UID

BILLPACKAGE MAPPING guid mapping
================================
bcp "select * from HEALTHOBJECT_TEST..vAirbillpackageitemguid" queryout "D:\DM\vAirbillpackageitemguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirbillpackageitemguid  --file vAirbillpackageitemguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirbillpackageitemguid  --out vAirbillpackageitemguid1.csv --type=csv --fields _id,externaluid

update vAirbillpackageitemguid1 set _id=replace(_id,'ObjectId(','')
update vAirbillpackageitemguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM billpackageitem R  INNER JOIN vAirbillpackageitemguid1 TR ON TR.externaluid=R.UID

Specimen guid mappings has to be done
=====================================
bcp "select * from HEALTHOBJECT_TEST..vAirbillpackageitemguid" queryout "D:\DM\vAirbillpackageitemguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirbillpackageitemguid  --file vAirbillpackageitemguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirbillpackageitemguid  --out vAirbillpackageitemguid1.csv --type=csv --fields _id,externaluid

update vAirbillpackageitemguid1 set _id=replace(_id,'ObjectId(','')
update vAirbillpackageitemguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM billpackageitem R  INNER JOIN vAirbillpackageitemguid1 TR ON TR.externaluid=R.UID

PAYORAGGREMENT MAPPING guid mapping
===================================
bcp "select * from HEALTHOBJECT_TEST..PayorAgreementguid" queryout "D:\DM\PayorAgreementguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c PayorAgreementguid  --file PayorAgreementguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection PayorAgreementguid  --out PayorAgreementguid1.csv --type=csv --fields _id,externaluid

update PayorAgreementguid1 set _id=replace(_id,'ObjectId(','')
update PayorAgreementguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM PayorAgreement R  INNER JOIN PayorAgreementguid1 TR ON TR.externaluid=R.UID


INSURENCE COMPANY MAPPING guid mapping
======================================
bcp "select * from HEALTHOBJECT_TEST..insurancecompanyguid" queryout "D:\DM\insurancecompanyguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c insurancecompanyguid  --file insurancecompanyguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection insurancecompanyguid  --out insurancecompanyguid1.csv --type=csv --fields _id,externaluid

update insurancecompanyguid1 set _id=replace(_id,'ObjectId(','')
update insurancecompanyguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM insurancecompany R  INNER JOIN insurancecompanyguid1 TR ON TR.externaluid=R.UID


INSURENCE PLAN MAPPING guid mapping
===================================
bcp "select * from HEALTHOBJECT_TEST..insuranceplanguid" queryout "D:\DM\insuranceplanguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c insuranceplanguid  --file insuranceplanguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection insuranceplanguid  --out insuranceplanguid1.csv --type=csv --fields _id,externaluid

update insuranceplanguid1 set _id=replace(_id,'ObjectId(','')
update insuranceplanguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM insuranceplan R  INNER JOIN insuranceplanguid1 TR ON TR.externaluid=R.UID

CCHIP MAPPING guid mapping
==========================
bcp "select * from HEALTHOBJECT_TEST..vaircchpimasterguid" queryout "D:\DM\vaircchpimasterguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vaircchpimasterguid  --file vaircchpimasterguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vaircchpimasterguid  --out vaircchpimasterguid1.csv --type=csv --fields _id,externaluid

update vaircchpimasterguid set _id=replace(_id,'ObjectId(','')
update vaircchpimasterguid set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM vaircchpimaster R  INNER JOIN vaircchpimasterguid TR ON TR.externaluid=R.UID


PAYORDETAIL GUID MAPPING guid mapping
=====================================
bcp "select * from HEALTHOBJECT_TEST..PayorDetailguidmapping" queryout "D:\DM\PayorDetailguidmapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c PayorDetailguidmapping  --file PayorDetailguidmapping.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection PayorDetailguidmapping  --out PayorDetailguidmapping1.csv --type=csv --fields _id,externaluid

update PayorDetailguidmapping1 set _id=replace(_id,'ObjectId(','')
update PayorDetailguidmapping1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM PayorDetail R  INNER JOIN PayorDetailguidmapping1 TR ON TR.externaluid=R.UID

STORE MASTER MAPPING guid mapping
=================================
bcp "select * from HEALTHOBJECT_TEST..vAirSTOREmasterguid" queryout "F:\DM\import\vAirSTOREmasterguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirSTOREmasterguid  --file vAirSTOREmasterguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirSTOREmasterguid  --out vAirSTOREmasterguid1.csv --type=csv --fields _id,externaluid

update vAirSTOREmasterguid1 set _id=replace(_id,'ObjectId(','')
update vAirSTOREmasterguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM STORE R  INNER JOIN vAirSTOREmasterguid1 TR ON TR.externaluid=R.UID

MANUFACTUREDETAIL MAPPING guid mapping
======================================
bcp "select * from HEALTHOBJECT_TEST..vAirmanufacturerdetailguid" queryout "F:\DM\import\vAirmanufacturerdetailguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAirmanufacturerdetailguid  --file vAirmanufacturerdetailguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAirmanufacturerdetailguid  --out vAirmanufacturerdetailguid1.csv --type=csv --fields _id,externaluid

update vAirmanufacturerdetailguid1 set _id=replace(_id,'ObjectId(','')
update vAirmanufacturerdetailguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM manufacturerdetail R  INNER JOIN vAirmanufacturerdetailguid1 TR ON TR.externaluid=R.UID


DRUGCATALOGITEM MAPPING guid mapping
====================================
bcp "select * from HEALTHOBJECT_TEST..DRUGCATALOGITEMguid" queryout "F:\DM\import\DRUGCATALOGITEMguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c DRUGCATALOGITEMguid  --file DRUGCATALOGITEMguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection DRUGCATALOGITEMguid  --out DRUGCATALOGITEMguid1.csv --type=csv --fields _id,externaluid

update DRUGCATALOGITEMguid1 set _id=replace(_id,'ObjectId(','')
update DRUGCATALOGITEMguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM DRUGCATALOGITEM R  INNER JOIN DRUGCATALOGITEMguid1 TR ON TR.externaluid=R.UID

PROCEDURELIST MAPPING guid mapping
==================================
bcp "select * from HEALTHOBJECT_TEST..ProcedureListguid" queryout "D:\DM\ProcedureListguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ProcedureListguid  --file ProcedureListguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection ProcedureListguid  --out ProcedureListguid1.csv --type=csv --fields _id,externaluid

update ProcedureListguid1 set _id=replace(_id,'ObjectId(','')
update ProcedureListguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM ProcedureList R  INNER JOIN ProcedureListguid1 TR ON TR.externaluid=R.UID

PROBLEM MAPPING guid mapping
============================
bcp "select * from HEALTHOBJECT_TEST..problemguid" queryout "D:\DM\problemguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c problemguid  --file problemguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection problemguid  --out problemguid1.csv --type=csv --fields _id,externaluid

update problemguid1 set _id=replace(_id,'ObjectId(','')
update problemguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM problem R  INNER JOIN problemguid1 TR ON TR.externaluid=R.UID

PINCODE MAPPING guid mapping
============================
bcp "select * from HEALTHOBJECT_TEST..PINCODEMAPPINGguid" queryout "D:\DM\PINCODEMAPPINGguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c PINCODEMAPPINGguid  --file PINCODEMAPPINGguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection PINCODEMAPPINGguid  --out PINCODEMAPPINGguid1.csv --type=csv --fields _id,externaluid

update PINCODEMAPPINGguid1 set _id=replace(_id,'ObjectId(','')
update PINCODEMAPPINGguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM PINCODEMAPPING R  INNER JOIN PINCODEMAPPINGguid1 TR ON TR.externaluid=R.UID

ITEM MASTER MAPPING guid mapping
================================
bcp "select * from HEALTHOBJECT_TEST..vAiritemmasterguid" queryout "F:\DM\import\vAiritemmasterguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vAiritemmasterguid  --file vAiritemmasterguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vAiritemmasterguid  --out vAiritemmasterguid1.csv --type=csv --fields _id,externaluid

update vAiritemmasterguid1 set _id=replace(_id,'ObjectId(','')
update vAiritemmasterguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM itemmaster R  INNER JOIN vAiritemmasterguid1 TR ON TR.externaluid=R.UID

ordersetbillableitemguid mapping
===============================
bcp "select * from HEALTHOBJECT_TEST..Ordersetbillableitemguid" queryout "D:\DM\Ordersetbillableitemguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c Ordersetbillableitemguid  --file Ordersetbillableitemguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection Ordersetbillableitemguid  --out Ordersetbillableitemguid1.csv --type=csv --fields _id,externaluid

update Ordersetbillableitemguid1 set _id=replace(_id,'ObjectId(','')
update Ordersetbillableitemguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM Ordersetbillableitem1 R  INNER JOIN Ordersetbillableitemguid TR ON TR.externaluid=R.UID


Frequency definition guid mappings
=================================

bcp "select * from HEALTHOBJECT_TEST..frequencydefinitionguid" queryout "D:\DM\frequencydefinitionguid.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c frequencydefinitionguid  --file frequencydefinitionguid.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection frequencydefinitionguid  --out frequencydefinitionguid1.csv --type=csv --fields _id,externaluid

update frequencydefinitionguid1 set _id=replace(_id,'ObjectId(','')
update frequencydefinitionguid1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM FrequencyDefinition R  INNER JOIN frequencydefinitionguid1 TR ON TR.externaluid=R.UID



step 3:
=======

--vairReferencedomainAA
bcp "select * from HEALTHOBJECT_TEST..vairReferencedomainAA" queryout "F:\DM\import\vairReferencedomainAA.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
bcp "select * from HEALTHOBJECT_TEST..vairReferencedomainAA_v1_missed" queryout "D:\DM\vairReferencedomainAA_v1_missed.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
bcp "select * from HEALTHOBJECT_TEST..vairReferencevaluesAA" queryout "F:\DM\import\vairReferencevaluesAA.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
bcp "select * from HEALTHOBJECT_TEST..vairReferencevaluesAA_v1_missed" queryout "D:\DM\vairReferencevaluesAA_v1_missed.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"


mongoimport -d arcusairdb -u incusdba -p incus@123 -c referencedomains  --file vairReferencedomainAA.json  --jsonArray --host 172.16.10.804
mongoimport -d arcusairdb -u incusdba -p incus@123 -c referencedomains  --file vairReferencedomainAA_v1_missed.json  --jsonArray --host 172.16.10.80
mongoimport -d arcusairdb -u incusdba -p incus@123 -c referencevalues  --file vairReferencevaluesAA.json  --jsonArray --host 172.16.10.80
mongoimport -d arcusairdb -u incusdba -p incus@123 -c referencevalues  --file vairReferencevaluesAA_v1_missed.json  --jsonArray --host 172.16.10.80



--DEPARTMENT
bcp "select * from HEALTHOBJECT_TEST..vairdepartment" queryout "F:\DM\import\department.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c departments  --file department.json  --jsonArray --drop --172.16.10.80


--LOCATION
bcp "select * from HEALTHOBJECT_TEST..vAirLocation" queryout "F:\DM\import\vAirLocation.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c locations  --file vAirLocation.json --drop  --jsonArray --host 172.16.10.80

--LOCATION SERVICE
bcp "select * from HEALTHOBJECT_TEST..vAirLocationservice" queryout "F:\DM\import\vAirLocationservice.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c locations  --file vAirLocationservice.json  --jsonArray --host 172.16.10.80


bcp "select * from HEALTHOBJECT_TEST..vAirwards" queryout "D:\DM\wards.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c wards  --file wards.json --drop  --jsonArray --host 172.16.10.80 

bcp "select * from HEALTHOBJECT_TEST..vairbeds" queryout "F:\DM\import\beds.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c beds  --file beds.json  --drop --jsonArray --host 172.16.10.80 

--REFERRAL MASTER
bcp "select * from HEALTHOBJECT_TEST..vairreferralMaster" queryout "D:\DM\vairreferralMaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c referringorgs  --file vairreferralMaster.json --drop  --jsonArray --host 172.16.10.80

--ROLE
bcp "select * from HEALTHOBJECT_TEST..vRole" queryout "F:\DM\import\role.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c roles  --file role.json --drop --jsonArray --host 172.16.10.80


--USER

bcp "select * from HEALTHOBJECT_TEST..vairusers" queryout "F:\DM\import\users.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c userstesting  --file users.json  --jsonArray --drop  --host 172.16.10.80

--FrequencY
bcp "select * from HEALTHOBJECT_TEST..vAirFrequencyDefinition" queryout "F:\DM\import\vAirFrequencyDefinition.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c frequencies  --file vAirFrequencyDefinition.json --drop --jsonArray --host 172.16.10.80

--ORDER CATEGORY
bcp "select * from HEALTHOBJECT_TEST..vAirOrderCategory" queryout "D:\DM\vAirOrderCategory.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordercategories  --file vAirOrderCategory.json --drop --jsonArray  --host 172.16.10.80

--ORDER SUBCATEGORY
bcp "select * from HEALTHOBJECT_TEST..vAirOrderSubCategory" queryout "D:\DM\vAirOrderSubCategory.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordercategories  --file vAirOrderSubCategory.json  --jsonArray  --host 172.16.10.80


--BILLING GROUP
bcp "select * from HEALTHOBJECT_TEST..vAirBillingGroups" queryout "F:\DM\import\vAirBillingGroups.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c billinggroups  --file vAirBillingGroups.json  --jsonArray --drop  --host 172.16.10.80

--BILLING SUBGROUP
bcp "select * from HEALTHOBJECT_TEST..vAirBillingSubGroups" queryout "D:\DM\vAirBillingSubGroups.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c billinggroups  --file vAirBillingSubGroups.json  --jsonArray --host 172.16.10.80

--BILLING SERVICE
bcp "select * from HEALTHOBJECT_TEST..vAirBillingService" queryout "D:\DM\vAirBillingService.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c billingservices  --file vAirBillingService.json  --drop --jsonArray  --host 172.16.10.80

--SPECIMEN MASTER
bcp "select * from HEALTHOBJECT_TEST..vAirSpecimenMaster" queryout "D:\DM\vAirSpecimenMaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c specimens  --file vAirSpecimenMaster.json  --drop  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection specimens  --out specimens.csv --type=csv --fields _id,orguid,externaluid,externaltablename 

update specimensguid set _id=replace(_id,'ObjectId(','')
update specimensguid set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM SPECIMEN R  INNER JOIN specimensguid TR ON TR.externaluid=R.UID

--SPECIMEN TEST MASTER
bcp "select * from HEALTHOBJECT_TEST..vAirtestspecimens" queryout "D:\DM\vAirtestspecimens.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c testspecimens  --file vAirtestspecimens.json  --drop  --jsonArray --host 172.16.10.80

--CCHPI
bcp "select * from HEALTHOBJECT_TEST..vaircchpimaster" queryout "D:\DM\vaircchpimaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c cchpimasters  --file vaircchpimaster.json  --jsonArray --drop  --jsonArray --host 172.16.10.80


--DIAGNOSIS
bcp "select * from HEALTHOBJECT_TEST..vAirproblems" queryout "D:\DM\vAirproblems.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c problems  --file vAirproblems.json   --drop  --jsonArray --host 172.16.10.80

--PROCEDURE LIST
bcp "select * from HEALTHOBJECT_TEST..vairprocedurelist" queryout "D:\DM\vairprocedurelist.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c procedures  --file vairprocedurelist.json  --drop  --jsonArray --host 172.16.10.80

--STOREBIN(missed it in miot)
bcp "select * from healthobject..vairstorebin" queryout "D:\mig\vairstorebin.json" -t -T -c -C 65001
db.storebin.remove({"orguid" : ObjectId("5b20f438d1202e29ce16f710"")})
mongoimport -d arcusairdb -u incusdba -p incus@123 -c storebin  --file D:\mig\vairstorebin.json  --jsonArray  
mongoexport -u incusdba" -p incus@123 --db arcusairdb --collection storebin  --out D:\mig\vairstorebin.csv --type=csv --fields _id,orguid,externaluid,issubgroup,externaltablename 

--STORE
bcp "select * from HEALTHOBJECT_TEST..vAirStoreMaster" queryout "D:\DM\vAirStoreMaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c inventorystores  --file vAirStoreMaster.json  --drop --jsonArray --host 172.16.10.80

db.getCollection('inventorystores').update({restrictfunctions:"[INVENTORIES.PURCHASEORDER,INVENTORIES.STOCKREQ]"},    {$set:{restrictfunctions :["INVENTORIES.PURCHASEORDER","INVENTORIES.STOCKREQ"]}},{multi:true})


--VENDOR
bcp "select * from HEALTHOBJECT_TEST..vAirManufacturerdetail" queryout "D:\DM\vAirManufacturerdetail.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c vendors  --file vAirManufacturerdetail.json  --drop --jsonArray --host 172.16.10.80

db.vendors.update({orguid:ObjectId("567985db736f64f263128548")}, {$set: {orguid: ObjectId("569794170946a3d0d588efe6")}}, {multi: true})
db.vendors.update({orguid:ObjectId("5c761d2c5d836f29be351e7b")}, {$set: {orguid: ObjectId("569794170946a3d0d588efe6")}}, {multi: true})

--ITEM MASTER
bcp "select * from HEALTHOBJECT_TEST..vAiritemmaster" queryout "D:\DM\vAiritemmaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c itemmasters  --file vAiritemmaster.json --drop --jsonArray --host 172.16.10.80

--AGE MASTER
bcp "select * from HEALTHOBJECT_TEST..vagemaster" queryout "F:\DM\import\vagemaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c agemasters  --file vagemaster.json --drop  --jsonArray --host 172.16.10.80


--ORDER RESULT ITEM
bcp "select * from HEALTHOBJECT_TEST..vAirOrderResultitem" queryout "D:\DM\vAirOrderResultitem.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c orderresultitems  --file vAirOrderResultitem.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection orderresultitems  --out orderresultitems.csv --type=csv --fields _id,orguid,externaluid,externaltablename 

update orderresultitemsguid set _id=replace(_id,'ObjectId(','')
update orderresultitemsguid set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM OrderResultItem R  INNER JOIN orderresultitemsguid TR ON TR.externalUID=R.UID and tr.externaltablename='orderresultitem'


--RESULT ITEM
bcp "select * from HEALTHOBJECT_TEST..vAirResultitem" queryout "D:\DM\vAirResultitem.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c resultitem  --file vAirResultitem.json  --jsonArray --host 172.16.10.80
mongoimport -d arcusairdb -u incusdba -p incus@123  -c orderresultitems  --file vAirResultitem.json  --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection resultitem  --out resultitem.csv --type=csv --fields _id,orguid,externaluid,externaltablename




bcp "select * from HEALTHOBJECT_TEST..vAirFrequencyDefinition" queryout "F:\DM\import\vAirFrequencyDefinition.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c frequencies  --file vAirFrequencyDefinition.json --drop --jsonArray --host 172.16.10.80
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection frequencies  --out frequencies.csv --type=csv --fields _id,orguid,externaluid,externaltablename
update frequenciesguid set _id=replace(_id,'ObjectId(','')
update frequenciesguid set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM FREQUENCYDEFINITION R  INNER JOIN frequenciesguid TR ON TR.externalUID=R.UID



--ORDER ITEM
bcp "select * from HEALTHOBJECT_TEST..vAirOrderitemvital" queryout "D:\DM\vAirOrderitemvital.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c orderitems  --file vAirOrderitemvital.json --drop --jsonArray --host 172.16.10.80

bcp "select * from HEALTHOBJECT_TEST..vAirOrderitemLab" queryout "D:\DM\vAirOrderitemLab.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c orderitems  --file vAirOrderitemLab.json  --jsonArray --host 172.16.10.80

bcp "select * from HEALTHOBJECT_TEST..vAirOrderitemCatalog" queryout "D:\DM\vAirOrderitemCatalog.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c orderitems  --file vAirOrderitemCatalog.json  --jsonArray --host 172.16.10.80

--591e82f9a57b21756dda8ab9--instruction uid hardocoded
bcp "select * from HEALTHOBJECT_TEST..vAirOrderitemmaster" queryout "D:\DM\vAirOrderitemmaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c orderitems  --file vAirOrderitemmaster.json  --jsonArray --host 172.16.10.80 

bcp "select * from HEALTHOBJECT_TEST..vAirBillableitemothers" queryout "D:\DM\vAirBillableitemothers.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c orderitems  --file vAirBillableitemothers.json  --jsonArray --host 172.16.10.80 

--the below is not requited already fixed in earlier migration
bcp "select * from HEALTHOBJECT_TEST..vAirBillableitemothers_1" queryout "D:\DM\vAirBillableitemothers_1.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c orderitems  --file vAirBillableitemothers_1.json  --jsonArray --host 172.16.10.80 


--ORDER SET
bcp "select * from HEALTHOBJECT_TEST..vairorderset" queryout "D:\DM\vairorderset.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordersets  --file vairorderset.json  --jsonArray  --drop --jsonArray --host 172.16.10.80



----BILL PACKAGE 
bcp "select * from HEALTHOBJECT_TEST..vairbillpackage" queryout "D:\DM\vairbillpackage.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c ordersets  --file vairbillpackage.json  --jsonArray --host 172.16.10.80


--TPA
bcp "select * from HEALTHOBJECT_TEST..vAirtpa" queryout "D:\DM\vAirtpa.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c tpas  --file vAirtpa.json  --drop --jsonArray --host 172.16.10.80

--PAYOR
bcp "select * from HEALTHOBJECT_TEST..vAirpayor" queryout "D:\DM\vAirpayor.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c payors  --file vAirpayor.json --drop --jsonArray --host 172.16.10.80


BEFORE THIS ADD TO RUN THE PAYOREXCLUSION DML SCRIPTS(PayorAgreeementexlusive)PayorAgreeementexlusive
db.payors.update({name :'SELFPAY'}, {$set: {code:'SELFPAY'}}, {multi: true})

--PAYOR AGREEMENT
bcp "select * from HEALTHOBJECT_TEST..vAirPayorAgreement" queryout "D:\DM\vAirPayorAgreement.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c payoragreements  --file vAirPayorAgreement.json  --drop --jsonArray --host 172.16.10.80

--ITEM IMAGES(Pending)
bcp "select * from ARCUS_RESTORE..vairitemmasterimage" queryout "D:SUNWAY_SCRIPTS\vairitemmasterimage.json" -t -T -c -C 65001
db.itemimages.remove({})
mongoimport -d arcusdm -u migration -p migration -c itemimages  --file vairitemmasterimage.json  --jsonArray --host 10.16.1.199  --authenticationDatabase admin
mongoexport --host 10.16.1.199 -u "migration" -p "migration" --db arcusdm --collection itemimages  --out e:\itemimages.csv --type=csv --fields _id,orguid,externaluid,externaltablename --authenticationDatabase admin


--DRUG GROUP
bcp "select * from HEALTHOBJECT_TEST..vAirDruggenericDruggroup" queryout "D:\DM\vAirDruggenericDruggroup.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c druggroups  --file vAirDruggenericDruggroup.json --drop --jsonArray --host 172.16.10.80

--DRUG MASTER
bcp "select * from HEALTHOBJECT_TEST..vAirDrugmastergeneric" queryout "D:\DM\vAirDrugmastergeneric.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c drugmasters  --file vAirDrugmastergeneric.json --drop  --jsonArray --host 172.16.10.80

bcp "select * from HEALTHOBJECT_TEST..vAirDrugmaster" queryout "D:\DM\vAirDrugmaster.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c drugmasters  --file vAirDrugmaster.json --jsonArray --host 172.16.10.80


--UOM CONVERSION
bcp "select * from HEALTHOBJECT_TEST..vAirStoreUOMconversion" queryout "D:\DM\vAirStoreUOMconversion.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"

mongoimport -d arcusairdb -u incusdba -p incus@123 -c uomconversions  --file vAirStoreUOMconversion.json --drop  --jsonArray --host 172.16.10.80

--City
bcp "select * from HEALTHOBJECT_TEST..vaircity" queryout "D:\DM\vaircity.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c cities  --file vaircity.json  --drop  --jsonArray --host 172.16.10.80

--states
bcp "select * from HEALTHOBJECT_TEST..vairState" queryout "D:\DM\vairState.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c states  --file vairState.json  --drop  --jsonArray --host 172.16.10.80

--country
bcp "select * from HEALTHOBJECT_TEST..vairCountry" queryout "D:\DM\vairCountry.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c countries  --file vairCountry.json  --drop  --jsonArray --host 172.16.10.80


--area
bcp "select * from HEALTHOBJECT_TEST..vairarea" queryout "D:\DM\vairarea.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c areas  --file vairarea.json  --drop  --jsonArray --host 172.16.10.80

--pincodemapping
bcp "select * from HEALTHOBJECT_TEST..vairpincodemapping" queryout "D:\DM\vairpincodemapping.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c zipcodes  --file vairpincodemapping.json  --drop  --jsonArray --host 172.16.10.80


 
bcp "select * from HEALTHOBJECT_TEST..vairalltariffmasterncoutertype" queryout "D:\DM\vairalltariffmasterncoutertype.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123  -c tariffs  --file vairalltariffmasterncoutertype.json  --drop --jsonArray --host 172.16.10.80 
mongoexport --host 172.16.10.80 -u "incusdba" -p "incus@123" --db arcusairdb --collection vairalltariffmasterncoutertype  --out vairalltariffmasterncoutertype1.csv --type=csv --fields _id,externaluid

update vairalltariffmasterncoutertype1 set _id=replace(_id,'ObjectId(','')
update vairalltariffmasterncoutertype1 set _id=replace(_id,')','')
UPDATE R  SET R.guid=TR._id  FROM Billableitemdetail R  INNER JOIN vairalltariffmasterncoutertype1 TR ON TR.externaluid=R.UID

db.itemmasters.update({orguid:ObjectId("569794170946a3d0d588efe6")}, {$set: {orguid: ObjectId("567985db736f64f263128548")}}, {multi: true})
db.inventorystores.update({orguid:ObjectId("569794170946a3d0d588efe6")}, {$set: {orguid: ObjectId("567985db736f64f263128548")}}, {multi: true})
db.orderresultitems.update({orguid:ObjectId("569794170946a3d0d588efe6")}, {$set: {orguid: ObjectId("567985db736f64f263128548")}}, {multi: true})
--tarifforderset

bcp "select * from HEALTHOBJECT_TEST..vairalltariffmasterOrderSet" queryout "D:\DM\vairalltariffmasterOrderSet.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c tariffs  --file vairalltariffmasterOrderSet.json  --jsonArray --host 172.16.10.80 

--tarriffspackage(doubt)

bcp "select * from HEALTHOBJECT_TEST..vtariffoutPackage" queryout "D:\DM\vtariffoutPackage.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c tariffs  --file vtariffoutPackage.json  --jsonArray --host 172.16.10.80 

--tarriffsbedpackage(doubt)
bcp "select * from HEALTHOBJECT_TEST..vtariffInPackage" queryout "D:\DM\vtariffInPackage.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c tariffs  --file vtariffInPackage.json  --jsonArray --host 172.16.10.80 

--normal package tariffs(doubt)
bcp "select * from HEALTHOBJECT_TEST..vtariffPackage" queryout "D:\DM\vtariffPackage.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c tariffs  --file vtariffPackage.json  --jsonArray --host 172.16.10.80 


--AUTOCHARGECODEOP(Not required)
bcp "select * from HEALTHOBJECT_TEST..vAirAutoChargeCodeAE" queryout "D:\DM\vAirAutoChargeCodeAE.json" -t -T -c -C 65001 -U "arcusadmin" -P "incarnus@234" -S "MIOTTEST04\SQLSERVER"
mongoimport -d arcusairdb -u incusdba -p incus@123 -c autochargeorders  --file vAirAutoChargeCodeAE.json --drop --jsonArray --host 172.16.10.80   


//
db.referencevalues.find({domaincode:'COMORB'})

db.referencevalues.find({domaincode:'CODISC'})
(need to change the icd10 and icd 9 to codisc1 and codisc2 from domaincode COMORB] and also need to map the reference domain