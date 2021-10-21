---
title: Flyttar konfigurationen av molntjänster och formulärdatamodellen till molninstansen
description: Skapa och skicka ett adaptivt formulär baserat på Azure-lagringsformulärens datamodell till molninstansen.
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
topic: Development
kt: 9006
source-git-commit: d38da94bd4164163a16899b565c90b159194580a
workflow-type: tm+mt
source-wordcount: '202'
ht-degree: 0%

---


# Inkludera molntjänstkonfiguration i ditt projekt

Skapa en konfigurationsbehållare med namnet FormsTutorial som innehåller din molntjänstkonfiguration Skapa en molntjänstkonfiguration för Azure Storage med namnet Store Form Submissions in Azure i FormsTutorial-behållaren. Ange information om Azure-lagringskontot och kontonyckeln

Öppna AEM i IntelliJ. Se till att du lägger till mappen FormTutorial så som visas nedan i ui.content-projektet
![cloud-services-configuration](assets/cloud-services-configuration.png)

Se till att du lägger till följande post i ui.content-projektets filter.xml

```xml
<filter root="/conf/FormTutorial" mode="replace"/>
```

![filter-xml](assets/ui-content-filter.png)

## Inkludera formulärdatamodell i projektet

Skapa formulärdatamodell baserat på den molntjänstkonfiguration som du skapade i det tidigare steget. Om du vill inkludera formulärdatamodellen i ditt projekt skapar du rätt mappstruktur i ditt AEM i IntelliJ. Min formulärdatamodell finns till exempel i en mapp som kallas registreringar
![fdm-content](assets/ui-content-fdm.png)

Inkludera lämplig post i ui.content-projektets filter.xml

```xml
<filter root="/content/dam/formsanddocuments-fdm/registrations" mode="replace"/>
```


>[!NOTE]

>När du skapar och distribuerar ditt projekt blir formulärdatamodellen baserad på molntjänstkonfigurationen tillgänglig i din molninstans





