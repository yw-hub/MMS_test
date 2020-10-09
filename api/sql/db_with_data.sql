CREATE DATABASE  IF NOT EXISTS `medsec` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `medsec`;
-- MySQL dump 10.13  Distrib 5.7.22, for osx10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: medsec
-- ------------------------------------------------------
-- Server version 5.7.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Appointment` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `did` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `detail` longtext DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `date_change` datetime NOT NULL,
  `date` datetime NOT NULL,
  `duration` int(45) NOT NULL,
  `note` longtext DEFAULT NULL,
  `user_note` longtext DEFAULT NULL,
  `status` enum('UNCONFIRMED','CONFIRMED','CANCELLED') DEFAULT 'UNCONFIRMED',
  PRIMARY KEY (`id`),
  KEY `fk_Appointment_Patient1_idx` (`uid`),
  KEY `did` (`did`),
  CONSTRAINT `Appointment_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `User` (`id`),
  CONSTRAINT `Appointment_ibfk_3` FOREIGN KEY (`did`) REFERENCES `Doctor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Appointment` (`id`, `uid`, `did`, `title`, `detail`, `date_create`, `date_change`, `date`, `duration`, `note`, `user_note`, `status`) VALUES
(1, 1,  1,  'Day Oncology Unit',  'Education session',  '2020-05-01 00:00:00',  '2020-05-18 04:05:16',  '2020-06-20 14:15:00',  15, 'Looking after yourself during chemotherapy - Watch Patient Health History Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au Parking Information - ReadQuestions Sheet - Read', NULL, 'UNCONFIRMED'),
(2, 2,  2,  'Day Oncology Unit',  'Education session',  '2020-05-01 00:00:00',  '2020-05-18 04:05:16',  '2020-06-22 14:15:00',  15, 'Looking after yourself during chemotherapy - Watch Patient Health History Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au Parking Information - ReadQuestions Sheet - Read', 'test', 'CONFIRMED'),
(3, 2,  2,  'Day Oncology Unit',  'Education session',  '2020-05-01 00:00:00',  '2020-05-18 04:05:16',  '2020-06-30 14:15:00',  15, 'Looking after yourself during chemotherapy - Watch Patient Health History Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au Parking Information - ReadQuestions Sheet - Read', NULL, 'CONFIRMED'),
(131828,  4598, 5,  'PICKERING Susan',  'CS', '2020-09-14 00:00:00',  '2020-09-14 04:15:07',  '2020-09-10 10:20:00',  20, 'Treatment at 12:30pm at Day Onc. Appt in 3 mths with CT/PET scan and bloods prior.', 'ask about scan also resul5s',  'CONFIRMED'),
(131829,  5774, 5,  'SMITH Christopher',  'Chemo',  '2020-09-14 00:00:00',  '2020-09-14 04:14:34',  '2020-09-10 09:40:00',  20, 'Appt in 3 weeks with bloods prior. Appt with Dr Lontos next week. Email bloods.',  NULL, 'UNCONFIRMED'),
(131830,  5774, 5,  'SMITH Christopher',  'CS', '2020-09-14 00:00:00',  '2020-09-14 04:22:31',  '2020-09-17 09:50:00',  10, 'Review next week.',  NULL, 'UNCONFIRMED'),
(131832,  4598, 5,  'PICKERING Susan',  'CS', '2020-09-14 00:00:00',  '2020-09-14 04:22:40',  '2020-09-17 10:30:00',  10, 'Review with bloods in 2 weeks',  NULL, 'CONFIRMED');

DROP TABLE IF EXISTS `Doctor`;
CREATE TABLE `Doctor` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `expertise` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Doctor` (`id`, `name`, `bio`, `address`, `phone`, `fax`, `email`, `website`, `expertise`) VALUES
(1, 'Prof Niall Tebbutt', 'http://www.darebinstspecialistcentre.com.au/prof-niall-tebbutt', '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist'),
(2, 'Dr Yvonne Yeung',  'http://www.darebinstspecialistcentre.com.au/dr-yvonne-yeung',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist'),
(3, 'A/Prof Andrew Weickhardt', 'http://www.darebinstspecialistcentre.com.au/aprof-andrew-weickhardt',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist'),
(4, 'Dr Sagun Parakh',  'http://www.darebinstspecialistcentre.com.au/dr-sagun-parakh',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist'),
(5, 'Dr Belinda Yeo', 'http://www.darebinstspecialistcentre.com.au/dr-belinda-yeo', '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist'),
(6, 'Dr Ruwani Mendis', NULL, '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Medical Oncologist/Palliative Care Physician'),
(7, 'Dr Mark Goodwin',  'http://www.darebinstspecialistcentre.com.au/dr-mark-goodwin',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Intervential Radiologist'),
(8, 'Dr Dinesh Ranatunga',  'http://www.darebinstspecialistcentre.com.au/dr-dinesh-ranatunga',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', 'Intervential Radiologist'),
(9, 'Sharon Turner',  'http://www.darebinstspecialistcentre.com.au/sharon-turner',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', NULL),
(10,  'Sophie Skalkos', 'http://www.darebinstspecialistcentre.com.au/sophie-skalkos', '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', NULL),
(11,  'Dale Ishcia',  'http://www.darebinstspecialistcentre.com.au/dale-ischia',  '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', NULL),
(12,  'Lauren Young', 'http://www.darebinstspecialistcentre.com.au/lauren-young', '66 Darebin Street, Heidelberg VIC 3084', '(03) 9458 5100', '(03) 9458 5199', 'reception@66darebinst.com.au', 'www.darebinstspecialistcentre.com.au', NULL);

DROP TABLE IF EXISTS `File`;
CREATE TABLE `File` (
  `id` int(11) NOT NULL,
  `apptid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link` (`link`),
  KEY `apptid` (`apptid`),
  CONSTRAINT `File_ibfk_2` FOREIGN KEY (`apptid`) REFERENCES `Appointment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- INSERT INTO `File` (`id`, `apptid`, `title`, `link`) VALUES
