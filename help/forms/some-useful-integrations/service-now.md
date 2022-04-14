---
title: Integrera med [!DNL ServiceNow]
description: Skapa och visa alla incidenter med hjälp av formulärdatamodell.
feature: Adaptive Forms
version: 6.4,6.5
kt: 9957
topic: Development
role: Developer
level: Intermediate
exl-id: 93a177b0-7852-44da-89cc-836d127be4e7
source-git-commit: 81a15fb0182760aaac8cb58cccbfe28de7323492
workflow-type: tm+mt
source-wordcount: '230'
ht-degree: 0%

---

# Integrera AEM Forms med [!DNL ServiceNow]

Skapa och visa incidenter i [!DNL ServiceNow] med formulärdatamodell i AEM Forms.

## Förutsättningar

* [!DNL ServiceNow] konto.
* Välbekant med [skapa datakällor](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html)
* Välbekant med [Formulärdatamodell](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html)

## Exempelresurser

Följande exempelresurser finns i den här artikeln:
* Konfiguration av molntjänster
* Växla filer för att skapa en incident och hämta alla incidenter
* Formulärdatamodell baserad på swagger-filer
* Anpassat formulär för att skapa och lista [!DNL ServiceNow] incidenter

## Distribuera resurserna på servern

* Ladda ned [exempelresurser](assets/service-now.zip)
* Importera resurser till AEM med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Redigera [Konfiguration av molntjänsten CreateIncident](http://localhost:4502/mnt/overlay/fd/fdm/gui/components/admin/fdmcloudservice/properties.html?item=%2Fconf%2F9957%2Fsettings%2Fcloudconfigs%2Ffdm%2Fcreateincident)för att matcha ServiceNow-instansen.
* Redigera [Konfiguration av molntjänsten GetAllIncidents](http://localhost:4502/mnt/overlay/fd/fdm/gui/components/admin/fdmcloudservice/properties.html?item=%2Fconf%2F9957%2Fsettings%2Fcloudconfigs%2Ffdm%2Fgetallincidents) för att matcha ServiceNow-instansen

## Testa integreringen

* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/create-incident-in-service-now/jcr:content?wcmmode=disabled)
* Ange några värden i beskrivnings- och kommentarsfältet och klicka på knappen Skapa incident
* Incident-ID för den nyligen skapade incidenten ska fyllas i i textfältet och tabellen nedan ska innehålla alla incidenter.
