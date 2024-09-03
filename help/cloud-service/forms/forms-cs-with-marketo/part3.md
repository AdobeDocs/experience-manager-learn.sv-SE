---
title: Integrera AEM Forms Cloud Service och Marketo (del 3)
description: Lär dig hur du integrerar AEM Forms och Marketo med AEM Forms Form Data Model.
feature: Form Data Model,Integration
version: Cloud Service
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
last-substantial-update: 2024-07-24T00:00:00Z
jira: KT-15876
exl-id: 43737765-b1ea-4594-853a-d78f41136b5e
source-git-commit: ba744f95f8d1f0b982cd5430860f0cb0945a4cda
workflow-type: tm+mt
source-wordcount: '235'
ht-degree: 0%

---

# Skapa formulärdatamodell

När du har konfigurerat datakällan är nästa steg att skapa en formulärdatamodell som baseras på den datakälla som konfigurerats i det tidigare steget. Så här skapar du en formulärdatamodell:

Peka webbläsaren på sidan [ dataintegreringar.](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments-fdm) Den här listan innehåller alla dataintegreringar som har skapats på din AEM.

1. Klicka på Skapa | Formulärdatamodell
1. Ange beskrivande titel som FormsAndMarketo och klicka på Nästa
1. Markera datakällan som konfigurerats i det tidigare steget och klicka på Skapa och redigera för att öppna formulärdatamodellen i redigeringsläget
1. Expandera noden&quot;FormsAndMarketo&quot;. Expandera noden Tjänster
1. Välj den första Get-åtgärden
1. Klicka på Lägg till markerade
1. Klicka på&quot;Markera alla&quot; i dialogrutan&quot;Lägg till associerade modellobjekt&quot; och klicka sedan på Lägg till
1. Spara formulärdatamodellen genom att klicka på knappen Spara
1. Fliken till fliken Tjänster
1. Välj den enda tjänst som visas och klicka på Test Service
1. Ange ett giltigt leadId och klicka på Test. Om allt blir bra bör du få tillbaka leadinformationen som visas på skärmbilden nedan
   ![testresultat](assets/testresults.png)

Nu kan du skapa ett anpassat formulär baserat på den här formulärdatamodellen för att infoga och hämta Marketo-objekt.
