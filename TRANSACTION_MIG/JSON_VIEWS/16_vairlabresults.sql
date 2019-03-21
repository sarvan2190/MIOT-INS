CREATE  VIEW vairlabresults                         
AS                         
SELECT                         
(                        
SELECT         
PAT.guid 'patientuid.$oid' ,                        
PV.guid 'patientvisituid.$oid',                        
PO.GUID 'patientorderuid.$oid',                        
POD.GUID 'patientorderitemuid.$oid',                        
BI.GUID 'orderitemuid.$oid' ,                        
dbo.fGetcareproviderguid(POD.careprovideruid) 'careprovideruid.$oid',                        
REQ.statusflag ,                            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HOUR,-5.30,REQ.Cwhen )) as bigint) * 1000  AS NVARCHAR(50))   'createdat.$date.$numberLong' ,                                
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HOUR,-5.30,REQ.Mwhen) ) as bigint) * 1000  AS NVARCHAR(50))   'modifiedat.$date.$numberLong' ,                                
dbo.fgetcareproviderguid(REQ.Cuser) 'createdby.$oid',                            
dbo.fgetcareproviderguid(REQ.Muser) 'modifiedby.$oid' ,                        
dbo.fGetLocationGUID (REQ.OrderLocationUID) 'userdepartmentuid.$oid',                        
  '579b0cb3f3fd3fa90b83e339' 'statusuid.$oid' ,                        
  CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000',DATEADD(HOUR,-5.30,RT.ResultEnteredDttm) ) as bigint) * 1000  AS NVARCHAR(50))   'resultdate.$date.$numberLong' ,                          
dbo.fgetcareproviderguid(RT.ResultEnteredUserUID) 'resultuseruid.$oid' ,                        
  (SELECT top 1 GUID from HealthOrganisation where uid=po.ownerorganisationuid ) 'orguid.$oid' ,                        
  ( SELECT                         
   RI.GUID 'orderresultitemuid.$oid',                        
   RI.DisplyName 'name',                        
   dbo.fGetRfValAlternateName(RI.RVTYPUID) 'resulttype',                        
   RC.ResultValue 'resultvalue',                        
   dbo.fGetReferencevalueguid(RI.UnitOfMeasure) 'uomuid.$oid',                        
   dbo.fGetRfValDescription(RI.UnitOfMeasure) 'uomdescription',                        
   RC.ShortCode 'shorttext',                        
   RC.ReferenceRange 'normalrange' ,                        
   RC.comments,                        
   RRL.PrintOrder 'displayorder',                        
   REPLACE(IsAbnormal,'-','') 'HLN',                        
   RC.GUID '_id.$oid'     ,                  
   RC.UID externaluid                   
                        
  fROM                         
  RESULTComponent RC  INNER JOIN                        
  --ResultComponentGUIDS RGUID        
    --ON ( RC.ResultUID =RT.UID AND RC.STATUSFLAG='A'   )            
  --INNER JOIN             
  ResultItem RI    ON (RI.UID =RC.ResultItemUID  and RC.ResultUID =RT.UID AND RC.STATUSFLAG='A'  )            
  LEFT OUTER JOIN            
    RequestResultLink RRL ON ( RRL.ResultItemUID =RI.UID             
  AND RRL.RequestItemUID = RD.RequestitemUID  and rrl.statusflag='A'  )               
                 
                  
   for JSON PATH                         
  ) resultvalues,                        
  PO.OwnerOrganisationUID   ,                  
  REQ.UID externaluid,                  
  RD.UID externalrequestdetailuid,                  
  RT.UID externalresultuid        
  FROM                   
Request REQ(NOLOCK)       
INNER JOIN         
RequestDetail RD(NOLOCK) ON ( REQ.UID = RD.RequestUID )       
INNER JOIN         
Result RT(NOLOCK) ON (RT.RequestDetailUID = RD.UID)       
INNER JOIN      
Patientorder PO(NOLOCK) ON (PO.IdentifyinguID =REQ.UID AND  PO.IdentifyingType ='REQUEST' )      
INNER JOIN                  
PatientorderDetail POD(NOLOCK) ON (POD.PatientorderUID =PO.UID AND  POD.IdentifyingType ='REQUESTDETAIL'       
AND  POD.IdentifyingUID =RD.UID  )       
INNER JOIN      
PatientVisit PV(NOLOCK)  ON (PV.UID =PO.PatientVisitUID AND PV.UID =REQ.PatientVisitUID )      
INNER JOIN                    
BillableItem BI(NOLOCK) ON (BI.UID =POD.BillableitemUID AND BI.BSMDDUID  =1160   )       
INNER JOIN       
Patient PAT(NOLOCK) ON (PAT.UID =PV.PatientUID AND PO.PatientUID =PAT.UID AND RT.PATIENTUID=PV.PATIENTUID  )      
WHERE              
                            
 PO.StatusFlag='A'                          
AND POD.StatusFlag='A'                          
AND REQ.StatusFlag='A'               
AND RT.STATUSFLAG='A'         
AND RD.STATUSFLAG='A'        
AND PV.statusflag='A'        
AND PAT.STATUSFLAG='A'                  
 FOR JSON PATH) AS Y 