-- (1, 1,  'File-sample-1.pdf',  '/result/1/File-sample-1.pdf'),
-- (2, 2,  'File-sample-2.pdf',  '/result/2/File-sample-2.pdf'),
-- (3, 3,  'File-3.pdf', '/result/3/File-3.pdf'),
-- (131828,  131828, 'File-sample-131828.pdf', '/result/131828/File-sample-131828.pdf'),
-- (131829,  131829, 'File-sample-131829.pdf', '/result/131829/File-sample-131829.pdf');

DROP TABLE IF EXISTS `Hospital`;
CREATE TABLE `Hospital` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `emergencyDept` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `aftPhone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Hospital` (`id`, `name`, `address`, `emergencyDept`, `phone`, `aftPhone`, `fax`, `email`, `website`) VALUES
(1, 'Warringal Private Hospital', '216 burgundy Street, Heidelberg VIC 3084', 'No', '(03) 9274 1300', NULL, '(03) 9459 7606', NULL, 'https://www.warringalprivate.com.au'),
(2, 'Warringal Day Oncology Unit',  '8 Martin Street, Heidelberg VIC 3084', 'No', '(03) 9274 1423', NULL, NULL, 'daychemo.wrp@ramsayhealth.com.au', 'https://www.warringalprivate.com.au/Our-Services/Day-Oncology-Centre'),
(3, 'Austin Hospital',  '145 Studley Rd, Heidelberg VIC 3084',  'Yes. Open 24 hours', '(03) 9496 5000', NULL, '(03) 9458 4779', NULL, 'https://www.austin.org.au'),
(4, 'Austin Repatriation Hospital', '300 Waterdale Road, Ivanhoe Victoria 3079',  'No', '(03) 9496 5000', NULL, '(03) 9496 2541', NULL, 'https://www.austin.org.au/heidelberg-repatriation-hospital'),
(5, 'Olivia Newton-John Cancer Wellness and Research Centre', '145 Studley Road, Heidelberg Victoria 3084', 'No', '(03) 9496 5000', NULL, '(03) 9458 4779', NULL, 'https://www.onjcancercentre.org');

DROP TABLE IF EXISTS `NotificationToken`;
CREATE TABLE `NotificationToken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `fcm_token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_fcm_token` (`uid`,`fcm_token`),
  KEY `fk_NotificationToken_User_idx` (`uid`),
  CONSTRAINT `NotificationToken_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `NotificationToken` (`id`, `uid`, `fcm_token`) VALUES
