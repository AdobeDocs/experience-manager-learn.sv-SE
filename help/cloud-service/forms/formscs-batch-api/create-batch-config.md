---
title: Konfigurera batchdatakonfiguration
description: Konfigurera batchdatakonfiguration
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Output Service
topic: Development
jira: KT-9673
exl-id: db25e5a2-e1a8-40ad-af97-35604d515450
duration: 233
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '135'
ht-degree: 0%

---

# Skapa batchkonfiguration

Om du vill använda ett batch-API skapar du en batchkonfiguration och kör en körning som baseras på den konfigurationen. I följande video visas en demonstration av hur du skapar en gruppkonfiguration med API:t

>[!NOTE]
>Kontrollera att AEM tillhör gruppen ```forms-users``` för att göra API-anrop.


>[!VIDEO](https://video.tv.adobe.com/v/340241?quality=12&learn=on)

## Skapa batchkonfiguration

Följande är POSTENS slutpunkt för att skapa batchkonfigurationen

```xml
<baseURL>/config
```

Följande är den lägsta konfiguration som måste anges när batchkonfigurationen skapas. Detta måste skickas som JSON-objekt i HTTP-begärans brödtext

```
{
	"configName": "monthlystatements",
	"dataSourceConfigUri": "/conf/batchapi/settings/forms/usc/batch/batchapitutorial",
	"outputTypes": [
		"PDF"
	],
	"template": "crx:///content/dam/formsanddocuments/formtemplates/custom_fonts.xdp"

}
```

## Verifiera batchkonfiguration

Du kan göra ett anrop till följande slutpunkt om du vill verifiera att batchkonfigurationen har skapats


```xml
<baseURL>/config/monthlystatements
```

Du behöver bara skicka ett tomt JSON-objekt i HTTP-begärans innehåll
