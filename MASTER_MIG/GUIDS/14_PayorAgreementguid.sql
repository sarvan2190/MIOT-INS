CREATE VIEW PayorAgreementguid        
As        
SELECT        
(        
SELECT        
m.guid as  '_id.$oid',                                
m.statusflag statusflag,                
      
'PayorAgreement' externaltablename,        
m.uid externaluid        
        
FROM        
PayorAgreement m        
    
       
for json path) as X 