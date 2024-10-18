---
title: Skapar adresskomponent
description: Skapa en ny adresskomponent i AEM Forms as a Cloud Service
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15752
exl-id: be25be52-2914-4820-9356-678a326f8edc
source-git-commit: b4df652fcda0af5d01077b97aa7fa17cfe2abf4b
workflow-type: tm+mt
source-wordcount: '200'
ht-degree: 0%

---

# Distribuera ditt projekt

Innan du börjar distribuera projektet till din AEM Forms-as a Cloud Service rekommenderar vi att du distribuerar projektet till den lokala molnförberedda instansen av AEM Forms.

## Synkronisera ändringar med ditt AEM

Starta IntelliJ och navigera till mappen adaptiveForm i mappen ``ui.apps`` enligt nedan
![ Intellij ](assets/intellij.png)

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

Om allt ser bra ut i den lokala utvecklingsmiljön är nästa steg att distribuera till [molninstansen med hjälp av molnhanteraren.](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/push-project-to-cloud-manager-git)
