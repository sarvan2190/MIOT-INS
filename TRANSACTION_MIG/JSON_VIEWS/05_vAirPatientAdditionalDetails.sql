CREATE VIEW vAirPatientAdditionalDetails            
AS            
SELECT (            
SELECT                 
(SELECT             
pa.guid as'_id.$oid',                  
(SELECT TOP 1 GUID FROM ReferenceValue WHERE uid=pa.PAALIUID) as 'aliastypeuid.$oid',                
(SELECT TOP 1 ValueCode FROM ReferenceValue WHERE uid=pa.PAALIUID) as [aliastypecode],                
(SELECT TOP 1 Description FROM ReferenceValue WHERE uid=pa.PAALIUID) as [aliastypeDesc],                
pa.Forename as  firstname,                  
pa.MiddleName as  middlename,                  
pa.Surname as  lastname,                
pa.uid externaluid,                
'patientalias' externaltablename                
from patientalias pa                 
where pa.patientuid=PAT.UID                
and pa.statusflag='A'                
for json path) as aliasnames,                
(select                
pad.guid as '_id.$oid',                
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=ADTYPUID ) as   'addresstypeuid.$oid',                 
isnull(PAD.line1,'')+isnull(PAD.line2,'')+isnull(PAD.line3,'')+isnull(PAD.line4,'') as [addlnaddresses.Address],                
(select top 1 guid from referencevalue where uid=pad.areauid) as'areauid.$oid',                   
(select top 1 description from referencevalue where uid=pad.areauid) as [areadesc],                
(select top 1 guid from referencevalue where uid=pad.CITTYUID) as'cityuid.$oid',                   
(select top 1 description from referencevalue where uid=pad.CITTYUID) as [citydesc],                
(select top 1 guid from referencevalue where uid=pad.STATEUID) as 'stateuid.$oid',                   
(select top 1 guid from referencevalue where uid=pad.CNTRYUID) as 'countryuid.$oid',                
(select top 1 ValueCode from referencevalue where uid=pad.CNTRYUID) as[countrycode],                
(SELECT TOP 1 pincode FROM PinCodeMapping WHERE pincode=PAD.PINCODE) as [zipcode],                
(SELECT TOP 1 GUID FROM PinCodeMapping WHERE pincode=PAD.PINCODE) as 'zipcodeuid.$oid',                
cast(pad.uid as nvarchar) externaluid,                
'patientaddress'externaltablename                
FROM PatientAddress PAD                
WHERE PAD.PATIENTUID=PAT.UID              
AND PAD.ADTYPUID <> dbo.fGetReferencevalueUID('DEFADD' ,'ADTYP')            
and pad.statusflag='A'                
FOR JSON PATH) AS addlnaddresses,                 
(SELECT                 
          
pd.guid as '_id.$oid',              
(SELECT TOP 1 GUID FROM REFERENCEVALUE R WHERE R.UID=PD.PITYPUID) as  'idtypeuid.$oid',                    
(SELECT TOP 1 description FROM REFERENCEVALUE R WHERE R.UID=PD.PITYPUID) as [idtypeDesc],                
pd.identifier as [iddetail],                
pd.uid as patientiduid                
FROM PATIENTID PD                
WHERE PD.PATIENTUID=PAT.UID                
and pd.statusflag='A'                
for json path ) as addlnidentifiers,                
(select                
ppc.guid as '_id.$oid',              
(select top 1 GUID from referencevalue where uid=PPC.RLNTYUID) as 'reltypeuid.$oid',                    
(select top 1 guid from patient where uid=ppc.sourcepatientuid)'patientuid.$oid',                
ISNULL(ppc.Forename,'') nokname,                
ISNULL(''+ppc.Middlename,null) middlename,                
ISNULL(''+ppc.Surname,null)lastname,                
(select top 1 GUID from referencevalue where uid=PPC.SEXXXUID) as 'genderuid.$oid',                  
(select top 1 GUID from referencevalue where uid=PPC.TITLEUID) as 'titleuid.$oid',          
null as [notes],                 
convert(bit,'false') as [sameaddress],                
isnull(PPC.line1,'')+isnull(PPC.line2,'')+isnull(PPC.line3,'')+isnull(PPC.line4,'') as   [address.address],                 
(select top 1 guid from referencevalue where uid=PPC.areauid) as'address.areauid.$oid',                   
(select top 1 description from referencevalue where uid=PPC.areauid) as [address.area],                
(select top 1 guid from referencevalue where uid=PPC.CITTYUID) as'address.cityuid.$oid',                   
(select top 1 description from referencevalue where uid=PPC.CITTYUID) as [address.city],                
(select top 1 guid from referencevalue where uid=PPC.STATEUID) as 'address.stateuid.$oid',                   
(select top 1 description from referencevalue where uid=PPC.STATEUID) as [address.state],            
(select top 1 guid from referencevalue where uid=PPC.CNTRYUID) as 'address.countryuid.$oid',                
(select top 1 ValueCode from referencevalue where uid=PPC.CNTRYUID) as[address.country],                
(SELECT TOP 1 pincode FROM PinCodeMapping WHERE pincode=PPC.PINCODE) as [address.zipcode],                
(SELECT TOP 1 GUID FROM PinCodeMapping WHERE pincode=PPC.PINCODE) as 'address.zipcodeuid.$oid',            
replace(ppc.MobileNo,'-','') as 'contact.mobilephone',          
replace(ppc.ContactNumber,'-','') as 'contact.workphone',          
null as [nationalid],                  
null as [natidexpirtydate],                
ppc.uid externaluid,                
'patientpersonalcarer' externaltablename                
FROM PatientPersonalCarer PPC                
WHERE PPC.patientuid=pat.uid                
and ppc.statusflag='A'                
for json path) as nokdetails,                
(select                
 pd.employeename as employeename,                
 pd.employeenumber as employeenumber,                
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pd.startdttm) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',                                      
 CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pd.EndDttm) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',                
 (select  top 1 guid from referencevalue rf where rf.uid=pd.empstuid )'employeestatusuid.$oid',                
 (select  top 1 guid from referencevalue rf where rf.uid=pd.rlntyuid )'relationshipuid.$oid',                
 null plancode,                
 null welfareflag,                
 null deptcodefullforsap,                
 null empnumberForsap,                
 null idcard,           
 pd.comments as comments                                       
