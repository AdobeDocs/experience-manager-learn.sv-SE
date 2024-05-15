---
title: Samla in arbetsflödeskommentarer i adaptiv Forms Workflow
description: Samla in arbetsflödeskommentarer AEM arbetsflödet
feature: Workflow
version: 6.4
topic: Development
role: Developer
level: Experienced
exl-id: 5c250bbb-bac6-427d-8aca-1fbb1229e02c
last-substantial-update: 2020-10-10T00:00:00Z
duration: 73
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '350'
ht-degree: 0%

---

# Samla in arbetsflödeskommentarer i adaptiv Forms Workflow{#capturing-workflow-comments-in-adaptive-forms-workflow}

>[Gäller endast AEM Forms 6.4. I AEM Forms 6.5 ska du använda funktionen för variabler för att uppnå detta]

En vanlig begäran är möjligheten att inkludera kommentarer som har angetts av uppgiftsgranskaren i ett e-postmeddelande. I AEM Forms 6.4 finns det ingen mekanism som fångar in de kommentarer som användaren har skrivit och som lägger in dem via e-post.

För att uppfylla detta krav finns ett exempel på ett OSGi-paket som kan användas för att samla in kommentarer och lagra dessa kommentarer som arbetsflödets metadataegenskap.

I följande skärmbild visas hur du använder processteg i [AEM](http://localhost:4502/editor.html/conf/global/settings/workflow/models/CaptureComments.html) om du vill samla in kommentarer och lagra dem som metadataegenskaper. &quot;Capture Workflow Comments&quot; är namnet på den java-klass som ska användas i processsteget. Du måste skicka metadataegenskapsnamnet som innehåller kommentarerna. I skärmbilden nedan är managerComments metadataegenskapen som lagrar kommentarerna.

![arbetsflödenkommentarer1](assets/workflowcomments1.gif)

Så här testar du den här funktionen på datorn:
* [Kontrollera att processteget i arbetsflödet är konfigurerat att använda kommentarerna i arbetsflödet](http://localhost:4502/editor.html/conf/global/settings/workflow/models/CaptureComments.html)

* [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Distribuera paketet SetValue](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). Paketet innehåller exempelkoden som fångar in kommentarerna och lagrar den som en metadataegenskap

* [Ladda ned och zippa upp resurser som hör till den här artikeln i ditt filsystem](assets/capturecomments.zip) Resurserna innehåller en arbetsflödesmodell och ett exempel på adaptiv form.

* Importera de två ZIP-filerna till AEM med hjälp av pakethanteraren

* [Förhandsgranska formuläret genom att bläddra till denna URL](http://localhost:4502/content/dam/formsanddocuments/capturecomments/jcr:content?wcmmode=disabled)

* Fyll i formulärfälten och skicka formuläret

* [Kontrollera AEM](http://localhost:4502/aem/inbox)

* Öppna uppgiften från inkorgen och skicka formuläret. Ange några kommentarer när du uppmanas till det.

Kommentarerna lagras i metadataegenskapen som kallas `managerComments` i AEM. Om du vill söka efter kommentarer loggar du in som administratör. Arbetsflödesinstanserna lagras i följande sökväg:

`/var/workflow/instances/server0`

Välj lämplig arbetsflödesinstans och sök efter egenskapen managerComments i metadatanoden.
