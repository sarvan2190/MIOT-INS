          
CREATE VIEW vAirPatientvisit              
as              
SELECT             
(            
SELECT             
pv.guid as '_id.$oid',            
(SELECT            
DISTINCT           
pvc.guid as '_id.$oid',            
(select top 1 guid from location L where l.uid=pvc.locationuid ) as 'departmentuid.$oid',              
(select top 1 guid from careprovider c where c.uid=pvc.careprovideruid ) as 'careprovideruid.$oid',            
(SELECT TOP 1 RF.guid FROM ReferenceValue RF WHERE RF.UID=PV.PACLSUID) AS 'visittypecuid.$oid',              
(SELECT TOP 1 RF.guid FROM ReferenceValue RF WHERE RF.UID=PV.priorityuid) as 'priorityuid.$oid',              
(SELECT TOP 1 RF.guid FROM ReferenceValue RF WHERE RF.UID=PV.PACLSUID) as 'statusuid.$oid',              
(SELECT TOP 1 RF.guid FROM ReferenceValue RF WHERE RF.UID=PV.entypuid) as 'entypeuid.$oid',              
--CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000',dateadd(hh,-7,startdttm)) as bigint) * 1000  AS NVARCHAR(50))  'startdate.$date.$numberLong' ,              
pvc.tokennumber as queuenumber,              
null as comments,              
pvc.uid as externalpvcuid,           
 CASE WHEN randomnumber='Y' THEN convert(bit,'true') else convert(bit,'false') end  isprimarycareprovider ,            
'PatientVisitCareprovider' as externaltablenamepvc             
FROM PATIENTVISITCAREPROVIDER PVC(NOLOCK)             
WHERE PVC.PATIENTVISITUID=PV.uid             
--AND PVC.CAREPROVIDERUID>0          
AND PVC.STATUSFLAG='A'          
FOR JSON PATH) AS  visitcareproviders,             
(SELECT            
PVP.guid as '_id.$oid',            
(select top 1 description from ReferenceValue rf where rf.uid=pvp.PAYRTPUID) as [orderofpreference],              
(select top 1 guid from InsuranceCompany  L where l.uid=PVP.CorporateUID ) as 'payoruid.$oid',                  
(select top 1 guid from PAYORAGREEMENT  PA where PA.uid=PVP.PayorAgreementuid ) as 'payoragreementuid.$oid',              
(select top 1 guid from PAYORDETAIL  PD where PD.uid=PVP.Payoruid ) as 'tpauid.$oid',              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,pvp.activefrom) ) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong' ,              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,pvp.[ActiveTo]) ) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong' ,              
null as policydetails,              
PVP.FixedCopayAmount as opdcoverperday,              
PVP.ClaimPercentage as claimpercentage,              
PVP.FixedCopayAmount as fixedcopayamount,              
PVP.Comments as comments,              
null as gldetailsuid,              
'PatientvisitPayor' as externaltableNamepvp,            
PVP.uid AS externalpvpuid            
FROM             
PATIENTVISITPAYOR PVP(NOLOCK)             
WHERE PVP.PATIENTVISITUID=PV.uid            
AND PVP.STATUSFLAG='A'              
and pvp.payoruid>0            
FOR JSON PATH) AS visitpayors,            
(            
select            
lt.guid as '_id.$oid',            
(SELECT TOP 1 GUID FROM LOCATION WHERE UID=LT.LOCATIONUID) as'warduid.$oid',              
(SELECT TOP 1 GUID FROM LOCATION WHERE UID=LT.BEDUID) as'beduid.$oid',              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,lt.EffectiveDttm) ) as bigint) * 1000  AS NVARCHAR(50))  'startdate.$date.$numberLong' ,              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,lt.mwhen) ) as bigint) * 1000  AS NVARCHAR(50))  'enddate.$date.$numberLong' ,              
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=LT.BDCATUID) as 'bedcategoryuid.$oid',              
(SELECT TOP 1 GUID FROM REFERENCEVALUE WHERE UID=LT.BDCATUID) as'bedpackageuid.$oid',              
convert(bit,'false') as isactive,              
null as isolatedbed,              
null as istemporarybed,              
null as 'parentbeduid.$oid',              
null as parentbedcode,              
null as  parentbeddesc,              
null as comments,              
lt.uid as externalpvpuid,              
'LocationTransfer' as externaltablenamebeds            
FROM               
LOCATIONTRANSFER LT(NOLOCK),            
LOCATION L(NOLOCK),            
PATIENADTEVENT PAE(NOLOCK)            
WHERE PV.UID=LT.PATIENTVISITUID            
AND LT.STATUSFLAG='A'         
AND L.UID=LT.LOCATIONUID            
AND L.STATUSFLAG='A'            
AND PAE.PatientVisitUID=PV.UID            
AND PAE.STATUSFLAG='A'            
and lt.BedUID in(select uid from location where statusflag='A')            
AND PAE.IDENTIFYINGTYPE='ADMISSIONEVENT'            
AND PV.PATIENTUID IN(SELECT UID FROM PATIENT WHERE STATUSFLAG='A')            
AND LT.BEDUID>0            
 FOR JSON PATH) AS bedoccupancy,               
