---
title: Stängda användargrupper i AEM Assets
description: Stängda användargrupper (CUG) är en funktion som används för att begränsa åtkomst till innehåll för en viss grupp användare på en publicerad webbplats. I den här videon visas hur stängda användargrupper kan användas med Adobe Experience Manager Assets för att begränsa åtkomst till en viss mapp med resurser.
version: 6.4, 6.5, Cloud Service
topic: Administration, Security
feature: User and Groups
role: Admin
level: Intermediate
jira: KT-649
thumbnail: 22155.jpg
last-substantial-update: 2022-06-06T00:00:00Z
doc-type: Feature Video
exl-id: a2bf8a82-15ee-478c-b7c3-de8a991dfeb8
duration: 340
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '357'
ht-degree: 0%

---

# Stängda användargrupper{#using-closed-user-groups-with-aem-assets}

Stängda användargrupper (CUG) är en funktion som används för att begränsa åtkomst till innehåll för en viss grupp användare på en publicerad webbplats. I den här videon visas hur stängda användargrupper kan användas med Adobe Experience Manager Assets för att begränsa åtkomst till en viss mapp med resurser. Stöd för slutna användargrupper med AEM Assets introducerades i AEM 6.4.

>[!VIDEO](https://video.tv.adobe.com/v/22155?quality=12&learn=on)

## CUG (Closed User Group) med AEM Assets

* Utformad för att begränsa åtkomst till resurser i en AEM Publish-instans.
* Ger läsåtkomst till en uppsättning användare/grupper.
* CUG kan bara konfigureras på mappnivå. CUG kan inte anges för enskilda resurser.
* CUG-profiler ärvs automatiskt av alla undermappar och tillämpade resurser.
* CUG-profiler kan åsidosättas av undermappar genom att ange en ny CUG-princip. Detta bör användas sparsamt och anses inte vara en god praxis.

## Stängda användargrupper jämfört med åtkomstkontrollistor {#closed-user-groups-vs-access-control-lists}

Både stängda användargrupper (CUG) och åtkomstkontrollistor (ACL) används för att styra åtkomst till innehåll i AEM och baserat på AEM och grupper. Tillämpningen och implementeringen av dessa funktioner är dock mycket annorlunda. I följande tabell sammanfattas skillnaderna mellan de två funktionerna.

|                   | ACL | CUG |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Avsedd användning | Konfigurera och tillämpa behörigheter för innehåll på **aktuell** AEM. | Konfigurera CUG-principer för innehåll på AEM **författare** -instans. Använd CUG-profiler för innehåll på AEM **publicera** instans(er). |
| Behörighetsnivåer | Definierar beviljade/nekade behörigheter för användare/grupper på alla nivåer: Läs, Ändra, Skapa, Ta bort, Läs ACL, Redigera ACL, Replikera. | Ger läsåtkomst till en uppsättning användare/grupper. Nekar läsåtkomst till *alla andra* användare/grupper. |
| Publicering | ACL:er är *not* publicerat med innehåll. | CUG-principer *är* publicerat med innehåll. |

## Stödlänkar {#supporting-links}

* [Hantera resurser och stängda användargrupper](https://experienceleague.adobe.com/docs/experience-manager-65/assets/managing/manage-assets.html?lang=en#closed-user-group)
* [Skapa en stängd användargrupp](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/cug.html)
* [Dokumentation för stängd användargrupp](https://jackrabbit.apache.org/oak/docs/security/authorization/cug.html)
