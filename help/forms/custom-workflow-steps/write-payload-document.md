---
title: Skriv nyttolastdokumentet till filsystemet
description: Anpassat processsteg för att lägga till skrivdokument som finns under nyttolastmappen i filsystemet
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-9859
source-git-commit: 160471fdc34439da6c312d65b252eaa941b7c7a2
workflow-type: tm+mt
source-wordcount: '144'
ht-degree: 0%

---

# Skriv dokumentet till filsystemet

Ett vanligt användningsexempel är att skriva de genererade dokumenten i arbetsflödet till filsystemet.
Det här anpassade arbetsflödessteget gör det enkelt att skriva arbetsflödesdokument till filsystemet.
Den anpassade processen tar följande kommaseparerade argument

```java
ChangeBeneficiary.pdf,c:\confirmation
```

Det första argumentet är namnet på dokumentet som du vill spara i filsystemet. Det andra argumentet är den mapp där du vill spara dokumentet. I ovanstående exempel skrivs dokumentet till c:\confirmation\ChangeBeneficiary.pdf

I följande skärmbild visas de argument som du behöver skicka till det anpassade steget
![write-payload-file-system](assets/write-payload-file-system.png)

[Det anpassade paketet kan laddas ned härifrån](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)