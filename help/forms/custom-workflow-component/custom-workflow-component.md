---
title: Skapa en arbetsflödeskomponent för att spara formulärbilagor i filsystemet
description: Skriva adaptiva formulärbilagor i filsystemet med en anpassad arbetsflödeskomponent
feature: Workflow
version: 6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2021-11-28T00:00:00Z
exl-id: acc701ec-b57d-4c20-8f97-a5a69bb180cd
duration: 89
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '360'
ht-degree: 0%

---

# Anpassad arbetsflödeskomponent

Den här självstudiekursen är avsedd för AEM Forms-kunder som behöver skapa anpassade arbetsflödeskomponenter. Arbetsflödeskomponenten kommer att konfigureras för att köra koden som skrevs i föregående steg. Arbetsflödeskomponenten kan ange processargument för koden. I den här artikeln ska vi utforska arbetsflödeskomponenten som är kopplad till koden.


[Hämta den anpassade arbetsflödeskomponenten](assets/saveFiles.zip)
Importera arbetsflödeskomponenten [använda pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)

Den anpassade arbetsflödeskomponenten finns i /apps/AEMFormsDemoListings/workflowComponent/SaveFiles

Markera noden Spara filer och granska dess egenskaper

**componentGroup** - Värdet för den här egenskapen avgör kategorin för arbetsflödeskomponenten.

**jcr:Title** - Det här är arbetsflödeskomponentens titel.

**sling:resourceSuperType** Värdet för den här egenskapen avgör den här komponentens arv. I det här fallet ärver vi från processkomponenten


![component-properties](assets/component-properties1.png)

## cq:dialog

I dialogrutor kan författaren interagera med komponenten. Cq:dialog finns under noden SaveFiles
![cq-dialog](assets/cq-dialog.png)

Noderna under noden items representerar flikarna för komponenten som författare interagerar med komponenten. Vanliga flikar och processflikar är dolda. Flikarna Gemensamt och Argument visas.

Processargumenten för processen finns under processarnoden

![processargument](assets/process-arguments.png)

Författaren anger argumenten enligt skärmbilden nedan
![workflow-component](assets/custom-workflow-component.png)

Värdena lagras som egenskaper för metadatanoden. Värdet **c:\formbilagor** lagras i metadatanodens saveToLocation-egenskap
![save-location](assets/save-to-location.png)

## cq:editConfig

Cq:EditConfig är helt enkelt en nod med den primära typen cq:EditConfig och namnet cq:editConfig under komponentroten. Redigeringsbeteendet för en komponent konfigureras genom att en cq:editConfig-nod av typen cq:EditConfig läggs till under komponentnoden (av typen cq:Component)

![edit-config](assets/cq-edit-config.png)

cq:formParameters (nodtyp nt:unStructed): definierar ytterligare parametrar som läggs till i dialogformuläret.


Observera egenskaperna för cq:formParameters-noden
![from-parameters-properties](assets/form-parameters-properties.png)

Värdet för egenskapen PROCESS anger den java-kod som ska associeras med arbetsflödeskomponenten.
