---
title: Rapportera inskickade formulärdatafält med Adobe Analytics
description: Integrera AEM Forms CS med Adobe Analytics för att rapportera formulärdatafält
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Integrations, Development
jira: KT-12557
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: 9982e041-fff7-4be6-91c9-e322d2fd3e01
duration: 41
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '221'
ht-degree: 0%

---

# Definiera regeln

I taggegenskapen skapade vi två nya [regler](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/configure-tags/add-data-elements-rules.html) (**Fältvalideringsfel och FormSubmit**).

![adaptiv form](assets/rules.png)


## Fältvalideringsfel

Regeln **Fältvalideringsfel** aktiveras varje gång det finns ett valideringsfel i anpassat formulärfält. I vårt formulär visas till exempel ett valideringsfelmeddelande om telefonnumret eller e-postadressen inte har det förväntade formatet.

Regeln för fältverifieringsfel konfigureras genom att händelsen ställs in på _**Adobe Experience Manager Forms-Error**_ så som visas på skärmbilden



![sökande-stat-bosättning](assets/field_validation_error_rule.png)

Adobe Analytics - Ange variabler är konfigurerat enligt följande

![ange åtgärd](assets/field_validation_action_rule.png)

## Skicka formulär-regel

Regeln Skicka formulär aktiveras varje gång ett anpassat formulär skickas.

Regeln för att skicka formulär har konfigurerats med händelsen _**Adobe Experience Manager Forms - Submit**_

![form-submit-rule](assets/form-submit-rule.png)

I regeln Skicka formulär mappas värdet för dataelementet _**ApplicantsStateOfResidence**_ till prop5 och värdet för dataelementet FormTitle mappas till prop8.

Adobe Analytics - Ange variabler konfigureras enligt följande.
![form-submit-rule-set-variables](assets/form-submit-set-variable.png)

När du är redo att testa din taggkod [publicerar du dina ändringar av taggarna](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/publishing-flow.html) med hjälp av publiceringsflödet.

## Nästa steg

[Testa lösningen](./test.md)