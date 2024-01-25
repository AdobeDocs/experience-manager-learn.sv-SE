---
title: AEM Forms med Marketo (del 3)
description: Självstudiekurs för att integrera AEM Forms med Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: 6.4,6.5
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: 7096340b-8ccf-4f5e-b264-9157232e96ba
duration: 86
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '379'
ht-degree: 0%

---

# Konfigurera datakälla

Med AEM Forms dataintegrering kan du konfigurera och ansluta till olika datakällor. Följande typer stöds inte. Men med lite anpassning kan ni också integrera med andra datakällor.

1. Relationsdatabaser - MySQL, Microsoft SQL Server, IBM DB2 och Oracle RDBMS
1. AEM användarprofil
1. RESTful web services
1. SOAP-baserade webbtjänster
1. OData-tjänster

För integreringen av AEM Forms med Marketo använder vi RESTful-webbtjänster. Det första steget i integreringen är att konfigurera en [datakälla.](https://helpx.adobe.com/experience-manager/6-4/forms/using/configure-data-sources.html#ConfigureRESTfulwebservices) Använd swagger-filen som ingår i kursen. I följande skärmbild visas de viktiga egenskaper som måste anges när datakällan konfigureras.
![datakälla](assets/datasource.jfif)

&quot;marketo.json&quot; är swagger-filen som du får som en del av kursens resurser.
Egenskapsvärden är specifik för din Marketo-instans.
Autentiseringstypen är anpassad och autentiseringsimplementeringen måste matcha AemForms med Marketo. (Om du inte har ändrat detta i koden).

## Skapa formulärdatamodell

När du har konfigurerat datakällan är nästa steg att skapa en formulärdatamodell som baseras på den datakälla som konfigurerats i det tidigare steget. Så här skapar du en formulärdatamodell:

Peka webbläsaren mot [dataintegreringssida.](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments-fdm) Här visas alla dataintegreringar som har skapats på din AEM.

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
   ![testresultat](assets/testresults.jfif)

## Nästa steg

[Sammanställ allt för testning](./part4.md)