(115, 1,  'c981zn0iXnc:APA91bF-cXpzA3v2Uk2de746joKRB73OLjj0RJMq8iGRVhr0w4pSMWsC6by3TSleD2NbK3iMJ0DHjlAitK52jdnYbfW5vSDvMatkTBizYLBtYPHkBhLS9AiwK5rrEPmJ79uzidf2i8Lr'),
(186, 1,  'cAp6VHNhQR8:APA91bFbzJbA2HXzYLN733O2V7A3b4AocQl-OuloEiJnfqAM12PvggBym5pN0AwhGuEMfhc5QGTciSOR9um1FReNrjBv-uhWPTg7ZG92kM0deYNHLAI3aecJq77SbsDYFWGMXI2T90hR'),
(135, 1,  'cbQq3biBdcY:APA91bGenWLe9VSq4P7fQB8f2TdnLiuQhOeXUSxEtsXdYKmExJ4jlLkn6APc2GvcgG3Om59L7SP0tWr89Yfjo25AdhJgGrhbrv3a_MUEg2aKuEX1iMvZfDqyWJchTX_7RCEMahvA4wfw'),
(140, 1,  'cKc8WtM40A4:APA91bEWap50UqiBaqpj6hTU4_VsX_qccT1i-tDnsYbK_23KZiGOKF5LIHnbQNetuL_dqsJtxRByIh3zCHrjPV5bdK7y7q0dgLfAfV-ykXxZ-q0IjJPiltXVI0574NUkDuTY6PCj1Rqc'),
(114, 1,  'cTt68GCxobs:APA91bEksB-nhK7ZrIu1l91l2I3-JMwX-QvJ7uFAMK3WKzOltY2GX5z1tgN69xjW1CYTy9koUWKgBO-DZ-rLHq0UbLCVdrHbjU_KkxY6RlYq4Jj6-T3ZPSsXvUseABaLAip7J78VR0qq'),
(198, 1,  'cvGRhK8mwt0:APA91bGQHRmiWMVSXy2izu2ex2FTZYOFJiHPgkJQKHFKgzy80toX35roe3l473qY3Ql_hVgC_gcj8qfWVHZ-vy4rw1kwGUUg8IK7G5yhrXeDl1XlzkYgAJ1ths7AH742rYRyT9fXusKr'),
(249, 1,  'cvWXN5FUY5g:APA91bE7u9DXTcXmpbIRc9Hkur3phpgtbvqvOhuYZzY4n_I5jR4QoUecOE4dZGnHkfPGMU6eP83Elq1s6cjIP6vTHRjpoNQITY-ycHSj06VOG05ok6NLiRO1_Yx-YNWkGtRy8pp_8yXj'),
(117, 1,  'dGZf4E4WBB4:APA91bELZZP8_t1HVnn_dNg7XypyNzpOobs_qBm45txOctLUzJrekZsjGVBlLBAf6oFQXQbd2x5tNB056hXNI-B8-5Ht4T2qZ3P7mTMonxdN8_NwHEB4pXqM88uACEMh2ogpTfyiEqw4'),
(211, 1,  'dme1fbmqu3I:APA91bEpVHe0GiNy6la2v3zgiyjn4rziMJ-Wn7vDPIMTwg1zY55eXFcQz4kPnO9ZFYNU0_st4ExGuDb5jBZgMjKS3mRAjw4PBP9c4pQn395tTelTtoaxa6NhRhhZkmQ-IAmb_smTrk7n'),
(287, 1,  'dZpS10iVJCc:APA91bE1iMW_0AyDmUHINv1o28NFhzwh7t0mL2LNxz2--ZDar4ZTninCZv8Yu7xgcLuMBO98iRof4IyC8xREzsSz-DJA8UoPtmzKOc42YZ2C5GTAl9q6ezuJAtbGIDd1NZIPbxYp7_Pg'),
(243, 1,  'dZpS10iVJCc:APA91bErH2hPInJAnP2kuZXMrg-5wI-AqgjS2a0sEjnQDiOG57JkV6q8-WdeISF6wSA_IkG_O8NoWKCBWc-WXvzCK4tsCXk6PnptbWssdvcChY6mrdVjhs_KMCjmTwSIimt4tEBvHmuI'),
(247, 1,  'eNBD_AAenWw:APA91bHHmRZWBCs61CJ37tgMZtBJ5gZL9KvpNdNDuXaehSgtzNeXSuz2R3ROmsKydT2jmBjs-NWgzReSdz0srkXCNthTr6BNQb53X5LQgWCHcIQcI_Iq31qDfeLLZSACd0-VkZVbbrFJ'),
(176, 1,  'eNBD_AAenWw:APA91bHr7m28C5l9JuS8vk8c8phsskoGLIJ-TfaGVOiFGZT_qb0gMmnzwGU6Yk62KAlcdOy5uwfFkKHmIZyvgI8HizmZ6x3RuEffKsnEOcp-PtNcHA5kYU0E2tx69YRWXu8MV-55o9Yh'),
(118, 1,  'ew1JGnBiCAg:APA91bGH1DM23BEav8aSUd_YX8jauEFsSLftVO7FL3j9VW3lrxMbzDHRArL6uH4z1CjA4KaC_USSqVV4Z7v0ZUJDs-lQkHA44hNzaRoj_e9WNNZHgIQ9nE48qAad0B639jaT-HUXwTwC'),
(168, 1,  'eZe7h4nJ7eg:APA91bEYGQUfrcISorBnvzKBxIutzm66BRpqmRRsIWtEhle6sUG-8ZmSwtnICy_zCKbR-zDGYd0h5fFznIkL3Kt2N2fD3_aCCQf2_OTqgUfD8UHB3KqLoS2jBBWoTL0DMRB15QlWTZXV'),
(119, 1,  'fC7huI8eLn8:APA91bEcFpN-5u_xVW07j60vmX1QxKR0n6UZAdI-RRi81iynH0acyIz5L_7JefF9MNYqfBCGvWPscLRFxghAV2dYu6PyGTYDce6X7qmcoln6KzvqvbmusgfGdv2OXL37XAOhZn4s7d0P'),
(164, 1,  'fJXmC2wUMc0:APA91bFOctx84QFeWE1q2WnVHHkFPEJjmruwIr-XsOUqgWxgbCe_KsnekzxJ_MpuBTFdmMTucBa5R8rnfSjwapqMlChGkimXgMuM7EvKZIGgLguhjn9DIWf35KHICAeEIc4FV83leGh7'),
(232, 1,  'fXK0m8q4-ZQ:APA91bFQIrYxqFP-dqL21PE6FWN0WiAUqZ1-n5J2GHAEonbnm-3_v22J0joybk3cTudg0zn3cRpIphcLJu6LwOlnVMJ8175h3M3s9io_k1y9qqIraeiHXE8kwtrbjX0FkkpYPr7ozGBq'),
(150, 2,  'c2npw5McqF0:APA91bGh91cZubzNVKKQgHxsXx7zdWTgHzBI8_bKV06u-Z1kQRS3LPr-w-T-4V77OKuV2byNfFXJ2DuYTHUqNF7sOdPu32ZXpf9HHGYRORYig_VuMMCPsHsissK-ONf4eSF8U3gCbVKe'),
(201, 2,  'c2X7G50qKKw:APA91bHSCA4-6jwPxsOgRC7scGlHoahlxyqByNErpfWcXG_bU4Xt-9ZmiV4XUKcFgdI4bJ5OJ8_AoSJ09Rrhsyqf7hFEANck-qczDBJoCwZMHf6sEDVgrJ7rjCXJ6HC-pH32xv-0fpII'),
(120, 2,  'c981zn0iXnc:APA91bF-cXpzA3v2Uk2de746joKRB73OLjj0RJMq8iGRVhr0w4pSMWsC6by3TSleD2NbK3iMJ0DHjlAitK52jdnYbfW5vSDvMatkTBizYLBtYPHkBhLS9AiwK5rrEPmJ79uzidf2i8Lr'),
(190, 2,  'cAp6VHNhQR8:APA91bFbzJbA2HXzYLN733O2V7A3b4AocQl-OuloEiJnfqAM12PvggBym5pN0AwhGuEMfhc5QGTciSOR9um1FReNrjBv-uhWPTg7ZG92kM0deYNHLAI3aecJq77SbsDYFWGMXI2T90hR'),
(132, 2,  'cbQq3biBdcY:APA91bGenWLe9VSq4P7fQB8f2TdnLiuQhOeXUSxEtsXdYKmExJ4jlLkn6APc2GvcgG3Om59L7SP0tWr89Yfjo25AdhJgGrhbrv3a_MUEg2aKuEX1iMvZfDqyWJchTX_7RCEMahvA4wfw'),
(336, 2,  'cDlokelT5uw:APA91bFxO1Eta0PAAveeHZedb70k-faQhpGwrFFJmHDIuLdIJ-nFvvBBaKME33FrwqGp8oh5M2oAEKrpYgzzySZ_7UgpClE62-n-9aj0cBMTofULfT0HKKH7VcD8ArCyxLOCYR7mfQ0B'),
(246, 2,  'cDWky4QQqSo:APA91bFvxptwUqgv8rWofW97xx8tfzTfC9-Z3-6Bt-m6cuITUU9vAnA8PNJ2-oQ8MpB0YI9pEGkeiFWYFon5i920JlVPk5r_V1RDLgVcqUCMS-JgZUj58Z0kAF19K5hWCAWFlR92ykCN'),
(215, 2,  'cFvsGS8sRQE:APA91bGFYKdGYM6XPy5jUHmCX2blbRVm5sV2ok0DbCUtv23aQScCp7xsZTXw59_7CXIL7vvbiarunP6rmljcK7f55dGsUyguI9CsZwBwtPvP-LNNY4XgYW8Src6nEk463OCCQpFoWmAI'),
(141, 2,  'cKc8WtM40A4:APA91bEWap50UqiBaqpj6hTU4_VsX_qccT1i-tDnsYbK_23KZiGOKF5LIHnbQNetuL_dqsJtxRByIh3zCHrjPV5bdK7y7q0dgLfAfV-ykXxZ-q0IjJPiltXVI0574NUkDuTY6PCj1Rqc'),
(169, 2,  'ctjQJ0_zbEw:APA91bEtBP1kKk0Hay6sSx5__pJn5NJf9f19747PBhxfNabdGcDO_rBtHiA5cEKXsJEJmJ0_hbXicnAUw9yHCSrrH0Ek0PVq9rt5anCHYwr7IsKx8ClpqQr8zAIDo-wwP5z-I_udedzE'),
(187, 2,  'cvGRhK8mwt0:APA91bGQHRmiWMVSXy2izu2ex2FTZYOFJiHPgkJQKHFKgzy80toX35roe3l473qY3Ql_hVgC_gcj8qfWVHZ-vy4rw1kwGUUg8IK7G5yhrXeDl1XlzkYgAJ1ths7AH742rYRyT9fXusKr'),
(252, 2,  'cvWXN5FUY5g:APA91bE7u9DXTcXmpbIRc9Hkur3phpgtbvqvOhuYZzY4n_I5jR4QoUecOE4dZGnHkfPGMU6eP83Elq1s6cjIP6vTHRjpoNQITY-ycHSj06VOG05ok6NLiRO1_Yx-YNWkGtRy8pp_8yXj'),
(251, 2,  'cwiXzp1yuVM:APA91bEELVopqZPSH9JvhDz-fRpK_WZkhhBljUSC0Sk7sfZUTgIhVNHV6cLqZFTx0wk8ylZaDn13uO_MCVeCRsjUeRp1XmRUoefBq6AZoQNAgqW5AE9WAgOsHjpGwSWvY5psBZTiEs0p'),
(295, 2,  'd-mkSGI5_04:APA91bHwK8kTCoBu3D8iO8FHztfrpCcKDWmd4ayKFVU5F5F0Drbu6WAZn7OVKRfrVWhy8xyki5_naHUbEvzfoVym4QO0BFvxFN9RzhsetECgu-5JAgOsCp0lLADjJ5jpfcZN0-1Y4Ixy'),
(134, 2,  'd7FLYlCtyCs:APA91bFFY6Dl70DKB22-sLrgdoYA5zRxUmUJt_qbWh3vtDp1dAhPvmMIoy7hXifZvFZTwVHpKy3vPxbAgdHoWbh3M2M8wsel3rBpQQ9CrTPDTnqPY3b3YZ3GE0zpeKP2E_-iqcKoDSuU'),
(152, 2,  'ddANRE_ZOGI:APA91bHzRtSVuneMblITQvJtxadcrbUvcWXTkEP7ib-xAdkET3R1tNdtObAZ7b3y1eSQyZrokEcn4QCrO0gYfX9oeWZMubZ0Ssz-hcLRlwY5lIcIRDkFC4Shnt3vWz46-rHXh_np06v5'),
(203, 2,  'dDR8_fie5sg:APA91bFsuMcK11IAkoTd8gMva6owoXPtfrBWZe-38vj3-HfwCOgT8xOldNA9RiSQkq-6c6Na-f57vDiWGnnpvY95t5B9GGj8NpKwZPFfhjynwAiQDWqu0qeB1xSS7kLz_OYECnz-5kWJ'),
(122, 2,  'dGZf4E4WBB4:APA91bELZZP8_t1HVnn_dNg7XypyNzpOobs_qBm45txOctLUzJrekZsjGVBlLBAf6oFQXQbd2x5tNB056hXNI-B8-5Ht4T2qZ3P7mTMonxdN8_NwHEB4pXqM88uACEMh2ogpTfyiEqw4'),
(216, 2,  'dhhRdxLE6ZA:APA91bEpOAMM9v636JJYTWNe14UJghBL3Ve5Jy9gy_M0CdS9TzBHUp1RNpQmWnV7BgbJG1r6mPCwUH5uDsqhr216tu7XiasmNtnNiLgWVNH7c5ZmE-6RAcynWwtjGiJjEbI1MxTuQiGt'),
(210, 2,  'dme1fbmqu3I:APA91bEpVHe0GiNy6la2v3zgiyjn4rziMJ-Wn7vDPIMTwg1zY55eXFcQz4kPnO9ZFYNU0_st4ExGuDb5jBZgMjKS3mRAjw4PBP9c4pQn395tTelTtoaxa6NhRhhZkmQ-IAmb_smTrk7n'),
(178, 2,  'dNMZ-fkZNiA:APA91bEd1Xam4odF-n5aeF3fEJQqCZBBKOQ9tUy_Db2MoU_2bt81KTLTyC0yV5QpdH5h11O7rYPizm74_4ZxPES0c867cZAMzoDo9-7XYhUb3ZYa32jHU9E4QvZrHMfyY94WTQB7jniz'),
(200, 2,  'duF_VylouFk:APA91bHTmUO9we3gAAuBF9XXOtLzZNgnWFlYzyWgshBtpEbZbgdkBQfcwgtNsfpje8BhKczxqD38Dr9X74mmbGyU-V-CFqtsn3VtorJdBr3w7FGqr1wcV4zKoOlveFXRoOARaTv79PH0'),
(305, 2,  'dvf3Au3qdVw:APA91bGLVFNFUUTjOEHgo5UeSBLifrMlhs0QpSsgcxCJaPMp5BNlcR8rinnMR1r8oYjTWIncNZ378g0ulyW5XyIkBwOA4rdDabf17Zg4_4tLw52xNfkXj2fhEkGpCYt9fXW0thGONRBn'),
(280, 2,  'dZpS10iVJCc:APA91bE1iMW_0AyDmUHINv1o28NFhzwh7t0mL2LNxz2--ZDar4ZTninCZv8Yu7xgcLuMBO98iRof4IyC8xREzsSz-DJA8UoPtmzKOc42YZ2C5GTAl9q6ezuJAtbGIDd1NZIPbxYp7_Pg'),
(241, 2,  'dZpS10iVJCc:APA91bErH2hPInJAnP2kuZXMrg-5wI-AqgjS2a0sEjnQDiOG57JkV6q8-WdeISF6wSA_IkG_O8NoWKCBWc-WXvzCK4tsCXk6PnptbWssdvcChY6mrdVjhs_KMCjmTwSIimt4tEBvHmuI'),
(331, 2,  'e8T4bSpKdk-FnayTfFp-4b:APA91bFpF8ACWVvXRlz-EbAFvZZDnWI4IhmKl68fagnvo6I6i6dv9-3EJodfGq7fBCMyu8_h_EpVUyOubkdIULhEn01JHC8lqYY3QhRP1f4MVHT8wQp4GesDfmB2_poPp6US6S7WONsi'),
(300, 2,  'eGD8fwBzKdY:APA91bE1N0qtAIttxci6S3asR_v1UqnY3Un_aoWNiWODpjA6z9nJ5SpUht8856036exCkIQY8zvC1pBrBfUR5DUhc7QerZx9WFNPMYW8GpD4F_xpLjKo9GBSjEbRjgqypocAxO50zyN7'),
(170, 2,  'egUgWOzYoh0:APA91bHy_ogy1XVzv2fAHDmC8RIuaPNoI49mNDLZWmBoDr3mNDTcTQdBFnXV1EKERnjWgh6PrvBxFDfp8kPUq-N1l74fPh2uhzCYiFjT3maXo15HDm4-mer3HuE4VXRgrMa7Voe26P78'),
(204, 2,  'eHN24aPXXb4:APA91bGA9LUiXmsPc3vmoxFD1U0RA7na9mexDQn9PS3N2cP-ToR_zmbYvG_IQelJw9WKIO3wkzL2AEG_2U1-13Qn9j4BR95n7CWFi_Mw6f-J_q1TBIlcyqJarTYyxIh8n_B3Mgdhh69u'),
(161, 2,  'eMNXJQ0KbsA:APA91bEo4wMUoC13E2deGbuSD43EuaCoWarQVS4Bbl1Gtxqle8wUkTB0U1xeaxqtf4-vC5UuUp8RDZJOA4UVV5kiKPyHYUDc5iRODwXWYFXOYmS2iDKyIy6ksJPmMDk27Jq4Y8sSk50x'),
(155, 2,  'eNBD_AAenWw:APA91bHr7m28C5l9JuS8vk8c8phsskoGLIJ-TfaGVOiFGZT_qb0gMmnzwGU6Yk62KAlcdOy5uwfFkKHmIZyvgI8HizmZ6x3RuEffKsnEOcp-PtNcHA5kYU0E2tx69YRWXu8MV-55o9Yh'),
(160, 2,  'eNpRc9A4WQE:APA91bHDn9iiK8ejdfY-zF_Yyx3Tgnbn1diTJJkEk8Lg3NB9E5JirbnJ1xs0GQ6pLTtM_bwFc64X_Uurx9DqMH4-fhcXv2KncMNc9CV6n_Fll8LHkCJyFenZOsEwBh_AzmqA6QtFvHAX'),
(202, 2,  'eqHcZKEroRg:APA91bHVl_rzkT6qVSSalZc0YXumOBEIu_4VPHk2EWivZihWiRgaaQ7MTXlyjOoTWf5cGXG7KCj9gYq9-gWdVEGQYELIPxT4fXFdokZ2PKxkFHu11HQpO0YmHTUiO9XIdkW0aO2m7tDy'),
(293, 2,  'eQLBIoJKVPo:APA91bFjAATm5HnxOl41d20bfzGFBSgkU_o7HoU2B_KqIOPvP5zBu9UMHA2KondnjKn_h9gonRIioGlryfX6qA-DviMi5wozqX_2Bonbh27NQG-TBOmPZKImeYIJ4pwjGXd3lq-4se46'),
(121, 2,  'ew1JGnBiCAg:APA91bGH1DM23BEav8aSUd_YX8jauEFsSLftVO7FL3j9VW3lrxMbzDHRArL6uH4z1CjA4KaC_USSqVV4Z7v0ZUJDs-lQkHA44hNzaRoj_e9WNNZHgIQ9nE48qAad0B639jaT-HUXwTwC'),
(245, 2,  'eYQjaw0nePI:APA91bFVXt4hvQcA7AluzmGPesriLcCbrMgAZcqAv2TbQ0M7uqBFjWZQURrL__-a3VG_7ljqjcVX5mzeCJYcornDlE1yEYIylHG2h5MUO3OYXJsrIH5xNByKCyIlwsFAvY6wconpN21-'),
(165, 2,  'eZe7h4nJ7eg:APA91bEYGQUfrcISorBnvzKBxIutzm66BRpqmRRsIWtEhle6sUG-8ZmSwtnICy_zCKbR-zDGYd0h5fFznIkL3Kt2N2fD3_aCCQf2_OTqgUfD8UHB3KqLoS2jBBWoTL0DMRB15QlWTZXV'),
(242, 2,  'falNOjQjREI:APA91bE6QcJgUA30ZqNfa569xjl8SlmYs-4UU-wGtS9ceLFXrWqMrcz98puFxBUGGoDN3UgcsLNIWQWQgIgTRA1PgADwK78BuOyaJ_r7PyYlP7COT0XUUp2_jE4kR7jY3A7aU7sFC6Ax'),
(130, 2,  'fC7huI8eLn8:APA91bEcFpN-5u_xVW07j60vmX1QxKR0n6UZAdI-RRi81iynH0acyIz5L_7JefF9MNYqfBCGvWPscLRFxghAV2dYu6PyGTYDce6X7qmcoln6KzvqvbmusgfGdv2OXL37XAOhZn4s7d0P'),
(322, 2,  'fdigzWdrydE:APA91bGETyqoB7GVEEqASEqJx-h-9AQbl54Fh-G9v6B0xqjas7HNL5SIRNunOHcwPSm9DO6CExKH1l6b3VjjaxMNRaI3-bINJTAa7YgWk_pg8W3NX0Ffxw4WBjlJ1JIFvWV3jJMRy6LH'),
(321, 2,  'fi_C1i8GeHU:APA91bE2FggLgQeixqBWRZp6rwt7UIXb3EofAURXD0ziEExFeY7QR0Rf3qV__B2sIOvVUvLIh1pqG1eVWxbvN9lsHmqsqYgLObjQRo1jNG605L3X3T3dqNpioNgrTXHq3g3EGcY3JXf_'),
(250, 2,  'fJNAqYpq-ss:APA91bFAT5Sh4twOU9sB5DMYihWqCmVADsdasI3EJDd9BncADOpwQu3fS73o8jw9-K_dFHXrPyNWQmHDaIP6RoTwczH2G2p__IkLd-EsMVOzzEmwfvmRax8Uz0ZqtC3D4BYve5z9MVxS'),
(142, 2,  'fJXmC2wUMc0:APA91bFOctx84QFeWE1q2WnVHHkFPEJjmruwIr-XsOUqgWxgbCe_KsnekzxJ_MpuBTFdmMTucBa5R8rnfSjwapqMlChGkimXgMuM7EvKZIGgLguhjn9DIWf35KHICAeEIc4FV83leGh7'),
(181, 2,  'fPpA2IFh4sA:APA91bGDkLv1gGueQ5vpgkylZBpfQn4DhCqwav9ULyZPj0ObV7LGJv7e8YeQg8TuCXuqjpfHW1dyUBampTaTW0WxY4O-8eQK-T-egbkNsqRbz80bCwmYHbFbZa5EoppCGGlJV0cV-DWL'),
(301, 2,  'fUNjUkVHCsk:APA91bFfkJa5X2-wWoCjgS9tROD89fYM-_Kg3a02_juhWgQddaLnfGEID1O8ThL1FJptw7iV_5bgLrCrcGjsteFvcbO3u-qW05Zhz3GTvVl4zaKXQscIhZG6PG5D_B65OM0xCVONgsh_'),
(228, 2,  'fXK0m8q4-ZQ:APA91bFQIrYxqFP-dqL21PE6FWN0WiAUqZ1-n5J2GHAEonbnm-3_v22J0joybk3cTudg0zn3cRpIphcLJu6LwOlnVMJ8175h3M3s9io_k1y9qqIraeiHXE8kwtrbjX0FkkpYPr7ozGBq'),
(254, 3,  'cDWky4QQqSo:APA91bFvxptwUqgv8rWofW97xx8tfzTfC9-Z3-6Bt-m6cuITUU9vAnA8PNJ2-oQ8MpB0YI9pEGkeiFWYFon5i920JlVPk5r_V1RDLgVcqUCMS-JgZUj58Z0kAF19K5hWCAWFlR92ykCN'),
(213, 3,  'cFvsGS8sRQE:APA91bGFYKdGYM6XPy5jUHmCX2blbRVm5sV2ok0DbCUtv23aQScCp7xsZTXw59_7CXIL7vvbiarunP6rmljcK7f55dGsUyguI9CsZwBwtPvP-LNNY4XgYW8Src6nEk463OCCQpFoWmAI'),
(329, 3,  'd-mkSGI5_04:APA91bHwK8kTCoBu3D8iO8FHztfrpCcKDWmd4ayKFVU5F5F0Drbu6WAZn7OVKRfrVWhy8xyki5_naHUbEvzfoVym4QO0BFvxFN9RzhsetECgu-5JAgOsCp0lLADjJ5jpfcZN0-1Y4Ixy'),
(217, 3,  'dhhRdxLE6ZA:APA91bEpOAMM9v636JJYTWNe14UJghBL3Ve5Jy9gy_M0CdS9TzBHUp1RNpQmWnV7BgbJG1r6mPCwUH5uDsqhr216tu7XiasmNtnNiLgWVNH7c5ZmE-6RAcynWwtjGiJjEbI1MxTuQiGt'),
(327, 3,  'e8T4bSpKdk-FnayTfFp-4b:APA91bFpF8ACWVvXRlz-EbAFvZZDnWI4IhmKl68fagnvo6I6i6dv9-3EJodfGq7fBCMyu8_h_EpVUyOubkdIULhEn01JHC8lqYY3QhRP1f4MVHT8wQp4GesDfmB2_poPp6US6S7WONsi'),
(191, 3,  'eNBD_AAenWw:APA91bHr7m28C5l9JuS8vk8c8phsskoGLIJ-TfaGVOiFGZT_qb0gMmnzwGU6Yk62KAlcdOy5uwfFkKHmIZyvgI8HizmZ6x3RuEffKsnEOcp-PtNcHA5kYU0E2tx69YRWXu8MV-55o9Yh'),
(333, 3,  'eNpRc9A4WQE:APA91bHDn9iiK8ejdfY-zF_Yyx3Tgnbn1diTJJkEk8Lg3NB9E5JirbnJ1xs0GQ6pLTtM_bwFc64X_Uurx9DqMH4-fhcXv2KncMNc9CV6n_Fll8LHkCJyFenZOsEwBh_AzmqA6QtFvHAX'),
(146, 3,  'fJXmC2wUMc0:APA91bFOctx84QFeWE1q2WnVHHkFPEJjmruwIr-XsOUqgWxgbCe_KsnekzxJ_MpuBTFdmMTucBa5R8rnfSjwapqMlChGkimXgMuM7EvKZIGgLguhjn9DIWf35KHICAeEIc4FV83leGh7'),
(220, 3,  'fmdvqoM1soE:APA91bE2bg0x__4xjpuPXy5QMICrG6tKHqH8ejv8IKvvuq2iAu0f-r_N7gH1hmhwU0Hlqak06d5Q0bgPg9rq8iRSQ-QHCSkWC5v-W9F3L9O-MfJs3nwQrAQ0ese0P44ZnlS8A2-BnBd_'),
(192, 4,  'dGZf4E4WBB4:APA91bELZZP8_t1HVnn_dNg7XypyNzpOobs_qBm45txOctLUzJrekZsjGVBlLBAf6oFQXQbd2x5tNB056hXNI-B8-5Ht4T2qZ3P7mTMonxdN8_NwHEB4pXqM88uACEMh2ogpTfyiEqw4'),
(326, 4,  'e8T4bSpKdk-FnayTfFp-4b:APA91bFpF8ACWVvXRlz-EbAFvZZDnWI4IhmKl68fagnvo6I6i6dv9-3EJodfGq7fBCMyu8_h_EpVUyOubkdIULhEn01JHC8lqYY3QhRP1f4MVHT8wQp4GesDfmB2_poPp6US6S7WONsi'),
(162, 4,  'eNBD_AAenWw:APA91bHr7m28C5l9JuS8vk8c8phsskoGLIJ-TfaGVOiFGZT_qb0gMmnzwGU6Yk62KAlcdOy5uwfFkKHmIZyvgI8HizmZ6x3RuEffKsnEOcp-PtNcHA5kYU0E2tx69YRWXu8MV-55o9Yh'),
(323, 4,  'fdigzWdrydE:APA91bGETyqoB7GVEEqASEqJx-h-9AQbl54Fh-G9v6B0xqjas7HNL5SIRNunOHcwPSm9DO6CExKH1l6b3VjjaxMNRaI3-bINJTAa7YgWk_pg8W3NX0Ffxw4WBjlJ1JIFvWV3jJMRy6LH'),
(271, 4598, 'cDWky4QQqSo:APA91bFvxptwUqgv8rWofW97xx8tfzTfC9-Z3-6Bt-m6cuITUU9vAnA8PNJ2-oQ8MpB0YI9pEGkeiFWYFon5i920JlVPk5r_V1RDLgVcqUCMS-JgZUj58Z0kAF19K5hWCAWFlR92ykCN'),
(310, 4598, 'd7DnP3FhxZQ:APA91bEKDUZvjazvHpfTUlHV5OoOt7cdKM0MLIVnJOIzx_oAWto6uTOtmMlJtzfggwqxeE4ZG4YycoST3GTO6R67HvyREI8vXzrAjwS7kt7Blw0DBPJO26FoLv6bM8iqZ6LhhzlY-5PM'),
(306, 4598, 'dOy57wdpOak:APA91bGouglz79b5SBJ5EPVkCKOLcH1o3HIOSaN-x39xJZT-VZczWYHzRh4uasymwBhlsmWIKaLeLZ8mmVaE22cnaS1kpdSxkj1TqDI1FZHR1C9t9xnEcvbOAH0nXxQYc5-_oRAjw9Qc'),
(313, 4598, 'fBd1T9u2C2k:APA91bESh64lVlYB3-KSaK4dt0zLHSQ1XGgCebmwd_MkkxyOQXFEccS1vdRQDvX9hI5l7RpTQI5acdZEkciyTnbeQ6IkIJVJccQjDBpq49xIRVijogJzjKg5eZKyQcrJnKY78qe_jdUM'),
(276, 5774, 'cDWky4QQqSo:APA91bFvxptwUqgv8rWofW97xx8tfzTfC9-Z3-6Bt-m6cuITUU9vAnA8PNJ2-oQ8MpB0YI9pEGkeiFWYFon5i920JlVPk5r_V1RDLgVcqUCMS-JgZUj58Z0kAF19K5hWCAWFlR92ykCN');

