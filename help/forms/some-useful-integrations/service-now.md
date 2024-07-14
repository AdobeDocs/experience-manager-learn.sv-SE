---
title: Integrerar med  [!DNL ServiceNow]
description: Skapa och visa alla incidenter med hjälp av formulärdatamodell.
feature: Adaptive Forms
version: 6.4,6.5
jira: KT-9957
topic: Development
role: Developer
level: Intermediate
exl-id: 93a177b0-7852-44da-89cc-836d127be4e7
last-substantial-update: 2022-07-07T00:00:00Z
duration: 47
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '228'
ht-degree: 0%

---

# Integrera AEM Forms med [!DNL ServiceNow]

Skapa och visa incidenter i [!DNL ServiceNow] med hjälp av formulärdatamodellen i AEM Forms.

## Förutsättningar

* [!DNL ServiceNow]-konto.
* Välbekant med [att skapa datakällor](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html)
* Välbekant med [formulärdatamodellen](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html)

## Exempel på Assets

Följande exempelresurser finns i artikeln

* Konfiguration av molntjänster
* Växla filer för att skapa en incident och hämta alla   incidenter
* Formulärdatamodell baserad på swagger-filer
* Anpassat formulär för att skapa och lista [!DNL ServiceNow] incidenter

## Distribuera resurserna på servern

* Hämta [exempelresurserna](assets/service-now.zip)
* Importera resurserna till AEM med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Swagger-filen som används för den här integreringen finns under mappen ```/conf/9957/settings/cloudconfigs/fdm``` i crx-databasen
* Redigera [CreateIncident-molntjänstkonfigurationen](http://localhost:4502/mnt/overlay/fd/fdm/gui/components/admin/fdmcloudservice/properties.html?item=%2Fconf%2F9957%2Fsettings%2Fcloudconfigs%2Ffdm%2Fcreateincident)så att den matchar ServiceNow-instansen.
* Redigera molntjänstkonfigurationen [GetAllIncidents](http://localhost:4502/mnt/overlay/fd/fdm/gui/components/admin/fdmcloudservice/properties.html?item=%2Fconf%2F9957%2Fsettings%2Fcloudconfigs%2Ffdm%2Fgetallincidents) så att den matchar ServiceNow-instansen. Du måste ändra värden, användarnamn och lösenord för att matcha dina ServiceNow-instansreferenser.

## Åtkomst till ServiceNow-instansreferenser

* Klicka på din användarprofil
  ![klicka på användarprofilen](assets/snow-1.png)

* Klicka på Hantera instanslösenord
* Instansinformationen visas nedan
  ![instansinformation](assets/snow-3.png)

## Testa integreringen

* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/create-incident-in-service-now/jcr:content?wcmmode=disabled)
* Ange några värden i beskrivnings- och kommentarsfältet och klicka på knappen Skapa incident
* Incident-ID för den nyligen skapade incidenten ska fyllas i i textfältet och tabellen nedan ska innehålla alla incidenter.
