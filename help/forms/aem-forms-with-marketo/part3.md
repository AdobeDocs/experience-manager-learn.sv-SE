---
title: AEM Forms med Marketo (del 3)
description: Självstudiekurs för att integrera AEM Forms med Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: Experience Manager 6.4, Experience Manager 6.5
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: 7096340b-8ccf-4f5e-b264-9157232e96ba
duration: 78
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '217'
ht-degree: 0%

---

# Skapa formulärdatamodell

När du har konfigurerat datakällan är nästa steg att skapa en formulärdatamodell som baseras på den datakälla som konfigurerats i det tidigare steget. Så här skapar du en formulärdatamodell:

Peka webbläsaren på sidan [&#x200B; dataintegreringar.](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments-fdm) Den här listan innehåller alla dataintegreringar som har skapats på din AEM-instans.

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

## Nästa steg

[Sammanställ allt för testning](./part4.md)
