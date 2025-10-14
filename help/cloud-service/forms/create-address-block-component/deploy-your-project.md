---
title: Skapar adresskomponent
description: Skapa en ny adresskomponent i AEM Forms as a Cloud Service
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15752
exl-id: be25be52-2914-4820-9356-678a326f8edc
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '200'
ht-degree: 0%

---

# Distribuera ditt projekt

Innan du börjar distribuera projektet till din AEM Forms as a Cloud Service rekommenderar vi att du distribuerar projektet till en lokal molnklar instans av AEM Forms.

## Synkronisera ändringar med ditt AEM-projekt

Starta IntelliJ och navigera till mappen adaptiveForm i mappen ``ui.apps`` enligt nedan
![&#x200B; Intellij &#x200B;](assets/intellij.png)

Högerklicka på noden ``adaptiveForm`` och välj Ny | Paket
Se till att du lägger till namnet **adressblock** i paketet

Högerklicka på det nyligen skapade paketet ``addressblock`` och välj ``repo | Get Command`` enligt nedan
![repo-sync](assets/sync-repo.png)

Detta bör synkronisera projektet med den lokala molnförberedda AEM Forms-instansen. Du kan verifiera .content.xml-filen för att bekräfta egenskaperna
![efter-synkronisering](assets/after-sync.png)

## Distribuera projekt till din lokala instans

Starta ett nytt kommandotolkfönster, navigera till projektets rotmapp och bygg projektet med kommandot som visas nedan
![distribuera](assets/build-project.png)

När projektet har distribuerats utan fel
Adresskomponenten kan nu användas i ett adaptivt formulär

## Distribuera projektet till molnmiljön

Om allt ser bra ut i den lokala utvecklingsmiljön är nästa steg att distribuera till [molninstansen med hjälp av molnhanteraren.](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/push-project-to-cloud-manager-git)
