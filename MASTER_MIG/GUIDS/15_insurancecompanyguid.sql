create VIEW insurancecompanyguid        
As        
SELECT        
(        
SELECT        
m.guid as  '_id.$oid',                                
m.statusflag statusflag,                
      
'PayorAgreement' externaltablename,        
m.uid externaluid        
        
FROM        
InsuranceCompany m        
    
       
for json path) as X 