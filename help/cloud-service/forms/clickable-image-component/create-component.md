---
title: Skapa klickbar bildkomponent
description: Skapa klickbar bildkomponent i AEM Forms as a Cloud Service
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15968
exl-id: b635f171-775d-480e-bf7a-c92ab4af0aee
source-git-commit: b4df652fcda0af5d01077b97aa7fa17cfe2abf4b
workflow-type: tm+mt
source-wordcount: '223'
ht-degree: 0%

---

# Skapa komponent

I den här artikeln förutsätts att du har erfarenhet av att utveckla för AEM Forms CS. Det förutsätts också att du har skapat ett AEM Forms-arkivtypsprojekt.

Öppna ditt AEM Forms-projekt i IntelliJ eller någon annan utvecklingsmiljö. Skapa en ny nod med namnet svg under

```
apps\corecomponent\components\adaptiveForm
```

>[!NOTE]
>
> ``corecomponent`` är det appId som angavs när Maven-projektet skapades. Detta appId kan vara ett annat i din miljö.


## Skapa filen .content.xml

Skapa en fil med namnet .content.xml under svg-noden. Lägg till följande innehåll i den nyligen skapade filen. Du kan ändra jcr:description,jcr:title och componentGroup enligt dina krav.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:sling="http://sling.apache.org/jcr/sling/1.0"
    jcr:description="USA MAP"
    jcr:primaryType="cq:Component"
    jcr:title="USA MAP"
    sling:resourceSuperType="wcm/foundation/components/responsivegrid"
    componentGroup="CustomCoreComponent - Adaptive Form"/>
```

## Skapa svg.html

Skapa en fil med namnet svg.html. Den här filen återger mappningen SVG i USA.Kopiera innehållet i [svg.html](assets/svg.html) till den nya filen. Det du har kopierat är kartan SVG i USA. Spara filen.

## Distribuera projektet

Distribuera projektet till en lokal molnklar instans för att testa komponenten.

Om du vill distribuera projektet måste du navigera till projektets rotmapp i kommandotolken och köra följande kommando.

```
mvn clean install -PautoInstallSinglePackage
```

Detta distribuerar projektet till din lokala AEM Forms-instans och komponenten kommer att finnas tillgänglig för att inkluderas i ditt adaptiva formulär

![usa-karta](./assets/usa-map.png)
