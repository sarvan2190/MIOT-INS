CREATE VIEW PINCODEMAPPINGguid          
As          
SELECT          
(          
SELECT          
m.guid as  '_id.$oid',          
m.CITTYUID CITTYUID ,     
m.AREAUID areauid,                                 
m.statusflag statusflag,                  
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',          
(select top 1 uid from healthorganisation where uid=2) as orgcode,          
'ProcedureList' externaltablename,          
m.uid externaluid          
          
FROM          
PINCODEMAPPING m          
for json path) as X       
    