---
title: manipulering av PDF i Forms CS med hjälp av DX-åtgärden invoke
description: Samla ihop PDF-filer med DX.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Output Service
topic: Development
kt: 9980
source-git-commit: b7ff98dccc1381abe057a80b96268742d0a0629b
workflow-type: tm+mt
source-wordcount: '96'
ht-degree: 1%

---

# Introduktion

I den här kursen använder vi manipulering och arkivering av PDF-dokument i PDF med Forms CS. Så här använder du mikrotjänsterna från ett externt program:

1. Generera autentiseringsuppgifter för tjänsten för ett AEM tekniskt konto
1. Skapa en JSON Web Token (JWT) från inloggningsuppgifterna och byt ut samma mot en åtkomsttoken
1. Konfigurera åtkomst för det tekniska kontot i AEM
1. Göra HTTP-anrop med åtkomsttoken för att hantera PDF-filer/generera och validera PDF/A-filer
