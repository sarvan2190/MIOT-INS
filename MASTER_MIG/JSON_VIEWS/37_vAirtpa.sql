CREATE VIEW vAirtpa  
AS  
SELECT  
(  
SELECT  
pda.guid as '_id.$oid',  
LTRIM(RTRIM(PDa.CODE )) code,  
LTRIM(RTRIM(PDA.PAYORNAME )) name,  
LTRIM(RTRIM(PDA.PAYORNAME )) description,  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pda.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',     
null  'activeto.$date.$numberLong',     
null attentiondepartment,  
CONTACTPERSONNAME contactperson,  
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=PYRACATUID)'arcategoryuid.$oid',  
null comments,  
pda.agentname agentname,  
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(  
              LTRIM(RTRIM(pda.line1)), CHAR(9), ' '), CHAR(10), ' '), CHAR(11), ' '), CHAR(12), ' '), CHAR(13), ' ')))[address.address],  
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(  
              LTRIM(RTRIM(pda.line2)), CHAR(9), ' '), CHAR(10), ' '), CHAR(11), ' '), CHAR(12), ' '), CHAR(13), ' ')))[address.address2],  
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(  
              LTRIM(RTRIM(pda.line3)), CHAR(9), ' '), CHAR(10), ' '), CHAR(11), ' '), CHAR(12), ' '), CHAR(13), ' ')))[address.address3],  
null area,  
DBO.fGetReferenceValCode(PDA.CITTYUID) city,  
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=CITTYUID) 'cityuid.$oid',  
DBO.fGetReferenceValCode(PDA.STATEUID) state,  
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=STATEUID) 'stateuid.$oid',  
DBO.fGetReferenceValCode(PDA.CNTRYUID) country,  
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=CNTRYUID) 'countryuid.$oid',  
PDA.PINCODE zipcode,  
PDA.PHONENUMBER [contact.workphone],  
PDA.MOBILENUMBER [contact.mobilephone],  
null [contact.alternatephone],  
PDA.EMAILADDRESS [contact.emailid],  
null weburl,  
null [DEBTOR TYPE],  
(SELECT TOP 1 GUID FROM REFERENCEVALUE RF WHERE RF.UID=CRDTRMUID)'credittermuid.$oid',  
null creditlimit,  
--(select top 1 guid from bdmsofficeagent bo where bo.uid=pda.bdmsofficeagentuid and bo.statusflag='A') as   
null 'tpaagentuid.$oid',  
(select top 1 ic.guid from insurancecompany ic,insuranceplan ip where ic.uid=ip.IdentifyingUID and ip.PayorDetailUID=pda.uid and ic.statusflag='A')as 'payoruid.$oid',      
convert(bit,'false') isglmandatory,  
ISNULL((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=pda.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(hh,-5.30,pda.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                            
Isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=pda.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                      
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(hh,-5.30, pda.MWHEN) ) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                            
pda.statusflag statusflag,          
(select top 1 guid from healthorganisation where uid=pda.OwnerOrganisationUID) AS 'orguid.$oid',  
(select top 1 uid from healthorganisation where uid=pda.OwnerOrganisationUID) as orgcode,  
'payordetail' externaltablename,  
cast(pda.uid as nvarchar) externaluid  
FROM  
PAYORDETAIL PDa(NOLOCK)  
FOR JSON PATH) AS X  