from patientemployerdetail pd                
where pd.patientuid=pat.uid                
and pd.statusflag='A'                
FOR JSON PATH) AS employeedetails,                
(select distinct                  
replace(dbo.fGetPatientContactByType(PAT.UID,1),'-','') [workphone],                
REPLACE(dbo.fGetPatientContactByType(PAT.UID,2),'-','') [mobilephone],                
dbo.fGetPatientContactByType(PAT.UID,3) [emailid]                
from patientothercontact poc                
where poc.patientuid=pat.uid                
and poc.statusflag='A'                
for json path) as addlncontacts,     
               
Pat.GUID as 'patientuid.$oid',                
cast(pat.uid as nvarchar) as externaluid,                
'Patient'ExternalIdentifer,                
isnull((select top 1 guid from careprovider c where c.uid=pat.cuser),'5c7659e45d836f29be36758c') AS 'createdby.$oid',                                     
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pat.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                      
isnull((select top 1 guid from careprovider c where c.uid=pat.muser),'5c7659e45d836f29be36758c') AS 'modifiedby.$oid',                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pat.MWhen)) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',                                      
PAT.statusflag,                    
(SELECT TOP 1 GUID FROM HealthOrganisation WHERE uid=PAT.OwnerOrganisationUID) AS 'orguid.$oid'                
                   
FROM                          
                
DBO.Patient PAT       
        
FOR JSON path)  AS y     