dbo.fgetvisitid(pv.uid) as visitid,              
(SELECT TOP 1 GUID FROM ReferenceValue WHERE UID=pv.ENTYPUID) as 'entypeuid.$oid',                
--pv.ENCOUNTERTYPEDESCRIPTION as EncounterTypeDesc,              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,pv.StartDTTM) ) as bigint) * 1000  AS NVARCHAR(50)) AS 'startdate.$date.$numberLong' ,            
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000',dateadd(hh,-5.30, ISNULL(pv.EndDttm,PV.MWHEN))) as bigint) * 1000  AS NVARCHAR(50))  'enddate.$date.$numberLong',            
(SELECT TOP 1 GUID FROM ReferenceValue WHERE UID=pv.PACLSUID) as 'visitstatusuid.$oid',                  
null as isreadmission,              
null as ispatientpregnant,              
(select top 1 DBO.fGetReferenceValCode(DE.DSGDSUID) From Admissionevent AE(NOLOCK),DischargeEvent DE(NOLOCK) where DE.admissioneventuid=Ae.uid AND             
 AE.PatientVisituid=Pv.uid and AE.statusflag= 'A' and De.statusflag='A') as transfermode,             
pv.statusflag statusflag,            
(SELECT TOP 1 UID FROM PATIENT P WHERE P.UID=PV.PatientUID)as patientuidmain,              
(select top 1 guid from healthorganisation where uid=pv.OwnerOrganisationUID) as 'orguid.$oid',            
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', dateadd(hh,-5.30,pv.expectedDischargedttm )) as bigint) * 1000  AS NVARCHAR(50))  'expecteddischargedate.$date.$numberLong' ,            
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', (select top 1 dateadd(hh,-5.30,DE.MedicalDischargeDttm) From Admissionevent AE,DischargeEvent DE where DE.admissioneventuid=Ae.uid AND             
 AE.PatientVisituid=Pv.uid and AE.statusflag= 'A' and De.statusflag='A') ) as bigint) * 1000  AS NVARCHAR(50))  'medicaldischargedate.$date.$numberLong' ,              
CASE WHEN (SELECT TOP 1 P.ISMLC FROM PATIENT P(NOLOCK) WHERE P.UID=PV.Patientuid)='Y' THEN convert(bit,'true')          
ELSE convert(bit,'false') END  ismedicolegalcase,              
null complaintnumber,           
(SELECT TOP 1  pi.identifier FROM PATIENTVISITID PI          
WHERE PI.PATIENTVISITUID=PV.UID          
order by pi.uid asc)visitidbeforeconvert,          
CASE WHEN PV.UID IN(SELECT PV1.patientvisituid FROM PATIENTVISITID PV1(NOLOCK)           
GROUP BY PV1.PATIENTVISITUID HAVING COUNT(*) >1) THEN CONVERT(bit ,'true') else convert(bit,'false') END isconvertedfromopd,          
(            
SELECT            
(SELECT TOP 1 RF.GUID FROM ReferenceValue RF(NOLOCK) WHERE RF.UID=BR.RETYPUID) as 'reftypeuid.$oid',             
(select top 1 guid from healthorganisation hl where uid=pv.OwnerOrganisationUID and hl.statusflag='A') as 'referringorguid.$oid',              
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', BR.ReferralCreatedDttm)  as bigint) * 1000  AS NVARCHAR(50))  'referreddate.$date.$numberLong' ,                  
 BR.Comments as comments             
FROM             
Referral BR(NOLOCK)          
WHERE BR.PatientUID=PV.PatientUID          
         
AND (BR.RETYPUID IS NULL OR BR.RETYPUID > 0)            
AND BR.statusflag='A'            
FOR JSON PATH) AS refererdetail,              
(select top 1 guid from patient p(Nolock) where p.uid=pv.patientuid) as 'patientuid.$oid',              
dbo.fGetReferenceValCode(pv.paclsuid)  as PatientStatusCode,              (select top 1 dbo.fgetcareprovidercode(DE.RecordedBy,de.OwnerOrganisationUID) From Admissionevent AE,DischargeEvent DE where DE.admissioneventuid=Ae.uid AND             
 AE.PatientVisituid=Pv.uid and AE.statusflag= 'A' and De.statusflag='A') as dischargedcareprovider,              
(select top 1 DE.DischargeComments From Admissionevent AE,DischargeEvent DE where DE.admissioneventuid=Ae.uid AND             
 AE.PatientVisituid=Pv.uid and AE.statusflag= 'A' and De.statusflag='A') as dischargecomments,              
(select top 1 uid from healthorganisation where uid=pv.OwnerOrganisationUID)orgcode,            
ISNULL((select top 1 guid from careprovider where uid=pv.cuser),'5c7659e45d836f29be36758c') as 'createdby.$oid',            
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(Hh,-5.30,pv.CWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong' ,                                    
isnull((select top 1 guid from careprovider where uid=pv.muser),'5c7659e45d836f29be36758c') as 'modifiedby.$oid',                    
CAST(cast(DATEDIFF_big(s, '1970-01-01 00:00:00.000', DATEADD(HH,-5.30,pv.MWhen) ) as bigint) * 1000  AS NVARCHAR(50))  'modifiedat.$date.$numberLong' ,                                    
'patientvisit' as externaltablename,            
cast(pv.uid as nvarchar) externaluid            
FROM PATIENTVISIT PV (NOLOCK)          
FOR JSON PATH ) as X          