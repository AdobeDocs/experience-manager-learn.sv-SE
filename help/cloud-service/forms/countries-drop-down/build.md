---
title: Bygg, driftsätt och testa komponenten för länder
description: Bygg, driftsätt och testa
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16517
source-git-commit: f9a1fb40aabb6fdc1157e1f2576f9c0d9cf1b099
workflow-type: tm+mt
source-wordcount: '209'
ht-degree: 0%

---

# Bygg, driftsätt och testa komponenten för länder

Om du vill skapa alla moduler och distribuera paketet `all` till en lokal instans av AEM kör du följande kommando i projektets rotkatalog:

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

