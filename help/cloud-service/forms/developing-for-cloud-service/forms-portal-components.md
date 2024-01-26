---
title: Aktivera AEM Forms Portal-komponenter
description: Bygg en AEM Forms Portal med komponenter
solution: Experience Manager
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Core Components
jira: KT-10373
exl-id: ab01573a-e95f-4041-8ccf-16046d723aba
duration: 92
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '332'
ht-degree: 0%

---

# Forms Portal Components

AEM Forms tillhandahåller följande portalkomponenter direkt:

**Sök och visa**: Den här komponenten gör att du kan lista formulär från formulärdatabasen på portalsidan och innehåller konfigurationsalternativ för att lista formulär baserat på angivna villkor.

**Utkast och inskickat material**: Medan komponenten Sök och lista visar formulär som har publicerats av Forms författare, visar komponenten Utkast och inskickningar formulär som har sparats som utkast för att fylla i senare och skickade formulär. Den här komponenten ger en personaliserad upplevelse till alla inloggade användare.

**Länk**: Med den här komponenten kan du skapa en länk till ett formulär var som helst på sidan.

## Aktivera Forms Portal-komponenter

Starta IntelliJ och öppna det BankingApplication-projekt som skapats i [tidigare steg.](./getting-started.md) Expandera ui.apps->src->main->content->jcr_root->apps.bankingapplication->komponenterna

Om du vill använda en huvudkomponent (inklusive färdiga portalkomponenter) på en Adobe Experience Manager (AEM) webbplats måste du skapa en proxykomponent och aktivera den för din webbplats.
Den nyligen skapade proxykomponenten måste peka i utkanten av formulärkomponenten, så att de ärver allt från dem. Detta görs genom att ändra resourceSuperType i content.xml för proxykomponenten. I content.xml anger vi också titeln och komponentgruppen.
>[!NOTE]
>
> Du kan konstruera resurssupertypen för var och en av [dessa komponenter härifrån](https://github.com/adobe/aem-core-forms-components/tree/master/ui.apps/src/main/content/jcr_root/apps/core/fd/components/formsportal)


### Utkast och inlagor

Skapa en kopia av en befintlig komponent (till exempel `button`) och namnge det som _utkast och inskick_.
![utkast och inskick](assets/forms-portal-components2.png)
Ersätta innehållet i dialogrutan `.content.xml` med följande XML:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
          jcr:primaryType="cq:Component"
          jcr:title="Drafts And Submissions"
          sling:resourceSuperType="core/fd/components/formsportal/draftsandsubmissions/v1/draftsandsubmissions"
          componentGroup="BankingApplication - Content"/>
```

### Sök och visa

Skapa en kopia av knappkomponenten och ge den ett nytt namn _searchandlister_.
Ersätta innehållet i dialogrutan `.content.xml` med följande XML:


```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
          jcr:primaryType="cq:Component"
          jcr:title="Search And Lister"
          sling:resourceSuperType="core/fd/components/formsportal/searchlister/v1/searchlister"
          componentGroup="BankingApplication - Content"/>
```

### Länkkomponent

Skapa en kopia av knappkomponenten och ge den ett nytt namn _link_.
Ersätta innehållet i dialogrutan `.content.xml` med följande XML:


```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
          jcr:primaryType="cq:Component"
          jcr:title="Link to Adaptive Form"
          sling:resourceSuperType="core/fd/components/formsportal/link/v2/link"
          componentGroup="BankingApplication - Content"/>
```

När ditt projekt är distribuerat bör du kunna använda de här komponenterna på din AEM sida för att skapa en Forms-portal.

## Nästa steg

[Inkludera molntjänstkonfiguration](./azure-storage-fdm.md)
