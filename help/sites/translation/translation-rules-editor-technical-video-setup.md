---
title: Ställ in översättningsregler i AEM
description: Med översättningskonfigurationens gränssnitt kan en användare hantera regler för översättning av innehåll i AEM Sites. I den här videon beskrivs hur du skapar en ny översättningsregel för en anpassad komponent.
feature: Language Copy
version: Experience Manager 6.4, Experience Manager 6.5
topic: Localization
role: User
level: Beginner
doc-type: Technical Video
exl-id: 359da531-839c-4680-abf9-c880cc700159
duration: 542
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '276'
ht-degree: 0%

---

# Konfigurera översättningsregler {#set-up-translation-rules-in-aem}

Med översättningskonfigurationens gränssnitt kan en användare hantera regler för översättning av innehåll i AEM Sites. I den här videon beskrivs hur du skapar en ny översättningsregel för en anpassad komponent.

>[!NOTE]
>
> Videon nedan spelades in på AEM 6.3. I AEM 6.4+ introduceras en ny databasstruktur för lagring av XML-filen för översättningsregler. När du använder användargränssnittet för översättningskonfiguration i AEM 6.4 sparas reglerna på platsen `/conf/global/settings/translation/rules/translation_rules.xml`. Mer information finns i [Identifiera innehåll som ska översättas](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-rules.html).

>[!VIDEO](https://video.tv.adobe.com/v/18135?quality=12&learn=on)

Översättningsregler identifierar innehåll i AEM som ska extraheras för översättning. Översättningsreglerna som finns i kartongen omfattar vanliga användningsområden som textkomponenter och alternativ text för bildkomponenter. Beroende på ett projekts översättningskrav kan ytterligare regler behövas. I allmänhet tillåter översättningsregler användare att ange:

1. Egenskaper som ska översättas baserat på sökväg och/eller resurstyp
2. Filter för egenskaper som INTE ska översättas
3. Refererat innehåll som ska översättas (t.ex. bilder eller innehållsfragment)

Översättningsregelredigeraren som uppdaterar XML-översättningsfilen. Gränssnittet för översättningskonfiguration gör det enklare att hantera olika översättningsregler och skydda mot typos när du redigerar XML direkt.

Gå till gränssnittet för översättningskonfiguration:

* **[!UICONTROL AEM Start Menu]> [!UICONTROL Tools] > [!UICONTROL General] > [[!UICONTROL Translation Configuration]](http://localhost:4502/libs/cq/translation/translationrules/contexts.html)**

## Före AEM 6.3 {#prior-to-aem}

Översättningsreglerna för tidigare versioner av AEM uppdaterades manuellt genom att en XML-fil som finns under översättningsarbetsflödet redigerades: `/etc/workflow/models/translation/translation_rules.xml`.

## Ytterligare resurser {#additional-resources}

* [Identifierar innehåll som ska översättas](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-rules.html)
* [Översätter innehåll för flerspråkiga webbplatser](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/translation.html)
* [https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-manage.html](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-manage.html)
* [Bästa praxis för översättning](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-bp.html)
