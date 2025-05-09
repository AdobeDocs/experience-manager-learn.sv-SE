---
title: Installera nödvändiga adaptiva formulärreaktionsbibliotek
description: Lägg till de beroenden som krävs i ditt reaktionsprojekt
feature: Adaptive Forms
version: Experience Manager 6.5
jira: KT-13285
topic: Development
role: User
level: Intermediate
exl-id: 0ed44016-d52a-4980-a0b1-06da149c3cb1
duration: 48
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '210'
ht-degree: 0%

---

# Installerar nödvändiga beroenden

Om du vill börja använda headless adaptive-formulär i ditt svarsprojekt måste du installera följande beroenden i ditt svarsprojekt

* @aemforms/af-response-components
* @aemforms/af-response-renderer

Uppdatera package.json så att den innehåller följande beroenden. När 0.22.41 skrevs var den nuvarande versionen

```json
"@aemforms/af-react-components": "^0.22.41",
"@aemforms/af-react-renderer": "^0.22.41",
```

>[!NOTE]
>
>Listrutan och kortlayouten i den här självstudiekursen skapades med [materialgränssnittsbiblioteket](https://mui.com/). Du måste hämta lämpliga materialgränssnittspaket för att koden ska fungera i ditt system.

## Konfigurera proxy

Cross-Origin Resource Sharing (CORS) är en säkerhetsmekanism som förhindrar webbläsare från att göra förfrågningar till en annan domän än den som appen finns på. CORS-fel kan uppstå när du försöker hämta data från ett API på en annan domän. Genom att konfigurera en proxy kan du kringgå CORS-begränsningar och göra förfrågningar till API:t från din React-app. Jag har använt följande kod i filen setUpProxy.js i mappen src. **Kontrollera att du ändrar målet så att det pekar på din publiceringsinstans.**

```
const { createProxyMiddleware } = require('http-proxy-middleware');
const proxy = {
    target: 'https://mypublishinstance:4503/',
    changeOrigin: true
}
module.exports = function(app) {
  app.use(
    '/adobe',
    createProxyMiddleware(proxy)
  ),
  app.use(
    '/content',
    createProxyMiddleware(proxy)
  );
};
```

Du måste också installera och lägga till modulen **http-proxy-middleware** i ditt projekt.

## Nästa steg

[Hämta formuläret som ska bäddas in](./fetch-the-form.md)
