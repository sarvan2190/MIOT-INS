CREATE VIEW vAirDrugmaster    
As    
SELECT    
(    
SELECT     
DC.guid as  '_id.$oid',    
LTRIM(RTRIM(DC.CODE)) code,    
LTRIM(RTRIM(DC.NAME ))name ,    
LTRIM(RTRIM(DC.DESCRIPTION ))description,    
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,dc.VALIDFROMDTTM) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,bi.activeto) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',      
null locallangdesc ,    
bi.guid as 'orderitemuid.$oid',    
BI.CODE  orderitemcode,    
--(SELECT    
--DM.GUID AS '$oid'    
--FROM    
--DRUGGENERICMASTERDETAIL DGMD,         
--DRUGGENERICMASTER DM    
--WHERE DM.UID=DGMD.DRUGGENERICMASTERUID        
--AND DGMD.DRUGCATALOGITEMUID=DC.UID         
--AND DC.STATUSFLAG ='A'           
--AND DM.STATUSFLAG ='A'          
--AND DGMD.STATUSFLAG ='A'           
--for json path) as genericdruguid,    
--dbo.FGETDRUGCODEBYGENERIC(DC.UID) genericdrugcode,    
convert(bit,'false') inFormulary ,    
CASE WHEN  DC.ISRX = 'Y' THEN convert(bit,'true') else convert(bit,'false') END isrx,    
convert(bit,'false') isgenericdrug,    
CASE WHEN  DC.ISIV = 'Y' THEN convert(bit,'true') else convert(bit,'false') END isiv,     
DC.INFUSEDURATION  infusionduration ,    
null infusiondurationuom,    
null infusionrate,    
(select top 1 rf.guid from referencevalue rf where rf.uid=SALESUOM)'prescibeuomuid.$oid',    
NULL dosagenotapplicable,    
DC.DOSequantity defaultdosage ,--Dosage    
isnull((select top 1 rf.guid from referencevalue rf where rf.uid=PrescriptionUOM),    
(select top 1 rf.guid from referencevalue rf where rf.uid=SalesUOM))'defaultdosageuom.$oid',    
NULL volume,    
null dosagestrength,    
 (select top 1 rf.guid from referencevalue rf where rf.uid=STRNGUID)'dosagestrengthuom.$oid',    
 (select top 1 rf.guid from referencevalue rf where rf.uid=ROUTEUID)'defaultrouteuid.$oid', --EYYEE to EYE    
