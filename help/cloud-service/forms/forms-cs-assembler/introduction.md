---
title: manipulering av PDF i Forms CS med hjälp av DX-åtgärden invoke
description: Samla ihop PDF-filer med DX.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Output Service
topic: Development
jira: KT-9980
exl-id: 713c4e9e-95ac-48e1-a7fc-2b3ec0b145e5
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
duration: 18
source-git-commit: b4df652fcda0af5d01077b97aa7fa17cfe2abf4b
workflow-type: tm+mt
source-wordcount: '102'
ht-degree: 0%

---

# Introduktion

I den här kursen använder vi manipulering och arkivering av PDF-dokument i PDF med Forms CS. Så här använder du mikrotjänsterna från ett externt program:

1. Generera tjänstreferenser för ett AEM tekniskt konto
1. Skapa en JSON Web Token (JWT) från inloggningsuppgifterna och byt ut samma mot en åtkomsttoken
1. Konfigurera åtkomst för det tekniska kontot i AEM
1. Göra HTTP-anrop med åtkomsttoken för att hantera PDF-filer/generera och validera PDF/A-filer
