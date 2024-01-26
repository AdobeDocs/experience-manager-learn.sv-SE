---
title: AEM Forms med Marketo (del 4)
description: Självstudiekurs för att integrera AEM Forms med Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: 6.4,6.5
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: 6b44e6b2-15f7-45b2-8d21-d47f122c809d
duration: 84
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '334'
ht-degree: 0%

---

# Skapa anpassat formulär med hjälp av formulärdatamodell

Nästa steg är att skapa ett adaptivt formulär och basera det på den formulärdatamodell som skapades i det tidigare steget.
Användaren anger lead-ID:t och när Marketo-tjänsten tabbas anropas lead by ID:t. Resultatet av tjänståtgärden mappas sedan till lämpliga fält i Adaptive Forms.

1. Skapa ett adaptivt formulär och basera det på en tom formulärmall, associera det med den formulärdatamodell som skapades i det tidigare steget.
1. Öppna formuläret i redigeringsläge
1. Dra och släpp en TextField-komponent och en panelkomponent i det adaptiva formuläret. Ange rubriken för TextField-komponenten &quot;Enter Lead Id&quot; och ställ in dess namn på &quot;LeadId&quot;
1. Dra och släpp två TextField-komponenter till panelkomponenten
1. Ange namn och titel för de två TextField-komponenterna som FirstName och LastName
1. Konfigurera panelkomponenten så att den är en repeterbar komponent genom att ange Minimum till 1 och Maximum till -1. Detta krävs eftersom Marketo-tjänsten returnerar en array med Lead-objekt och du måste ha en upprepningsbar komponent för att kunna visa resultatet. I det här fallet får vi bara tillbaka ett Lead-objekt eftersom vi söker efter Lead-objekt med dess ID.
1. Skapa en regel i fältet LeadId så som visas i bilden nedan
1. Förhandsgranska formuläret och ange ett giltigt lead-ID i fältet LeadID och tabba ut. Fälten Förnamn och Efternamn ska fyllas i med resultatet av serviceanropet.

I följande skärmbild förklaras inställningarna för regelredigeraren

![linjalredigerare](assets/ruleeditor.jfif)

## Felsökning

Om du använder de paket som ingår i den här artikeln kanske du vill aktivera [felsökningsloggar](http://localhost:4502/system/console/slinglog) för följande klasser:

+ `com.marketoandforms.core.impl.MarketoServiceImpl`
+ `com.marketoandforms.core.MarketoConfigurationService`

## Grattis

Du har integrerat AEM Forms med Marketo med AEM Forms Form Data Model.