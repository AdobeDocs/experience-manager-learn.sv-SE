---
title: Resursrapporter i AEM Assets
description: 'AEM Assets har ett ramverk för rapportering på företagsnivå som kan skalas för stora databaser via en intuitiv användarupplevelse. '
feature: reports
topics: authoring, operations, performance, metadata
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
kt: 648
translation-type: tm+mt
source-git-commit: 10784dce34443adfa1fc6dc324242b1c021d2a17
workflow-type: tm+mt
source-wordcount: '91'
ht-degree: 2%

---


# Resursrapporter{#using-reports-in-aem-assets}

AEM Assets har ett ramverk för rapportering på företagsnivå som kan skalas för stora databaser via en intuitiv användarupplevelse.

>[!VIDEO](https://video.tv.adobe.com/v/22140/?quality=12&learn=on)

## Microsoft Excel-formler {#excel-formulas}

Följande formler används i videon för att generera diagrammet Resurser efter storlek i Microsoft Excel.

### normalisering av resursstorlek till byte {#asset-size-normalization-to-bytes}

```
=IF(RIGHT(D2,2)="KB",
      LEFT(D2,(LEN(D2)-2))*1024,
  IF(RIGHT(D2,2)="MB",
      LEFT(D2,(LEN(D2)-2))*1024*1024,
  IF(RIGHT(D2,2)="GB",
      LEFT(D2,(LEN(D2)-2))*1024*1024*1024,
  IF(RIGHT(D2,2)="TB",
      LEFT(D2,(LEN(D2)-2))*1024*1024*1024*1024, 0))))
```

### Antal tillgångar efter storlek {#asset-count-by-size}

#### Mindre än 200 kB {#less-than-kb}

```
=COUNTIFS(E2:E1000,"< 200000")
```

#### 200 kB till 500 kB {#kb-to-kb}

```
=COUNTIFS(E2:E1000,">= 200000", E2:E1000,"<= 500000")
```

#### Mer än 500 kB {#greater-than-kb}

```
=COUNTIFS(E2:E1000,"> 500000")
```

## Ytterligare resurser{#additional-resources}

Hämta Excel-fil med [alla resurser med diagram](./assets/asset-reports/all-assets.xlsx)
