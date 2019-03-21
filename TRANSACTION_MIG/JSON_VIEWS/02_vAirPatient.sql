CREATE VIEW vAirPatient                                  
AS                                      
SELECT               
(                                      
SELECT                
         
pat.guid as '_id.$oid',              
(select top 1 guid '_id.$oid' from referencevalue rf               
where domaincode='RNEWS'              
and rf.uid=pat.RNEWSUID  for json path)as 'hospitalnewstypeuids',              
PAT.PASID mrn,                                        
PAT.Comments notes,                                       
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAT.TITLEUID) titlecode,                                  
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.TITLEUID)'titleuid.$oid',                                  
CASE WHEN ISANONYMOUS='Y' THEN (SELECT TOP 1 PA.FORENAME FROM  PatientAnonymization PA WHERE PA.PATIENTUID=PAT.UID) ELSE Pat.FORENAME END firstname,                                        
CASE WHEN ISANONYMOUS='Y' THEN (SELECT TOP 1 PA.MIDDLENAME FROM PatientAnonymization PA WHERE PA.PATIENTUID=PAT.UID) ELSE Pat.MIDDLENAME END middlename,              
CASE WHEN ISANONYMOUS='Y' THEN (SELECT TOP 1 PA.Surname FROM PatientAnonymization PA WHERE PA.PATIENTUID=PAT.UID) ELSE Pat.Surname END lastname,              
(select top 1 pim.guid from patientimage pim where pim.patientuid=pat.uid and pim.statusflag='A')'patientimageuid.$oid',              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,registrationdttm)) as bigint) * 1000 AS NVARCHAR(50))  'registereddate.$date.$numberLong',                                  
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAT.SEXXXUID)gendercode,                                                   
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.SEXXXUID)'genderuid.$oid',  --SEXXX                                        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,PAT.BirthDttm) ) as bigint) * 1000  AS NVARCHAR(50))  'dateofbirth.$date.$numberLong',                                        
 CASE WHEN PAT.DOBComputed = 1 THEN convert(bit,'true') ELSE convert(bit,'false') END isdobestimated,                                        
null isbuddhistdate,                  
SUBSTRING(PASID, PATINDEX('%[^0]%',PASID), 20) internalmrn,              
(SELECT TOP 1 ID.IDENTIFIER FROM PATIENTID ID(NOLOCK)  WHERE ID.PATIENTUID=PAT.UID AND ID.STATUSFLAG='A' AND ID.PITYPUID=1635)tempmrnid,                 
CASE WHEN exists (SELECT top 1 PM.ISUNMERGE  FROM PATIENTMERGE PM(NOLOCK) WHERE PM.MINORPATIENTUID=PAT.UID) THEN CONVERT(bit,'true') else CONVERT(bit,'false') end ispatientmerged,              
(SELECT TOP 1 P.GUID FROM PATIENTMERGE PM(NOLOCK), PATIENT P(NOLOCK) WHERE PM.MINORPATIENTUID=P.UID AND PM.MAJORPATIENTUID=PAT.UID AND PM.STATUSFLAG='A')  'mergedpatientuid.$oid',                                           
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=OCCUPUID)'occupationuid.$oid',                                        
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=SPOKLUID) 'preflanguid.$oid',                                        
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.MARRYUID)'maritalstatusuid.$oid',                                
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAT.NATNLUID)nationalitycode,                                               
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.NATNLUID)'nationalityuid.$oid',                                      
--(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.RNEWSuid)'hospitalnewstypeuids.$oid',                                      
CASE WHEN ISANONYMOUS='Y' then convert(bit,'true') else convert(bit,'false') end isanonymous,                                      
CASE WHEN ISVIP ='Y' THEN convert(bit,'true') else convert(bit,'false') END isvip,              
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.viptpuid) 'viptypeuid.$oid',                                                    
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.RELGNUID)'religionuid.$oid',                                     
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.RELGNUID)'bloodgroupuid.$oid',             
null raceuid,                    
CASE WHEN IsInterpreterRqrd ='Y' THEN convert(bit,'true') else convert(bit,'false') END  isinterpreterreqd,                                                              
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAT.PATTPUID)'patienttypeuid.$oid',                                 
dbo.fGetPatientIDByType(PAT.UID,DBO.fGetReferenceValueUID('NATID','PITYP')) nationalid,                                    
(select top 1 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', id.activeto ) as bigint) * 1000  AS NVARCHAR(50))               
activeto from patientid id where id.patientuid=pat.uid and pitypuid=13692) 'natidexpirtydate.$date.$numberLong',                                             
ISNULL(PAD.Line1,null) + ISNULL(' '+PAD.Line2,null) + ISNULL(' '+PAD.Line3,null) + ISNULL(' '+PAD.Line4,null) as [address.address],                                  
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAD.AREAUID)[address.area],                  
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAD.AREAUID) as 'address.areauid.$oid',                                           
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAD.CITTYUID)as [address.city],                  
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAD.CITTYUID) as 'address.cityuid.$oid',                  
(SELECT TOP 1 valuecode FROM REFERENCEVALUE WHERE UID=PAD.STATEUID) as [address.state],                                    
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAD.STATEUID) as 'address.stateuid.$oid',                                    
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=PAD.CNTRYUID)  as 'address.countryuid.$oid',                                   
(SELECT TOP 1 VALUECODE FROM REFERENCEVALUE WHERE UID=PAD.CNTRYUID)  as [address.country],                  
pad.pincode [address.zipcodecode],                  
(SELECT TOP 1 GUID FROM pincodemapping WHERE PINCODE=PAD.pincode) 'address.zipcodeuid.$oid',                  
null workphone,                      
replace(dbo.fGetPatientContactByType(PAT.UID,1),'-','')[contact.homephone],                      
replace(dbo.fGetPatientContactByType(PAT.UID,2),'-','')[contact.mobilephone],                      
null [contact.alternatephone],                      
dbo.fGetPatientContactByType(PAT.UID,3)[contact.emailid],                   
NULL as weburl,                  
CASE WHEN EXISTS(SELECT 1 FROM PATIENTEMPLOYERDETAIL PD WHERE PD.PATIENTUID=PAT.UID) THEN CONVERT(BIT,'true') ELSE CONVERT(BIT,'false') end isemployee,              
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PAT.CUSER),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                       
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', Dateadd(HH,-5.30,pat.CWHEN)) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                        
isnull((SELECT TOP 1 GUID FROM CAREPROVIDER C WHERE C.UID=PAT.MUSER),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                                  
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',  Dateadd(HH,-5.30,pat.MWHEN)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                        
PAT.STATUSFLAG statusflag,                      
(select top 1 guid from healthorganisation where uid =pat.OwnerOrganisationUID) AS 'orguid.$oid',                  
PAT.UID externaluid   ,              
'patient'externaltablename              
                                   
FROM                                        
Patient PAT (NOLOCK)              
OUTER APPLY (SELECT TOP 1 PAD.Line1,PAD.Line2,PAD.Line3,PAD.Line4,PAD.AREAUID,PAD.CITTYUID,PAD.STATEUID,PAD.CNTRYUID,PAD.Pincode                  
,PAD.ADTYPUID  FROM PatientAddress(NOLOCK) PAD WHERE PAD.StatusFlag = 'A' AND PAD.PatientUID = PAT.UID AND PAD.ADTYPUID = DBO.fGetReferenceValueUID('DEFADD','ADTYP')) PAD                  
FOR JSON path)                                      
AS Y  
  
  