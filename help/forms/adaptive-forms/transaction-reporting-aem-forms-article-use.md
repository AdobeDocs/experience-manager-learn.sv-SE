---
title: Använda transaktionsrapportering i AEM Forms
description: Med transaktionsrapporter i AEM Forms kan du räkna med alla transaktioner som har utförts sedan ett visst datum i din AEM Forms-distribution.
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
exl-id: 36c38cb6-6f6a-4328-abf5-7a30059b66ce
last-substantial-update: 2019-03-20T00:00:00Z
duration: 81
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '331'
ht-degree: 0%

---

# Använda transaktionsrapportering i AEM Forms{#using-transaction-reporting-in-aem-forms}

Transaktionsrapportering för att fånga upp antalet inskickade formulär, återgivning av dokument med dokumenttjänster och återgivning av interaktiv kommunikation (webben och tryckkanaler) har introducerats i AEM Forms 6.4.1. Den här funktionen är för närvarande endast tillgänglig i AEM Forms OSGI-stacken.

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

eller visa transaktionsrapporten genom att klicka på [här](http://localhost:4502/mnt/overlay/fd/transaction/gui/content/report.html)

![TransctionReporting](assets/transactionreporting.gif)

På skärmbilden ovan Dokumentbearbetat visas antalet dokument som genererats med hjälp av dokumenttjänster. Återgivna dokument är antalet interaktiva kommunikationsdokument (webb och utskrift) som återges. Forms som skickas in är antalet inskickade anpassade formulär.

En transaktion finns kvar i bufferten under en angiven period (Tömningstid för buffert + Omvänd replikeringstid). Som standard tar det ca 90 sekunder för antalet transaktioner att återspeglas i transaktionsrapporten.

Åtgärder som att skicka ett PDF-formulär, använda agentanvändargränssnittet för att förhandsgranska interaktiv kommunikation eller använda icke-standardiserade metoder för att skicka formulär räknas inte som transaktioner. AEM Forms tillhandahåller ett API för att registrera sådana transaktioner. Anropa API:t från dina anpassade implementeringar för att registrera en transaktion.

Om du visar transaktionsrapporten för författarinstansen kontrollerar du att omvänd replikering har konfigurerats för alla publiceringsinstanser.

Mer information om transaktionsrapportering [klicka här](https://helpx.adobe.com/experience-manager/6-4/forms/using/transaction-reports-overview.html)
