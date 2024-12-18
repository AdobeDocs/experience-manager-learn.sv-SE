---
title: Flyttar konfigurationen av molntjänster och formulärdatamodellen till molninstansen
description: Skapa och skicka ett adaptivt formulär baserat på Azure-lagringsformulärens datamodell till molninstansen.
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Developer Tools
jira: KT-9006
exl-id: 77c00a35-43bf-485f-ac12-0fffb307dc16
duration: 45
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '227'
ht-degree: 0%

---

# Inkludera molntjänstkonfiguration i ditt projekt

Skapa en konfigurationsbehållare med namnet &#39;FormTutorial&#39; för konfigurationen av molntjänster
Skapa en molntjänstkonfiguration för Azure Storage som kallas FormsCSAndAzureBlob i behållaren FormTutorial genom att ange information om Azure-lagringskontot och Azure-åtkomstnyckeln.

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
>
>När du skapar och distribuerar ditt projekt med molnhanteraren måste du nu ange din Azure-åtkomstnyckel igen i molntjänstkonfigurationen. För att undvika att ange åtkomstnyckeln igen rekommenderar vi att du skapar kontextmedveten konfiguration med hjälp av miljövariablerna som förklaras i [nästa artikel](./context-aware-fdm.md)

## Nästa steg

[Skapa kontextmedveten konfiguration](./context-aware-fdm.md)
