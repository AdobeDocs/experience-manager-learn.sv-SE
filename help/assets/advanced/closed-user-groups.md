---
title: Stängda användargrupper i AEM Assets
description: 'Stängda användargrupper (CUG) är en funktion som används för att begränsa åtkomst till innehåll för en viss grupp användare på en publicerad webbplats. I den här videon visas hur stängda användargrupper kan användas med Adobe Experience Manager Assets för att begränsa åtkomsten till en viss mapp med resurser. Stöd för slutna användargrupper med AEM Assets introducerades i AEM 6.4. '
feature: asset-share
topics: authoring, collaboration, operations, sharing
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 10784dce34443adfa1fc6dc324242b1c021d2a17
workflow-type: tm+mt
source-wordcount: '486'
ht-degree: 0%

---


# Stängda användargrupper{#using-closed-user-groups-with-aem-assets}

Stängda användargrupper (CUG) är en funktion som används för att begränsa åtkomst till innehåll för en viss grupp användare på en publicerad webbplats. I den här videon visas hur stängda användargrupper kan användas med Adobe Experience Manager Assets för att begränsa åtkomsten till en viss mapp med resurser. Stöd för slutna användargrupper med AEM Assets introducerades i AEM 6.4.

>[!VIDEO](https://video.tv.adobe.com/v/22155?quality=9&learn=on)

## CUG (Closed User Group) med AEM Assets

* Utformad för att begränsa åtkomst till resurser i en AEM Publish-instans.
* Ger läsåtkomst till en uppsättning användare/grupper.
* CUG kan bara konfigureras på mappnivå. CUG kan inte anges för enskilda resurser.
* CUG-profiler ärvs automatiskt av alla undermappar och använda resurser.
* CUG-profiler kan åsidosättas av undermappar genom att ange en ny CUG-princip. Detta bör användas sparsamt och anses inte vara en god praxis.

## CUG-representation i JCR {#cug-representation-in-the-jcr}

![CUG-representation i JCR](assets/closed-user-groups/folder-properties-closed-user-groups.png)

Gruppen för butiksmedlemmar har lagts till som en stängd användargrupp i mappen: /content/dam/we-retail/en/beta-products

En blandning av **rep:CugMixin** används för mappen **/content/dam/we-retail/en/beta-products** . En nod för **rep:cugPolicy** läggs till under mappen och vi-retail-members anges som huvudobjekt. En annan blandning av **granite:AuthenticationRequired** används i mappen för betaprodukter och egenskapen** granite:loginPath** anger vilken inloggningssida som ska användas om en användare inte är autentiserad och försöker begära en resurs under mappen för **betaprodukter** .

JCR-beskrivning nedan:

```xml
/beta-products
    - jcr:primaryType = sling:Folder
    - jcr:mixinTypes = rep:CugMixin, granite:AuthenticationRequired
    - granite:loginPath = /content/we-retail/us/en/community/signin
    + rep:cugPolicy
         - jcr:primaryType = rep:CugPolicy
         - rep:principalNames = we-retail-members
```

## Stängda användargrupper jämfört med åtkomstkontrollistor {#closed-user-groups-vs-access-control-lists}

Både stängda användargrupper (CUG) och åtkomstkontrollistor (ACL) används för att styra åtkomst till innehåll i AEM och baserat på AEM och grupper. Tillämpningen och implementeringen av dessa funktioner är dock mycket annorlunda. I följande tabell sammanfattas skillnaderna mellan de två funktionerna.

|  | ACL | CUG |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Avsedd användning | Konfigurera och tillämpa behörigheter för innehåll på den **aktuella** AEM. | Konfigurera CUG-principer för innehåll på AEM **författarinstans** . Använd CUG-profiler för innehåll AEM **publiceringsinstanser** . |
| Behörighetsnivåer | Definierar beviljade/nekade behörigheter för användare/grupper på alla nivåer: Läs, Ändra, Skapa, Ta bort, Läs ACL, Redigera ACL, Replikera. | Ger läsåtkomst till en uppsättning användare/grupper. Nekar läsåtkomst för alla andra användare/grupper. |
| Replikering | ACL:er replikeras inte med innehåll. | CUG-principer replikeras med innehåll. |

## Stödlänkar {#supporting-links}

* [Hantera resurser och stängda användargrupper](https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets-touch-ui.html#ClosedUserGroup)
* [Skapa en stängd användargrupp](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/cug.html)
* [Dokumentation för stängd användargrupp](https://jackrabbit.apache.org/oak/docs/security/authorization/cug.html)
