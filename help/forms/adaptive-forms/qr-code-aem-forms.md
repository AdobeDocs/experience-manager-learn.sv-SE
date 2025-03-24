---
title: Visa QR-kod i adaptiv form
description: Visa QR-kod i ett adaptivt formulär
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-15603
last-substantial-update: 2024-05-28T00:00:00Z
exl-id: 0c6079f4-601e-4a82-976c-71dbb2faa671
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '203'
ht-degree: 0%

---

# Exempel på QR-kodkomponent

Att bädda in en QR-kod i ett adaptivt formulär kan göra det enklare och effektivare för användarna att få tillgång till ytterligare information om formuläret.

Exempelkomponenten använder [QRCode.js](https://davidshimjs.github.io/qrcodejs/).

QRCode.js är ett javascript-bibliotek som gör QRCode. Det har stöd för webbläsarövergripande taggar med HTML5 Canvas och tabelltaggar i DOM.

Komponenten genererar QR-koden baserat på värdet som anges i komponentens konfigurationsegenskap.
![bild](assets/qr-code-url.png)

Följande kod användes i body.jsp för QR-code-generator-komponenten.

&quot;url&quot; är den URL som måste bäddas in i qr-koden. Den här URL:en anges i konfigurationsegenskaperna för QR-kodkomponenten.

```java
<%@include file="/libs/foundation/global.jsp"%>
<body>
    <h2>Scan the QR Code for more information related to this form</h2>
    <div data-url="<%=properties.get("url")%>">
    </div>
    <div id="qrcode">
    </div>
</body>
```



Följande kod använder makeCode-metoden för QRCode.js-biblioteket i klientbiblioteket för QR-code-generator-komponenten. Den genererade QR-koden läggs till i div-koden som identifieras av id **&quot;qrcode&quot;**.

```javascript
$(document).ready(function()
  {
      var qrcode = new QRCode("qrcode");
      qrcode.makeCode(document.querySelector("[data-url]").getAttribute("data-url"));
      
 });
```

## Distribuera resurserna på den lokala servern

* [Hämta och installera QR-kodkomponenten med Package Manager.](assets/qrcode.zip)
* [Hämta och installera det adaptiva exempelformuläret med Package Manager.](assets/form-with-qr-code.zip)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/qrcode/w9form/jcr:content?wcmmode=disabled). Formulärets hjälpavsnitt innehåller QR-koden.
