---
title: Reagera app med AEM Forms och Acrobat Sign
description: Med Acrobat Sign och AEM Forms kan man automatisera komplexa transaktioner och inkludera juridiskt bindande e-signaturer som en del av en smidig digital upplevelse.
feature: Adaptive Forms,Acrobat Sign
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
jira: KT-13099
last-substantial-update: 2023-04-13T00:00:00Z
exl-id: 64172af3-2905-4bc8-8311-68c2a70fb39e
duration: 34
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 0%

---

# AEM Forms med Acrobat Sign webbformulär


I den här självstudiekursen får du hjälp med att generera ett interaktivt kommunikationsdokument med data som skickas från [Reagera](https://react.dev/) app och presentera det genererade dokumentet för signering med Acrobat Sign webbformulär.

Här följer ett flöde för användningsfallet

* Användaren fyller i ett formulär i React-appen.
* Formulärdatat skickas till en AEM Forms-slutpunkt för att generera interaktivt kommunikationsdokument.
* Skapa Acrobat Sign widget-URL med det genererade dokumentet.
* Visa widgetens URL till det anropande programmet så att användaren kan signera dokumentet.

## Förutsättningar

Du måste ha följande för att användningsexemplet ska fungera:

* En AEM server med Forms-tillägg i paket
* An [integreringsnyckel för ett Acrobat Sign-program](https://helpx.adobe.com/sign/kb/how-to-create-an-integration-key.html)

## Nästa steg

Skriv en [anpassad OSGi-tjänst för att generera interaktivt kommunikationsdokument](./create-ic-document.md) med dokumenterad API
