---
title: AEM Headless first tutorial
description: Lär dig hur du blir ett AEM Headless-program.
version: Experience Manager as a Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Development
role: Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-05-16T00:00:00Z
jira: KT-13270
thumbnail: KT-13270.jpeg
exl-id: b0ac4b50-5fe5-41a1-9530-8e593d7000c9
duration: 89
source-git-commit: bd0f42fa37b7bbe19bf0d7fc65801198e64cbcd9
workflow-type: tm+mt
source-wordcount: '421'
ht-degree: 1%

---

# AEM Headless first tutorial

Välkommen till självstudiekursen om hur du skapar en webbupplevelse med React, som drivs av AEM Headless API:er och GraphQL. I den här självstudiekursen vägleder vi dig genom processen att skapa ett dynamiskt och interaktivt webbprogram genom att kombinera funktionerna i React, Adobe Experience Manager (AEM) Headless API:er och GraphQL.

React är ett populärt JavaScript-bibliotek för att bygga användargränssnitt som är känt för sin enkelhet, återanvändbarhet och komponentbaserade arkitektur. AEM har robusta funktioner för innehållshantering och visar Headless-API:er som gör att utvecklare kan komma åt innehåll och data som lagras i AEM via en mängd olika kanaler och program.

Genom att utnyttja AEM Headless API:er kan du hämta innehåll, resurser och data från din AEM-instans och använda dem för att ge kraft åt ditt React-program. GraphQL, ett flexibelt frågespråk för API:er, är ett effektivt och exakt sätt att begära specifika data från din AEM-instans, vilket möjliggör en smidig integrering mellan React och AEM.

![AEM Headless First Tutorial](./assets/overview/overview.png)

Under den här självstudiekursen går vi steg för steg igenom processen att skapa en webbupplevelse med hjälp av React and AEM Headless API:er med GraphQL. Du får lära dig hur du konfigurerar utvecklingsmiljön, upprättar en anslutning mellan React och AEM, hämtar innehåll med GraphQL-frågor och återger det dynamiskt i webbprogrammet.

Vi kommer att behandla ämnen som att konfigurera ditt React-projekt, upprätta autentisering med AEM, fråga innehåll från AEM med GraphQL, hantera data i dina React-komponenter och optimera prestanda genom att använda cachning och paginering.

I slutet av den här självstudiekursen får du en god förståelse för hur du använder React, AEM Headless API:er och GraphQL för att skapa en kraftfull och engagerande webbupplevelse. Låt oss dyka in och börja bygga nästa webbapplikation!

## Förutsättningar

### Kompetens

+ Kompetens för Reaktion
+ Kunskap i GraphQL
+ Grundläggande kunskaper i AEM as a Cloud Service

### AEM as a Cloud Service

Den här självstudiekursen kräver administratörsåtkomst till en AEM as a Cloud Service-miljö.

### Programvara

+ [Node.js v16+](https://nodejs.org/en/)
   + Kontrollera nodversionen genom att köra `node -v` från kommandoraden
+ [npm 6+](https://www.npmjs.com/)
   + Kontrollera npm-versionen genom att köra `npm -v` från kommandoraden
+ [Git](https://git-scm.com/)
   + Kontrollera Git-versionen genom att köra `git -v` från kommandoraden

Använd [nodversionshanteraren (nvm)](https://github.com/nvm-sh/nvm) för att adressera med flera versioner av node.js på samma dator.

Kontrollera att du har behörighet att installera program globalt på datorn.

## Nästa steg

Nu när miljön är konfigurerad går vi vidare till nästa steg: [Konfigurera och redigera innehåll i AEM as a Cloud Service](./1-content-modeling.md)
