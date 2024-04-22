---
title: Använda AEM Forms med Chatbot
description: Tolka chattBot-data
feature: Adaptive Forms
version: 6.5
jira: KT-15344
topic: Development
role: User
level: Intermediate
source-git-commit: eb4463ae0270725c5b0bd96e9799bada25b06303
workflow-type: tm+mt
source-wordcount: '97'
ht-degree: 0%

---

# Tolka chattBot-data

A [ChatBot-webkrok](https://www.chatbot.com/help/webhooks/what-are-webhooks/) användes för att skicka ChatBot-data till en AEM.
Data som hämtas i ChatBot är i JSON-format med användardata i attributobjektet enligt nedan
![chatbot-data](assets/chat-bot-data.png)

Om du vill sammanfoga data med XDP-mallen måste du skapa följande XML. Observera XML-mallens rotelement. Det måste matcha rotelementet i XDP-mallen för att data ska kunna sammanfogas.


```xml
<topmostSubForm>
    <f1_01>David Smith</f1_01>
    <signmethod>ESIGN</signmethod>
    <corporation>1</corporation>
    <f1_08>San Jose, CA, 95110</f1_08>
    <f1_07>345 Park Avenue</f1_07>
    <ssn>123-45-6789</ssn>
    <form_name>W-9</form_name>
</topmostSubForm>
```

![xdp-template](assets/xdp-template.png)

## Nästa steg

[Sammanfoga data med XDP-mall](./merge-data-with-template.md)



