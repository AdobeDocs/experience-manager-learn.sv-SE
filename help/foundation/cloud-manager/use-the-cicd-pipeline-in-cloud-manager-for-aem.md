---
title: Använda CI/CD-pipeline i Adobe Cloud Manager
description: Adobe Cloud Manager är en enkel, men ändå flexibel självbetjäningsmodul för CI/CD som gör det möjligt för AEM projektteam att snabbt, säkert och konsekvent driftsätta kod i alla AEM miljöer som AMS är värd för. I den här videoserien utforskas hur du konfigurerar och kör Cloud Managers CI/CD-pipeline i både felfallsscenarier och framgångsscenarier.
sub-product: cloud-manager, grund
feature: rörledningar, kvalitetsportar
topics: cicd, performance, best-practices, development, governance
doc-type: feature video
activity: understand
audience: all
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '314'
ht-degree: 0%

---


# Använda CI/CD-pipeline i Adobe Cloud Manager

Adobe Cloud Manager är en enkel, men ändå flexibel självbetjäningsmodul för CI/CD som gör det möjligt för AEM projektteam att snabbt, säkert och konsekvent driftsätta kod i alla AEM miljöer som AMS är värd för. I den här videoserien utforskas hur du konfigurerar och kör Cloud Managers CI/CD-pipeline i både felfallsscenarier och framgångsscenarier.

## Introduktion

En introduktion till programmen Cloud Manager och Cloud Manager.

>[!NOTE]
>
>I alla dessa videor har tiden för att skapa, testa och distribuera videon ökat för att minska tiden. En fullständig pipeline-körning tar normalt 45 minuter eller mer (inklusive den obligatoriska 30-minuters prestandatestningen), beroende på projektstorlek, antal AEM och UAT-processer.

>[!VIDEO](https://video.tv.adobe.com/v/23082/?quality=12&learn=on)

## Konfigurera CI/CD-pipeline

I den här videon utforskas hur du konfigurerar pipeline för programmet i Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/23083/?quality=12&learn=on)

## Felaktig pipeline-körning

I den här videon utforskas körningen av CI/CD-pipeline med kod som inte klarar de kvalitetskontroller som krävs av Cloud Manager med hjälp av databasgrenen **[!DNL yellow]**.

>[!VIDEO](https://video.tv.adobe.com/v/23084/?quality=12&learn=on)

## Slutförd pipeline-körning

I den här videon utforskas den lyckade körningen av CI/CD-pipeline med hjälp av kod som klarar de kvalitetskontroller som krävs av Cloud Manager med hjälp av databasgrenen **[!DNL master]**.

Den här videon rör även vid [!UICONTROL Activity]-konsolen i Cloud Manager, där du kan starta om till aktiva körningar eller granska slutförda eller misslyckade körningar.

>[!VIDEO](https://video.tv.adobe.com/v/23085/?quality=12&learn=on)

## Stödmaterial

* [Användarhandbok för Cloud Manager](https://helpx.adobe.com/experience-manager/cloud-manager/user-guide.html)
* [Hämta  [!DNL SonarQube] regler för kodskanning](https://helpx.adobe.com/experience-manager/cloud-manager/using/understand-your-test-results.html#CodeQualityTesting)
   * *XLSX finns längst ned i det länkade avsnittet*
* [[!DNL SonarQube] Java-regelindex](https://rules.sonarsource.com/java/)
