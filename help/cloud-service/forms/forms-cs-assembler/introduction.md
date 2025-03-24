---
title: PDF-manipulering i Forms CS med hjälp av DX-åtgärden invoke
description: Sammanställ PDF-filer med hjälp av DX.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Output Service
topic: Development
jira: KT-9980
exl-id: 713c4e9e-95ac-48e1-a7fc-2b3ec0b145e5
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
duration: 18
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '102'
ht-degree: 0%

---

# Introduktion

I den här kursen använder vi PDF för att hantera och arkivera PDF-dokument med Forms CS. Så här använder du mikrotjänsterna från ett externt program:

1. Generera autentiseringsuppgifter för ett AEM-konto
1. Skapa en JSON Web Token (JWT) från inloggningsuppgifterna och byt ut samma mot en åtkomsttoken
1. Konfigurera åtkomst för det tekniska kontot i AEM
1. Göra HTTP-anrop med åtkomsttoken för att hantera PDF-filer/generera och validera PDF/A-filer