DROP TABLE IF EXISTS `Pathology`;
CREATE TABLE `Pathology` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `hours` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Pathology` (`id`, `name`, `address`, `phone`, `hours`, `website`) VALUES
(1, 'Dorevitch Pathology',  '66 Darebin Street, HEIDELBERG VIC 3084', '(03) 9457 2200', 'Monday Closed\nTuesday 12-5pm\nWednesday 9am-1pm\nThursday 9am-1pm\nFriday 9am-1pm\nSaturday Closed\nSunday  Closed ', 'https://www.dorevitch.com.au/patients/find-a-collection-centre/'),
(2, 'Melbourne Pathology',  NULL, NULL, NULL, 'https://www.mps.com.au/locations/'),
(3, 'Austin Pathology', 'Level 6, Harold Stokes Building, Austin Hospital Studley Road, Heidelberg, VIC 3084',  '9496-3100 (24/7)', NULL, 'https://www.austinpathology.org.au'),
(4, 'Australian Clinical Labs', NULL, NULL, NULL, 'https://www.clinicallabs.com.au');

DROP TABLE IF EXISTS `Radiology`;
CREATE TABLE `Radiology` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `hours` varchar(255) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Radiology` (`id`, `name`, `address`, `phone`, `fax`, `hours`, `email`, `website`) VALUES
(1, 'I-MED ', 'Level 1/10 Martin St, Heidelberg VIC 3084',  '(03) 9450 1800', '(03) 9450 1888', 'Monday - Friday, 8:30am - 5:30pm', NULL, 'https://i-med.com.au/clinics/clinic/Heidelberg'),
(2, 'I-MED Warringal Radiology',  'Warringal Medical Centre Level 2, 214 Burgundy Street Heidelberg VIC 3084',  '(03) 9450 2100', '(03) 9450 2114', 'Monday - Friday, 8:30am - 5:30pm', NULL, 'https://i-med.com.au/clinics/clinic/Warringal'),
(3, 'Austin Nuclear Medicine and PET',  'Level 1, Harold Stoke Building, 145 Studley Road', '(03) 9496 5718', '(03) 9457 6605', NULL, 'enquiries.miat@austin.org.au', 'https://www.austin.org.au/MIaT_Contact_Us/'),
(4, 'Austin Radiology - Repatriation Hospital', '300 Waterdale Road, Ivanhoe Victoria 3079',  '(03) 9496 5000', '(03) 9496 2541', NULL, 'enquiries.radiology@austin.org.au',  'https://www.austin.org.au/heidelberg-repatriation-hospital');

