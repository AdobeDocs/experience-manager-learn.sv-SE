---
title: Använda formatsystem i AEM Forms
description: Definiera stilprincipen för knappkomponenten
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16276
exl-id: 52205a93-d03c-430c-a707-b351ab333939
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '139'
ht-degree: 0%

---

# Definiera formatet i profilen för komponenten

* Logga in på din lokala molnförberedda AEM-instans och gå till Verktyg | Allmänt | Mallar | projektnamnet.

* Markera och öppna mallen **Tom med kärnkomponenter** i redigeringsläge.
* Klicka på principikonen för knappkomponenten för att öppna principredigeraren.

* ![button-policy](assets/button-policy.png)

Definiera profilen enligt nedan

![button-policy-details](assets/styling-policy.png)

Vi har definierat 2 stilar/varianter som kallas Marketing och Corporate. Dessa variationer är kopplade till motsvarande CSS-klasser.**Kontrollera att det inte finns något blanksteg före och efter CSS-klassnamnen**.
Spara ändringarna.

| Stil | CSS-klass |
|-----------|------------------------------------|
| Marknadsföring | cmp-adaptiveform-button—marketing |
| Företag | cmp-adaptiveform-button - corporate |

Dessa CSS-klasser definieras i komponentens SCSS-fil(_button.scss).

## Nästa steg

[Definiera CSS-klasser](./create-variations.md)