null restrictroutes ,    
UPPER((SELECT (FD.CODE) FROM FrequencyDefinition(NOLOCK) FD WHERE FD.UID = DC.FREQNUID AND FD.STATUSFLAG = 'A')) [DEFAULT FREQUENCY CODE] ,    
(select top 1 guid from frequencydefinition fd where fd.uid=dc.FREQNUID)'defaultfrequencyuid.$oid',    
null restrictfrequencies,    
(select top 1 rf.guid from referencevalue rf where rf.uid=FORMMUID)'formuid.$oid' ,     
(SELECT    
DG.GUID as '$oid'    
FROM          
DRUGGROUP DG,      
DRUGGROUPITEM DGI    
WHERE DG.UID=DGI.DRUGGROUPUID      
AND DGI.DRUGCATALOGITEMUID=DC.UID      
AND DC.STATUSFLAG ='A'         
AND DG.STATUSFLAG ='A'        
AND DGI.STATUSFLAG ='A'         
for json path)'druggroups',     
null ishighalertdrug,    
null isessentialdrug,    
null essentialdrugtypeuid,    
CASE WHEN  M.IsScheduledDrug='Y' THEN convert(bit,'true') else convert(bit,'false') end isscheduleddrug,    
(select top 1 guid from referencevalue rf where rf.uid=M.SCDRUGUID) 'scheduleddrugtypeuid.$oid',    
null isresearchdrug ,    
CASE WHEN DBO.fGetReferenceValCode(M.SalesUOM)='TAB' THEN convert(bit,'true')    
WHEN DBO.fGetReferenceValCode(M.SalesUOM)='CAP' THEN convert(bit,'true') else convert(bit,'false') END isipfillallowed,    
convert(bit,'true') iscrushingallowed ,    
(select top 1 rf.guid from referencevalue rf where rf.uid=pdstsuid)'instructionuid.$oid',    
null tallmantext ,    
CASE WHEN DC.ISCOMPOUND ='Y' THEN convert(bit,'true') else convert(bit,'false') end iscompounddrug ,    
convert(bit,'false')isvaccine,    
null pregnancycheckmessage,    
null pregnancycheckuid,    
null slidingscaledetails,    
null istaperingdose,    
--CASE WHEN EXISTS(SELECT 1 FROM BKN_PROD..e_referencevaluesUOM E WHERE E._id=dbo.fgetreferenceguid(SALESUOM) and e.relatedvalue='C')     
--THEN Convert(bit,'true') else Convert(bit,'false') end     
null calculatequantity,    
NULL printlabeluid,    
CASE WHEN M.IsNarcotic ='Y' THEN convert(bit,'true') else convert(bit,'false') end isnarcoticdrug,    
(select top 1 guid from referencevalue rf where rf.uid=M.NRCTPUID) 'narcoticdrugtypeuid.$oid',    
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DC.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                             
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DC.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=DC.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,DC.mWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',    
(select top 1 guid from healthorganisation where guid is not null) AS 'orguid.$oid',    
(select top 1 uid from healthorganisation where guid is not null) as orgcode,    
DC.STATUSFLAG statusflag,    
DC.UID  externaluid,    
'drugcatalogitem' externaltablename,    
--(SELECT    
--DM.GUID AS '$oid'    
--FROM    
--DRUGGENERICMASTERDETAIL DGMD,         
--DRUGGENERICMASTER DM    
--WHERE DM.UID=DGMD.DRUGGENERICMASTERUID        
--AND DGMD.DRUGCATALOGITEMUID=DC.UID         
--AND DC.STATUSFLAG ='A'           
--AND DM.STATUSFLAG ='A'          
--AND DGMD.STATUSFLAG ='A'           
--for json path) as allergens,    
(    
SELECT  (SELECT TOP 1 DC.GUID FROM DRUGCATALOGITEM DC WHERE DC.UID=DI.PrimaryDrugCatalogUID AND DC.StatusFlag='A') as 'interactingdruguid.$oid',    
'5b8fb2d5921c4246f61d1374' 'severity.$oid',    
di.description message    
FROM DRUGINTERACTION DI    
WHERE DI.STATUSFLAG='A'    
 AND  DC.UID=DI.SECONDARYDRUGCATALOGUID    
 for json path )as    
druginteractions    
    
    
--dbo.FGETDRUGGROUPEBYDRUGALL(DC.UID)+','+dbo.FGETDRUGCODEBYGENERIC(DC.UID) [ALLERGEN CODE]    
FROM    
DRUGCATALOGITEM(NOLOCK) DC    
OUTER APPLY (SELECT TOP 1 * FROM DRUGTRADENAME(NOLOCK) DTR  WHERE DTR.DRUGCATALOGITEMUID = DC.UID AND DTR.STATUSFLAG = 'A')DTR    
OUTER APPLY (SELECT TOP 1 * FROM ITEMMASTER(NOLOCK) M WHERE M.UID=DTR.ITEMMASTERUID AND M.STATUSFLAG = 'A')M    
OUTER APPLY (SELECT TOP 1 * FROM BILLABLEITEM(NOLOCK) BI  WHERE BI.ITEMUID=M.UID AND BI.BSMDDUID IN(1945,5183) AND BI.STATUSFLAG='A') BI    
  
    
FOR JSON PATH)AS X    
    
    