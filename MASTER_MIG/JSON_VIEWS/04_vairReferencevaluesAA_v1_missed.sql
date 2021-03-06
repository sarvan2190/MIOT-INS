CREATE VIEW vairReferencevaluesAA_v1_missed  
as        
SELECT        
(        
SELECT        
DISTINCT        
RF.GUID '_id.$oid',       
RF.ValueCode valuecode ,       
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(        
              LTRIM(RTRIM(rf.Description )), CHAR(9), ' '), CHAR(10), ' '), CHAR(11), ' '), CHAR(12), ' '), CHAR(13), ' ')))valuedescription,        
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(        
              LTRIM(RTRIM(rf.Description )), CHAR(9), ' '), CHAR(10), ' '), CHAR(11), ' '), CHAR(12), ' '), CHAR(13), ' '))) locallanguagedesc ,        
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-8, rf.ACTIVEFROM )) as bigint) * 1000  AS NVARCHAR(50))  'activefrom.$date.$numberLong',           
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', dateadd(HH,-8,  rF.ACTIVETO )) as bigint) * 1000  AS NVARCHAR(50))  'activeto.$date.$numberLong',           
null isdefault,        
CASE WHEN RF.DomainCode='PBMCD' THEN 'COMORB'      
WHEN RF.DomainCode='FORMM' THEN 'DGFORM'      
WHEN RF.DomainCode='ROUTE' THEN 'ROUTE'      
WHEN RF.DomainCode='ESDRGTP' THEN 'ESSNDG'      
WHEN RF.DomainCode='SLCTP' THEN 'FOLDTY'      
WHEN RF.DomainCode='TITLE' THEN 'TITLE'      
WHEN RF.DomainCode='NATNL' THEN 'NATNTY'      
WHEN RF.DomainCode='BLOOD' THEN 'BLDGRP'      
WHEN RF.DomainCode='BLDRH' THEN 'RHFACT'      
WHEN RF.DomainCode='SPOKL' THEN 'PRFLAN'      
WHEN RF.DomainCode='OCCUP' THEN 'OCCUPN'      
WHEN RF.DomainCode='RELTN' THEN 'NOKTYP'      
WHEN RF.DomainCode='RLNTP' THEN 'NOKTYP'      
WHEN RF.DomainCode='PAALI' THEN 'ALSTYP'      
WHEN RF.DomainCode='PITYP' THEN 'IDTYPE'      
WHEN RF.DomainCode='RAACE' THEN 'RACE'      
WHEN RF.DomainCode='MARRY' THEN 'MARTST'      
WHEN RF.DomainCode='RELGN' THEN 'RELGON'      
WHEN RF.DomainCode='ADTYP' THEN 'ADRTYP'      
WHEN RF.DomainCode='VISTY' THEN 'VSTTYP'      
WHEN RF.DomainCode='BKMOD' THEN 'BOKMOD'      
WHEN RF.DomainCode='RFRTP' THEN 'REFTYP'      
WHEN RF.DomainCode='CPTYP' THEN 'PROVIDERTYPE'      
WHEN RF.DomainCode='MDTRN' THEN 'TRNSMD'      
WHEN RF.DomainCode='CANRE' THEN 'CANRSN'      
WHEN RF.DomainCode='MDTRN' THEN 'TRNSPT'      
WHEN RF.DomainCode='MDTRN' THEN 'TRANSPORT'    
WHEN RF.DomainCode='DSOCM' THEN 'PATST'      
WHEN RF.DomainCode='SPMTP' THEN 'SPCMTY'      
WHEN RF.DomainCode='COLMD' THEN 'COLMTD'      
WHEN RF.DomainCode='MERUP' THEN 'MEMRPT'      
WHEN RF.DomainCode='LRDELI' THEN 'DLVYMD'      
WHEN RF.DomainCode='BDLOC' THEN 'BODYSI'      
WHEN RF.DomainCode='BODST' THEN 'BODYSI'      
WHEN RF.DomainCode='ABCAN' THEN 'ABCANL'      
WHEN RF.DomainCode='VENAN' THEN 'VENANL'      
WHEN RF.DomainCode='CRDTY' THEN 'CCTYPE'      
WHEN RF.DomainCode='PAYMD' THEN 'PAYMOD'      
WHEN RF.DomainCode='CURNC' THEN 'CURNCY'      
WHEN RF.DomainCode='PYRACAT' THEN 'ARCATY'      
WHEN RF.DomainCode='PBLCT' THEN 'TARIFF'      
WHEN RF.DomainCode='PAYTRM' THEN 'CRDTRM'      
WHEN RF.DOMAINCODE='IMUOM' THEN 'INVUOM'      
WHEN RF.DOMAINCODE='RQPRT' THEN 'ORDPRY'      
WHEN RF.DOMAINCODE='INSTYP' THEN 'INSTYP'      
WHEN RF.DOMAINCODE='PRTGP' THEN 'RESGRP'      
WHEN RF.DOMAINCODE='PATTP' THEN 'PATTYP'      
WHEN RF.DOMAINCODE='NATNL' THEN 'NATNTY'      
WHEN RF.DOMAINCODE='DESTIN' THEN 'TRNSMD'      
WHEN RF.DOMAINCODE='BDCAT' THEN 'BEDCAT'      
WHEN RF.DOMAINCODE='VIPTP' THEN 'VIPTYP'      
WHEN RF.DOMAINCODE='SCDTY' THEN 'PDOCTY'      
WHEN RF.DOMAINCODE='REFNET' THEN 'REFTYP'      
WHEN RF.DOMAINCODE='REFCAT' THEN 'REFTYP'---refertype      
WHEN RF.DOMAINCODE='PDSTS' THEN 'DGTAKE'      
WHEN RF.DOMAINCODE='REFST' THEN 'REFSTS'      
WHEN RF.DOMAINCODE='REFSN' THEN 'REFREASON'      
WHEN RF.DOMAINCODE='EVATY' THEN 'REFEVATYP'      
WHEN RF.DOMAINCODE='RFRTP' THEN 'REFERRERTYP'      
WHEN RF.DOMAINCODE='EMPST' THEN 'EMPSTS'      
WHEN RF.DOMAINCODE='RPRIT' THEN 'VSTPRY'      
WHEN RF.DOMAINCODE='FILST' THEN 'FLDSTS'      
WHEN RF.DOMAINCODE='BKSTS' THEN 'BOKSTS'      
WHEN RF.DOMAINCODE='RIUOM' THEN 'OBSUOM'      
WHEN RF.DOMAINCODE='PRDCAT' THEN 'PRDCAT'      
WHEN RF.DOMAINCODE='LOTYP' THEN 'LOCTYP'    
WHEN RF.DOMAINCODE='SCHVAL' THEN 'CODISC'    
WHEN RF.DOMAINCODE='REQRSN' THEN 'FLDRQP'    
WHEN RF.DOMAINCODE='CONTP' THEN 'CONTYP'    
WHEN RF.DOMAINCODE='DSHTYP' THEN 'ERDTYP'    
WHEN RF.DOMAINCODE='DCSTS' THEN 'PATSTS'    
WHEN RF.DOMAINCODE='INFCT' THEN 'INFTYP'    
WHEN RF.DOMAINCODE='BSMDD' THEN 'SRCTY'    
WHEN RF.DOMAINCODE='NRCTP' THEN 'NRCDRG'    
WHEN RF.DOMAINCODE='RISCT' THEN 'ALRTYP'    
WHEN RF.DOMAINCODE='CMPTP' THEN 'PYRTYP'    
WHEN RF.DOMAINCODE='ALRGN' THEN 'DCODTY'    
WHEN RF.DOMAINCODE='AGUOM' THEN 'AGEGRP'    
else RF.DomainCode    
 END  domaincode,        
