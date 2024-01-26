---
title: Konfigurera en lokal utvecklingsmiljö för Edge Delivery Services
description: Konfigurera en lokal utvecklingsmiljö för Edge Delivery Services.
version: 6.5, Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Technical Video
last-substantial-update: 2023-11-15T00:00:00Z
jira: KT-14483
thumbnail: 3425717.jpeg
duration: 169
exl-id: 0f3e50f0-88d8-46be-be8b-0f547c3633a6
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '87'
ht-degree: 0%

---

# Konfigurera en lokal utvecklingsmiljö

Konfigurera en lokal utvecklingsmiljö för utveckling av Edge Delivery Services.

>[!VIDEO](https://video.tv.adobe.com/v/3425717/?learn=on)


## Steg som beskrivs i videon

1. Installera AEM CLI

   ```
   $ sudo npm install -g @adobe/aem-cli
   ```

1. Ändra katalog till din projektkatalog som är en Git-databas som skapats från [AEM](https://github.com/adobe/aem-boilerplate) mall.

   ```
   $ git clone git@github.com:my-org/my-project.git
   $ cd my-project
   ```

1. Kör AEM CLI för att starta den lokala AEM.

   ```
   $ pwd
     /Users/my-user/my-project
   
   $ aem up
       ___    ________  ___                          __      __ 
      /   |  / ____/  |/  /  _____(_)___ ___  __  __/ /___ _/ /_____  _____
     / /| | / __/ / /|_/ /  / ___/ / __ `__ \/ / / / / __ `/ __/ __ \/ ___/
    / ___ |/ /___/ /  / /  (__  ) / / / / / / /_/ / / /_/ / /_/ /_/ / /
   /_/  |_/_____/_/  /_/  /____/_/_/ /_/ /_/\__,_/_/\__,_/\__/\____/_/
   
   info: Starting AEM dev server vx.x.x
   info: Local AEM dev server up and running: http://localhost:3000/
   info: Enabled reverse proxy to https://main--my-project--my-org.hlx.page
   opening default browser: http://localhost:3000/
   ```

1. Öppna http://localhost:3000/ webbläsaren för att visa AEM webbplats.
