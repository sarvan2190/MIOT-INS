DROP TABLE GroupDiscount
GO
CREATE TABLE GroupDiscount(Payoragreementuid bigint,Serviceuid int,Pblctuid int,Discount float,ALLDIUID int,Statusflag nvarchar(2),
Ispercentage nvarchar(2),Externaluid int,guid nvarchar(50))
GO
insert into GroupDiscount(payoragreementuid,serviceuid,pblctuid,discount,alldiuid,STATUSFLAG,ispercentage,externaluid)
select distinct ad.payoragreementuid,ad.serviceuid,ad.pblctuid,ad.discount,ad.alldiuid,ad.STATUSFLAG,ad.ispercentage,AD.uid
FROM 
PAYORAGREEMENT PA,
AGREEMENTDETAILDISCOUNT AD,
SERVICE S
WHERE
AD.STATUSFLAG = 'A'
AND PA.UID = AD.PayorAgreementUID
AND PA.STATUSFLAG = 'A'
--AND (AD.DATETO IS NULL OR AD.DATETO>GETDATE())
AND S.UID = AD.SERVICEUID
AND S.STATUSFLAG = 'A'

UNION ALL
select distinct ad.payoragreementuid,ad.serviceuid,ad.pblctuid,ad.discount,ad.alldiuid,ad.STATUSFLAG,ad.ispercentage,AD.uid
FROM 
PAYORAGREEMENT PA,
AgreementAccountDiscount AD,
SERVICE S
WHERE
AD.STATUSFLAG = 'A'
AND PA.UID = AD.PayorAgreementUID
AND PA.STATUSFLAG = 'A'
--AND (AD.DATETO IS NULL OR AD.DATETO>GETDATE())
AND S.UID = AD.SERVICEUID
AND S.STATUSFLAG = 'A'
GO

DROP TABLE AGREEMENTEXCLUSION
GO

CREATE TABLE AGREEMENTEXCLUSION
(payoragreementuid int,serviceuid int,externaluid bigint)
go
insert into agreementexclusion(payoragreementuid,serviceuid,externaluid)
select  pa.uid,BCAAD.ServiceUID,BCAAD.uid
FROM
PAYORAGREEMENT PA,
AgreementDetail BCAAD

WHERE
PA.STATUSFLAG='A'
AND BCAAD.StatusFlag='A'
and BCAAD.StatusFlag='A'
and BCAAD.PayorAgreementUID=pa.UID
AND PA. AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('EXCLU','AGTYP'))


UNION ALL

select pa.uid,addt.ServiceUID,addt.uid
FROM
PAYORAGREEMENT PA,
AgreementAccountDetail ADDT

WHERE
PA.STATUSFLAG='A'
AND ADDT.StatusFlag='A'
and ADDT.PayorAgreementUID=pa.UID
AND PA. AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('EXCLU','AGTYP'))

go
DROP TABLE agreementinclusive
go

create table agreementinclusive
(payoragreementuid int,serviceuid int,externaluid bigint,guid nvarchar(50))
go

insert into agreementinclusive(payoragreementuid,serviceuid,externaluid )
select  pa.uid,BCAAD.ServiceUID,BCAAD.uid
FROM
PAYORAGREEMENT PA,
AgreementDetail BCAAD

WHERE
PA.STATUSFLAG='A'
AND BCAAD.StatusFlag='A'
and BCAAD.StatusFlag='A'
and BCAAD.PayorAgreementUID=pa.UID
AND PA. AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('INCLU','AGTYP'))


UNION ALL

select pa.uid,addt.ServiceUID,addt.uid
FROM
PAYORAGREEMENT PA,
AgreementAccountDetail ADDT

WHERE
PA.STATUSFLAG='A'
AND ADDT.StatusFlag='A'
and ADDT.PayorAgreementUID=pa.UID
AND PA. AGTYPUID IN(DBO.FGETREFERENCEVALUEUID('INCLU','AGTYP'))


GO