---
title: Bygg, driftsätt och testa komponenten för länder
description: Bygg, driftsätt och testa
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16517
exl-id: ab9bd406-e25e-4e3c-9f67-ad440a8db57e
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '209'
ht-degree: 0%

---

# Bygg, driftsätt och testa komponenten för länder

Om du vill skapa alla moduler och distribuera `all`-paketet till en lokal instans av AEM kör du följande kommando i projektets rotkatalog:

```mvn clean install -PautoInstallSinglePackage```

## Testa komponenten

Så här integrerar du komponenten countries i din AEM Forms Cloud Ready-instans och konfigurerar den:

* Extrahera innehållet i zip-filen [countries](assets/countries.zip). Varje fil ska innehålla data för en specifik kontinent.
* Överför JSON-filerna under content/dam/corecomponent.This är platsen som koden söker efter JSON-filerna.Om du vill lagra JSON-filerna på en annan plats måste du uppdatera Java-koden i klassen CountryDropDownImpl. Uppdatera sökvägen i metoden init() där JSON-filerna läses in. Om du till exempel vill lagra JSON-filerna i content/dam/mydata/ uppdaterar du sökvägen så här

```java
String jsonPath = "/content/dam/mydata/" + getContinent() + ".json"; // Update path accordingly
```

* Logga in på din AEM Forms Cloud Ready Instance
* Skapa ett adaptivt formulär och släpp komponenten Länder i formuläret
* Konfigurera komponenten Länder med hjälp av dialogruteredigeraren och ange olika egenskaper, inklusive kontinenten
  ![innehåll](assets/select-continent.png)
* Förhandsgranska formuläret och kontrollera att den nedrullningsbara listan fungerar som förväntat
