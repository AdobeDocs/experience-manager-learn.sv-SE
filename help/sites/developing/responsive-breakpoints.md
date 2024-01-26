---
title: Responsiva brytpunkter
description: Lär dig hur du konfigurerar nya responsiva brytpunkter för AEM responsiv sidredigerare.
version: Cloud Service
feature: Page Editor
topic: Mobile, Development
role: Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-01-05T00:00:00Z
jira: KT-11664
thumbnail: kt-11664.jpeg
exl-id: 8b48c28f-ba7f-4255-be96-a7ce18ca208b
duration: 70
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 0%

---

# Responsiva brytpunkter

Lär dig hur du konfigurerar nya responsiva brytpunkter för AEM responsiv sidredigerare.

## Skapa CSS-brytpunkter

Skapa först brytpunkter för media i CSS för AEM responsiva stödraster som den responsiva AEM följer.

I `/ui.apps/src/main/content/jcr_root/apps/[app name]/clientlibs/clientlib-grid/less/grid.less` skapar du brytpunkter som ska användas tillsammans med emulatorn för mobila enheter. Anteckna `max-width` för varje brytpunkt, när detta kopplar CSS-brytpunkterna till AEM responsiva sidredigerarens brytpunkter.

![Skapa nya responsiva brytpunkter](./assets/responsive-breakpoints/create-new-breakpoints.jpg)

## Anpassa mallens brytpunkter

Öppna `ui.content/src/main/content/jcr_root/conf/<app name>/settings/wcm/templates/page-content/structure/.content.xml` fil och uppdatera `cq:responsive/breakpoints` med nya brytpunktsnoddefinitioner. Varje [CSS-brytpunkt](#create-new-css-breakpoints) ska ha en motsvarande nod under `breakpoints` med `width` egenskap inställd på CSS-brytpunktens `max-width`.

![Anpassa mallens responsiva brytpunkter](./assets/responsive-breakpoints/customize-template-breakpoints.jpg)

## Skapa emulatorer

AEM måste definieras så att författare kan välja den responsiva vyn som ska redigeras i sidredigeraren.

Skapa emulatornoder under `/ui.apps/src/main/content/jcr_root/apps/<app name>/emulators`

Till exempel: `/ui.apps/src/main/content/jcr_root/apps/wknd-examples/emulators/phone-landscape`. Kopiera en referensemulatornod från `/libs/wcm/mobile/components/emulators` i CRXDE Lite till och uppdatera kopian för att underlätta noddefinitionen.

![Skapa nya emulatorer](./assets/responsive-breakpoints/create-new-emulators.jpg)

## Skapa enhetsgrupp

Gruppera emulatorerna till [göra dem tillgängliga AEM sidredigeraren](#update-the-templates-device-group).

Skapa `/apps/settings/mobile/groups/<name of device group>` nodstruktur under `/ui.apps/src/main/content/jcr_root`.

![Skapa ny enhetsgrupp](./assets/responsive-breakpoints/create-new-device-group.jpg)

Skapa en `.content.xml` fil i `/apps/settings/mobile/groups/<device group name>` och definiera de nya emulatorerna med kod som liknar den nedan:

![Skapa ny enhet](./assets/responsive-breakpoints/create-new-device.jpg)

## Uppdatera mallens enhetsgrupp

Koppla slutligen enhetsgruppen tillbaka till sidmallen så att emulatorerna är tillgängliga i sidredigeraren för sidor som skapas från den här mallen.

Öppna `ui.content/src/main/content/jcr_root/conf/[app name]/settings/wcm/templates/page-content/structure/.content.xml` och uppdatera `cq:deviceGroups` egenskap som refererar till den nya mobilgruppen (till exempel `cq:deviceGroups="[mobile/groups/customdevices]"`)
