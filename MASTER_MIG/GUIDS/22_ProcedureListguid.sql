CREATE VIEW ProcedureListguid      
As      
SELECT      
(      
SELECT      
m.guid as  '_id.$oid',      
m.ProcedureCode code ,                                
m.statusflag statusflag,              
(select top 1 guid from healthorganisation where uid=2) AS 'orguid.$oid',      
(select top 1 uid from healthorganisation where uid=2) as orgcode,      
'ProcedureList' externaltablename,      
m.uid externaluid      
      
FROM      
ProcedureList m      
for json path) as X      
      