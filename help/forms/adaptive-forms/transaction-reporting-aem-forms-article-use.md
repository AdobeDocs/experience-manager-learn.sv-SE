---
title: Använda transaktionsrapportering i AEM Forms
description: Med transaktionsrapporter i AEM Forms kan du räkna med alla transaktioner som har utförts sedan ett visst datum i din AEM Forms-distribution.
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
exl-id: 36c38cb6-6f6a-4328-abf5-7a30059b66ce
last-substantial-update: 2019-03-20T00:00:00Z
duration: 68
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '343'
ht-degree: 0%

---

# Använda transaktionsrapportering i AEM Forms{#using-transaction-reporting-in-aem-forms}

Transaktionsrapportering för att fånga upp antalet inskickade formulär, återgivning av dokument med dokumenttjänster och återgivning av interaktiv kommunikation (webben och tryckkanaler) har introducerats i AEM Forms 6.4.1. Den här funktionen har introducerats med AEM Forms 6.4.1 för AEM Forms OSGi-stacken och 6.5.20 för AEM Forms JEE-stacken.

## Aktivera transaktionsrapportering {#enabling-transaction-reporting}

Som standard är transaktionsregistrering inaktiverat. Följ stegen nedan för att aktivera transaktionsregistrering:

* [Öppna configMgr](http://localhost:4502/system/console/configMgr)
* Sök efter&quot;Forms Transaction Reporting&quot;
* Markera kryssrutan&quot;Registrera transaktioner&quot;
* Spara ändringarna

När transaktionsrapportering är aktiverat kan du skicka adaptiva Forms-dokument, generera dokument med hjälp av dokumenttjänster eller återge interaktiva kommunikationsdokument för att se hur transaktionsrapporteringen fungerar.

## Visa transaktionsrapport {#viewing-transaction-report}

Om du vill visa transaktionsrapporten loggar du in på AEM Forms som administratör. Endast medlemmar i gruppen fd-Administrator kan visa transaktionsrapporten.

Välj verktyg | Forms | Visa transaktionsrapport

eller visa transaktionsrapporten genom att klicka [här](http://localhost:4502/mnt/overlay/fd/transaction/gui/content/report.html)

![TransctionReporting](assets/transactionreporting.gif)

På skärmbilden ovan Dokumentbearbetat visas antalet dokument som genererats med hjälp av dokumenttjänster. Återgivna dokument är antalet interaktiva kommunikationsdokument (webb och utskrift) som återges. Forms som skickas in är antalet inskickade anpassade formulär.

En transaktion finns kvar i bufferten under en angiven period (Tömningstid för buffert + Omvänd replikeringstid). Som standard tar det ca 90 sekunder för antalet transaktioner att återspeglas i transaktionsrapporten.

Åtgärder som att skicka ett PDF-formulär, använda agentgränssnittet för att förhandsgranska interaktiv kommunikation eller använda icke-standardiserade metoder för att skicka formulär räknas inte som transaktioner. AEM Forms tillhandahåller ett API för att registrera sådana transaktioner. Anropa API:t från dina anpassade implementeringar för att registrera en transaktion.

Om du visar transaktionsrapporten för författarinstansen kontrollerar du att omvänd replikering har konfigurerats för alla publiceringsinstanser.

Om du vill veta mer om transaktionsrapportering [klickar du här](https://helpx.adobe.com/se/experience-manager/6-4/forms/using/transaction-reports-overview.html)
