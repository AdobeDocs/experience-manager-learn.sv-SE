---
title: Starta arbetsflöden automatiskt
description: Autostart-arbetsflöden utökar materialbearbetningen genom att automatiskt anropa ett anpassat arbetsflöde vid överföring eller ombearbetning.
feature: Asset Compute Microservices, Workflow
version: Cloud Service
jira: KT-4994
thumbnail: 37323.jpg
topic: Development
role: Developer
level: Intermediate
last-substantial-update: 2023-05-14T00:00:00Z
doc-type: Feature Video
exl-id: 5e423f2c-90d2-474f-8bdc-fa15ae976f18
duration: 410
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '324'
ht-degree: 0%

---

# Starta arbetsflöden automatiskt

Autostart-arbetsflöden utökar materialbearbetningen på AEM as a Cloud Service genom att automatiskt starta ett anpassat arbetsflöde vid överföring eller ombearbetning när resursbearbetningen är klar.

>[!VIDEO](https://video.tv.adobe.com/v/37323?quality=12&learn=on)

>[!NOTE]
>
>Använd Automatisk start av arbetsflöden för att anpassa efterbearbetning av resurser i stället för att använda Workflow Launcher. Autostart-arbetsflöden är _endast_ anropas när en mediefil har bearbetats i stället för startats som kan anropas flera gånger under bearbetning av mediefiler.

## Anpassa efterbearbetningsarbetsflödet

Om du vill anpassa efterbearbetningsarbetsflödet kopierar du standardefterbearbetningen i Assets Cloud [arbetsflödesmodell](../../foundation/workflow/use-the-workflow-editor.md).

1. Börja på skärmen Arbetsflödesmodeller genom att navigera till _verktyg_ > _Arbetsflöde_ > _Models_
2. Sök och välj _Assets Cloud Post-Processing_ arbetsflödesmodell<br/>
   ![Välj arbetsflödesmodellen för efterbearbetning i Assets Cloud](assets/auto-start-workflow-select-workflow.png)
3. Välj _Kopiera_ knapp för att skapa ett anpassat arbetsflöde
4. Välj arbetsflödesmodell (som ska anropas) _Assets Cloud Post-Processing1_) och klicka på _Redigera_ för att redigera arbetsflödet
5. Ge ditt anpassade efterbearbetningsarbetsflöde ett beskrivande namn i Egenskaper för arbetsflöde<br/>
   ![Ändra namnet](assets/auto-start-workflow-change-name.png)
6. Lägg till stegen för att uppfylla dina verksamhetskrav, i det här fallet lägga till en uppgift när resurserna är klara. Se till att det sista steget i arbetsflödet alltid är _Arbetsflödet är klart_ steg<br/>
   ![Lägg till arbetsflödessteg](assets/auto-start-workflow-customize-steps.png)

   >[!NOTE]
   >
   >Automatisk start av arbetsflöden som körs vid varje överföring eller ombearbetning av resurser ska du tänka på skalförändringsfaktorn för arbetsflödessteg, särskilt för gruppåtgärder som [Massimport](../../cloud-service/migration/bulk-import.md) eller migreringar.

7. Välj _Synkronisera_ för att spara ändringarna och synkronisera arbetsflödesmodellen

## Använda ett anpassat efterbearbetningsarbetsflöde

Anpassad efterbearbetning är konfigurerad för mappar. Så här konfigurerar du ett anpassat efterbearbetningsarbetsflöde för en mapp:

1. Markera mappen som du vill konfigurera arbetsflödet för och redigera mappegenskaperna
2. Växla till _Resursbearbetning_ tab
3. Välj ett anpassat efterbearbetningsarbetsflöde i _Starta arbetsflödet automatiskt_ markeringsruta<br/>
   ![Ange efterbearbetningsarbetsflöde](assets/auto-start-workflow-set-workflow.png)
4. Spara ändringarna

Nu kommer ditt anpassade efterbearbetningsarbetsflöde att köras för alla resurser som överförts eller bearbetats i den mappen.
