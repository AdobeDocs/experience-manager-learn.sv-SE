---
title: Skapar adresskomponent
description: Skapa ny adresskomponent i AEM Forms Cloud Service
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15752
source-git-commit: a8fc8fa19ae19e27b07fa81fc931eca51cb982a1
workflow-type: tm+mt
source-wordcount: '196'
ht-degree: 0%

---

# Distribuera ditt projekt

Innan du börjar distribuera projektet till din AEM Forms-Cloud Service rekommenderar vi att du distribuerar projektet till en lokal molnklar instans av AEM Forms.

## Synkronisera ändringar med ditt AEM

Starta IntelliJ och navigera till mappen adaptiveForm under ``ui.apps`` mapp enligt nedan
![intellij](assets/intellij.png)

Högerklicka på ``adaptiveForm`` nod och välj Ny | Paket Kontrollera att du lägger till namnet **adresserblock** till paketet

Högerklicka på det nya paketet ``addressblock`` och markera ``repo | Get Command`` som visas nedan
![repo-sync](assets/sync-repo.png)

Detta bör synkronisera projektet med den lokala molnförberedda AEM Forms-instansen. Du kan verifiera .content.xml-filen för att bekräfta egenskaperna
![efter synkronisering](assets/after-sync.png)

## Distribuera projekt till din lokala instans

Starta ett nytt kommandotolkfönster, navigera till projektets rotmapp och bygg projektet med kommandot som visas nedan
![driftsätta](assets/build-project.png)

När projektet har distribuerats kan adresskomponenten nu användas i ett adaptivt formulär

## Distribuera projektet till molnmiljön

Om allt ser bra ut i den lokala utvecklingsmiljön är nästa steg att driftsätta i [molninstans med molnhanteraren.](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/push-project-to-cloud-manager-git)