'5b862a913238d86bf03aa787' AS 'createdby.$oid',                                 
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-8, rf.CWHEN) ) as bigint) * 1000  AS NVARCHAR(50))  'createdat.$date.$numberLong',                                  
'5b862a913238d86bf03aa787' AS 'modifiedby.$oid',                            
CAST(cast(DATEDIFF_BIG(s, '1970-01-01 00:00:00.000', DATEADD(HH,-8, rf.MWHEN )) as bigint) * 1000  AS NVARCHAR(50)) 'modifiedat.$date.$numberLong',          
null relatedvalue,        
null displayorder,        
rf.uid externaluid ,      
rf.AlternateName alternatename,      
rf.statusflag statusflag,      
'569794170946a3d0d588efe6' 'orguid.$oid'        
      
from ReferenceValue rf       
where rf.domaincode   in('BLOOD','RITRACE','RIPOS','MB003','AURNC','APERN','PUSCL','REECT','Exam','LABPN','DIRSEM','CTRGR','STYPHI','GRAMSMEAR','AFBSMEAR','FUNGLSMEAR','HANGSMR','CLNCNT','CLTRCMNTS','MISPEC','RPRVALUE','TITERVALUE','BBPN','BBGRP','MCUM','
MCUP','MCUR','')  
--and rf.statusflag='A'      
for json path) as X   
  
  