DROP TABLE IF EXISTS `Resource`;
CREATE TABLE `Resource` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `Resource_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Resource` (`id`, `uid`, `name`, `date`, `content`) VALUES
(1, 4598, 'Colorectal cancer',  '2020-09-30', 'https://www.eviq.org.au/medical-oncology/colorectal/adjuvant-and-neoadjuvant/637-colorectal-adjuvant-folfox6-modified-fluoro');
-- (2, 2,  'bilibili', '2020-09-30', 'https://www.bilibili.com/'),
-- (3, 1,  'bilibili', '2020-09-30', 'https://www.bilibili.com/'),
-- (4, 3,  'test', '2020-09-30', 'testtesttest'),
-- (5, 3,  'test', '2020-09-30', 'https://www.apple.com/au/'),
-- (6, 2,  'test0929', '2020-09-30', '123456789');

DROP TABLE IF EXISTS `ResourceFile`;
CREATE TABLE `ResourceFile` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `link` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link` (`link`),
  KEY `uid` (`uid`),
  CONSTRAINT `ResourceFile_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `firstname` varchar(45) NOT NULL,
  `middlename` varchar(45) DEFAULT NULL,
  `surname` varchar(45) NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  `suburb` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_valid_from` datetime DEFAULT NULL,
  `token_expire_date` datetime DEFAULT NULL,
  `role` enum('PATIENT','ADMIN') DEFAULT 'PATIENT',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `User` (`id`, `password`, `firstname`, `middlename`, `surname`, `dob`, `email`, `street`, `suburb`, `state`, `token`, `token_valid_from`, `token_expire_date`, `role`) VALUES
(1, '123',  'Alex', NULL, 'Williamson', '1996-05-01', 'williamson@example.com', '97 Masthead Drive',  'ROCKHAMPTON',  'QLD',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6ImlnZDIxZHQ2ZjFnczNnNDRlMXM3dWo3M29tIiwiZXhwIjoxNjAwOTE5ODYyLCJpYXQiOjE2MDA4MzM0NjIsInN1YiI6IjEifQ.QMGZ0M-9AxoOJzHJQ0i9BB0bE-aYUcY1P6YgfK3seccW2EZ6JLdz9-vqG3IiwuEixZqr7jCVXnXGxE7qdHDoQQ', '2020-09-23 03:57:42',  '2020-09-24 03:57:42',  'PATIENT'),
(2, '123',  'Matthew',  NULL, 'Chen', '1994-09-08', '123@qq.com', 'Unimelb Drive',  'Parkville',  'VIC',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6Ijk1dm1zOHZtcjY5ZGNiZnZ2ZmhnM2cwZDIiLCJleHAiOjE2MDE1NDYzMDUsImlhdCI6MTYwMTQ1OTkwNSwic3ViIjoiMiJ9.Rk6jg0P7dnkTL-Ylky2V9S3yJCZTegODTkqOwv2HXI5MhZF-MXgxlbFPuBqLGPLgjtMQEMsmpVac102P-nFFlg', '2020-09-30 09:58:25',  '2020-10-01 09:58:25',  'PATIENT'),
(3, '123',  'client', NULL, 'client', '1994-09-08', '1234@qq.com',  'Unimelb Drive',  'Parkville',  'VIC',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6ImJqNWdiNnRrM3I5ZHU3MTM0aHQ3MHA4aWE4IiwiZXhwIjoxNjAxNDQyNzc0LCJpYXQiOjE2MDEzNTYzNzQsInN1YiI6IjMifQ.RFefVhNe7skLSlklLSDeS8H5FlVnLzMcxWfYUr316OuaxvbOEt6g0MTvMojnMR1d09ijMjH5hDxojeqqYC-T2g', '2020-09-29 05:12:54',  '2020-09-30 05:12:54',  'PATIENT'),
(4, '1234', 'user4',  NULL, 'wombat', '2020-09-07', 'user4@qq.com', 'Unimelb Drive',  'Parkville',  'VIC',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6ImR0YzQ1cnZnamlyMG10Mm43Z2pwcGcza29iIiwiZXhwIjoxNjAxMzE0NjcwLCJpYXQiOjE2MDEyMjgyNzAsInN1YiI6IjQifQ.W3bybFCxt8KF1zqOwOmUbthOZwkSCb94qKUtgcrre3tYQA8f_8SU-S39XnvhkjIT7d7wyFkPYvHgYgLmQJxxww', '2020-09-27 17:37:50',  '2020-09-28 17:37:50',  'PATIENT'),
(4598,  'Point21',  'Susan',  NULL, 'Pickering',  '1981-07-02', 'suepickering81@hotmail.com', '6 Crowe Court',  'Eltham', 'VIC',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6InB0bzE4OTBrOGVkcHA0ajNhamloNWRwZnE3IiwiZXhwIjoxNjAxMzYzMDgxLCJpYXQiOjE2MDEyNzY2ODEsInN1YiI6IjQ1OTgifQ.6S5mQX1Dvv6q47-s9tZyS9q1k57tv6C0Z2Aas_x_wS7RDR_lzRUWScJ5FOh22x_iL_u8HpAxdHnSMtz__e48ow', '2020-09-28 07:04:41',  '2020-09-29 07:04:41',  'PATIENT'),
(5774,  'susan',  'Christopher',  NULL, 'Smith',  '1980-12-09', 'cwsmith190@gmail.com', '6 Crowe Court',  'Eltham', 'VIC',  'eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6ImliaW1mM2loaDQ1azk0dm9wZXIxaWF2OGIiLCJleHAiOjE2MDA0MjExNTgsImlhdCI6MTYwMDMzNDc1OCwic3ViIjoiNTc3NCJ9.PNaMWwlWrgxNY4GV4_kQf26LBkIRO5GdC2koZq4oG6IQWhsKJcUZ8-RNWemg15p4nrgyo9DXr1yk9f5TurSnIw', '2020-09-21 06:14:32',  '2020-09-18 09:25:58',  'PATIENT');

-- 2020-09-30 12:36:01