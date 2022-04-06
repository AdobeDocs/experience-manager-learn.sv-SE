CREATE DATABASE  IF NOT EXISTS `aemformstutorial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `aemformstutorial`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: aemformstutorial
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `icdrafts`
--

DROP TABLE IF EXISTS `icdrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icdrafts` (
  `status` varchar(45) DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `draftID` varchar(45) NOT NULL,
  `documentID` varchar(145) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icdrafts`
--

LOCK TABLES `icdrafts` WRITE;
/*!40000 ALTER TABLE `icdrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `icdrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `guid` varchar(40) NOT NULL,
  `downloaded` int(11) DEFAULT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES ('34f8bbd7-758c-4719-94c6-7f54d51aba84',1),('37b1c933-0067-405c-9789-64aa22a6b0b8',0),('7880241f-82ee-425d-8b25-4b66c5868f3e',1),('8131e1fd-f725-4579-8ff3-8a076fc4e332',1),('967ed7b0-df7c-45d2-815f-29ef6be3fa05',1);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signingforms`
--

DROP TABLE IF EXISTS `signingforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signingforms` (
  `formName` mediumtext NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` mediumtext,
  `status` int(11) DEFAULT NULL,
  `formData` mediumtext,
  `customerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=402 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signingforms`
--

LOCK TABLES `signingforms` WRITE;
/*!40000 ALTER TABLE `signingforms` DISABLE KEYS */;
INSERT INTO `signingforms` VALUES ('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/consentform/jcr:content?wcmmode=disabled&guid=5827bbfc-93c2-4eec-8eb8-b311cc052aec&customerID=892',396,'5827bbfc-93c2-4eec-8eb8-b311cc052aec',1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Charles Street Garden</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>Y</signed>\r\n      <guid>5827bbfc-93c2-4eec-8eb8-b311cc052aec</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    <radiobutton1592239547943>Y</radiobutton1592239547943>\r\n    </data>\r\n  </afUnboundData>\r\n  \r\n  \r\n<afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/consentform</afPath>\r\n    <afSubmissionTime>20210112012500</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',892),('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock/jcr:content?wcmmode=disabled&guid=e3c16089-a97d-4ab9-9736-901ebdde1c02&customerID=892',397,'e3c16089-a97d-4ab9-9736-901ebdde1c02',1,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Charles Street Garden</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>Y</signed>\r\n      <guid>e3c16089-a97d-4ab9-9736-901ebdde1c02</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    <loanNumber>17d696c5-f6f6-48a9-bdb0-802313f2cba1</loanNumber>\r\n      <lender>We.Finance LLC</lender>\r\n      <nmls>16355</nmls>\r\n      <radiobutton1588884585800>Y</radiobutton1588884585800>\r\n    </data>\r\n  </afUnboundData>\r\n  \r\n  \r\n<afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</afPath>\r\n    <afSubmissionTime>20210112012721</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',892),('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/consentform/jcr:content?wcmmode=disabled&guid=f452e40c-d049-404a-83a9-3660a5f14a50&customerID=531',398,'f452e40c-d049-404a-83a9-3660a5f14a50',0,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Jimmy Vo</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>N</signed>\r\n      <guid>f452e40c-d049-404a-83a9-3660a5f14a50</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    </data>\r\n  </afUnboundData>\r\n  <afBoundData>\r\n    <data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/>\r\n  </afBoundData>\r\n  <afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/refinanceform</afPath>\r\n    <afSubmissionTime>20210114102554</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',531),('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock/jcr:content?wcmmode=disabled&guid=f4d1aa03-735a-4c69-bff3-147fcc8dd964&customerID=531',399,'f4d1aa03-735a-4c69-bff3-147fcc8dd964',0,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Jimmy Vo</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>N</signed>\r\n      <guid>f4d1aa03-735a-4c69-bff3-147fcc8dd964</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    </data>\r\n  </afUnboundData>\r\n  <afBoundData>\r\n    <data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/>\r\n  </afBoundData>\r\n  <afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/refinanceform</afPath>\r\n    <afSubmissionTime>20210114102554</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',531),('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/consentform/jcr:content?wcmmode=disabled&guid=380183e2-91f4-4ebc-ac19-69b438458e88&customerID=481',400,'380183e2-91f4-4ebc-ac19-69b438458e88',0,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Aditya Ghule</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>N</signed>\r\n      <guid>380183e2-91f4-4ebc-ac19-69b438458e88</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    </data>\r\n  </afUnboundData>\r\n  <afBoundData>\r\n    <data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/>\r\n  </afBoundData>\r\n  <afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/refinanceform</afPath>\r\n    <afSubmissionTime>20210114104305</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',481),('http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock/jcr:content?wcmmode=disabled&guid=0770a2fd-c016-4147-8ce3-14d31f0e4fa2&customerID=481',401,'0770a2fd-c016-4147-8ce3-14d31f0e4fa2',0,'<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><afData>\r\n  <afUnboundData>\r\n    <data>\r\n      <TypeOfLoan>Buy a home</TypeOfLoan>\r\n      <TypeOfHome>Single Family Home</TypeOfHome>\r\n      <PropertyUse>Primary Residence</PropertyUse>\r\n      <customerName>Aditya Ghule</customerName>\r\n      <customerEmail>gbedekar@adobe.com</customerEmail>\r\n      <signed>N</signed>\r\n      <guid>0770a2fd-c016-4147-8ce3-14d31f0e4fa2</guid>\r\n      <formsToSign>/content/dam/formsanddocuments/formsandsigndemo/consentform,/content/dam/formsanddocuments/formsandsigndemo/multistateinterestratelock</formsToSign>\r\n    </data>\r\n  </afUnboundData>\r\n  <afBoundData>\r\n    <data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/>\r\n  </afBoundData>\r\n  <afSubmissionInfo>\r\n    <computedMetaInfo/>\r\n    <stateOverrides/>\r\n    <signers/>\r\n    <afPath>/content/dam/formsanddocuments/formsandsigndemo/refinanceform</afPath>\r\n    <afSubmissionTime>20210114104305</afSubmissionTime>\r\n  </afSubmissionInfo>\r\n</afData>',481);
/*!40000 ALTER TABLE `signingforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submitteddata`
--

DROP TABLE IF EXISTS `submitteddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submitteddata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formdata` longtext,
  `formname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submitteddata`
--

LOCK TABLES `submitteddata` WRITE;
/*!40000 ALTER TABLE `submitteddata` DISABLE KEYS */;
INSERT INTO `submitteddata` VALUES (1,'<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><FirstName>Girish</FirstName><LastName>Bedekar</LastName><customerEmail>girishbedekar@gmail.com</customerEmail><Company>MR</Company></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/aemsizingquestionnaire</afPath><afSubmissionTime>20200503090355</afSubmissionTime></afSubmissionInfo></afData>','SurveyForm'),(2,'<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><FirstName>Girish</FirstName><LastName>Bedekar</LastName><customerEmail>girishbedekar@gmail.com</customerEmail><Company>Adobe</Company><AEM>Sites</AEM><PreferredCloudProvider>AWS</PreferredCloudProvider><UseAEMToday>Yes</UseAEMToday><AEMCurrentlyHosted>San Jose</AEMCurrentlyHosted></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/aemsizingquestionnaire</afPath><afSubmissionTime>20200503090633</afSubmissionTime></afSubmissionInfo></afData>','SurveyForm');
/*!40000 ALTER TABLE `submitteddata` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-05  8:52:19
