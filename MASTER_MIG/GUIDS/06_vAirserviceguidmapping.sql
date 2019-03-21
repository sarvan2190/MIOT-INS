CREATE VIEW vAirserviceguidmapping  
As  
Select  
(  
select  
s.guid as '_id.$oid',   
isnull(S.CODE,cast(s.uid as nvarchar))code,  
LTRIM(RTRIM(S.NAME))name,  
  
S.UID externaluid    
  
  
FROM SERVICE S   
  
  FOR JSON PATH) AS X  
  
  