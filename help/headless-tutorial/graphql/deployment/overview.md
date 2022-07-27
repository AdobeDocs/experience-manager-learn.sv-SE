---
source-git-commit: 10032375a23ba99f674fb59a6f6e48bf93908421
workflow-type: tm+mt
source-wordcount: '174'
ht-degree: 0%

---



# AEM driftsättningar utan headless

AEM Headless-installationer tar många former; AEM SPA, externa SPA eller webbplatser, mobilappar eller till och med server-till-server-processer.

Beroende på klienten och hur den distribueras har AEM Headless-distributioner olika överväganden.

## AEM

Innan du utforskar implementeringsfrågor är det viktigt att förstå AEM logiska arkitektur och hur separerade och roller AEM as a Cloud Service tjänstenivåer är. AEM as a Cloud Service består av två logiska tjänster:

+ __AEM Author__ är den tjänst där team skapar, samarbetar och publicerar innehållsfragment (och andra resurser).
+ __AEM Publish__ är den tjänst där publicerade innehållsfragment (och andra resurser) replikeras för allmän användning

AEM Huvudlösa kunder som arbetar i produktionskapacitet interagerar vanligtvis med AEM Publish, som innehåller det godkända, publicerade innehållet. Klienten som interagerar med AEM Author måste ta särskild hänsyn eftersom AEM Author är säker som standard, vilket kräver godkännande för alla förfrågningar, samt kan innehålla ofullständigt eller ej godkänt innehåll.

## Huvudlösa klientdistributioner

+ [Single-page app](./spa.md)
+ [Webbkomponent/JS](./web-component.md)
+ [Mobilapp](./mobile.md)
+ [Server till server](./server-to-server.md)

