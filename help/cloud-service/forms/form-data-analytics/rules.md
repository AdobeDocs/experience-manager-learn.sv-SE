---
title: Rapportera inskickade formulärdatafält med hjälp av Adobe Analytics
description: Integrera AEM Forms CS med Adobe Analytics för att rapportera formulärdatafält
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 12557
source-git-commit: 4100061624bd8955bee392f1eced20f388f2902c
workflow-type: tm+mt
source-wordcount: '220'
ht-degree: 0%

---

# Definiera regeln

I taggegenskapen skapade vi 2 nya [regler](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/configure-tags/add-data-elements-rules.html)(**Fältvalideringsfel och FormSubmit**).
![adaptiv form](assets/rules.png)


## Fältvalideringsfel

The **Fältvalideringsfel** Regeln aktiveras varje gång ett valideringsfel uppstår i ett anpassat formulärfält. I vårt formulär visas till exempel ett valideringsfelmeddelande om telefonnumret eller e-postadressen inte har det förväntade formatet.
Regeln för fältverifieringsfel konfigureras genom att händelsen ställs in på _**Adobe Experience Manager Forms-Error**_ som på skärmbilden

![sökande-stat-bosättning](assets/field_validation_error_rule.png)

Adobe Analytics - Ange variabler är konfigurerat enligt följande

![ange åtgärd](assets/field_validation_action_rule.png)

## Skicka formulär-regel

Regeln Skicka formulär aktiveras varje gång ett anpassat formulär skickas.
Regeln Skicka formulär konfigureras med _**Adobe Experience Manager Forms - skicka**_ event

![form-submit-rule](assets/form-submit-rule.png)

I regeln Skicka formulär anger dataelementets värde _**SökandeStatAvBosättning**_ mappas till prop5 och värdet för dataelementet FormTitle mappas till prop8.

Adobe Analytics - Ange variabler konfigureras enligt följande.
![form-submit-rule-set-variables](assets/form-submit-set-variable.png)

När du är redo att testa taggar-koden[publicera dina ändringar av taggarna](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/publishing-flow.html) publiceringsflödet.
