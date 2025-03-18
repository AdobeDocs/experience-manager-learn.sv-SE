---
title: Skapa ett block
description: Skapa ett Edge Delivery Services-block med Universal Editor.
version: Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 500
exl-id: ca356d38-262d-4c30-83a0-01c8a1381ee6
source-git-commit: 77beb9f543bc6dc8c1ab4993c969375ce3e238e8
workflow-type: tm+mt
source-wordcount: '376'
ht-degree: 0%

---

# Skapa ett block

När JSON ](./5-new-block.md) för [teaser-blocket har placerats i `teaser`-grenen kan blocket redigeras i AEM Universal Editor.

Det finns flera skäl till att det är viktigt att skapa ett block under utveckling:

1. Den verifierar att blockets definition och modell är korrekta.
1. Det gör att utvecklare kan granska blockets semantiska HTML, som fungerar som grund för utvecklingen.
1. Det gör det möjligt att använda både innehåll och semantiska HTML i förhandsvisningsmiljön, vilket ger snabbare blockutveckling.

## Öppna Universal Editor med kod från grenen `teaser`

1. Logga in på AEM Author.
2. Navigera till **Webbplatser** och markera webbplatsen (WKND (Universal Editor)) som skapades i det [föregående kapitlet](./2-new-aem-site.md).

   ![AEM Sites](./assets/6-author-block/open-new-site.png)

3. Skapa eller redigera en sida för att lägga till det nya blocket och se till att kontexten är tillgänglig för lokal utveckling. Sidor kan skapas var som helst på webbplatsen, men det är oftast bäst att skapa separata sidor för varje ny arbetsbrödtext. Skapa en ny mappsida med namnet **grenar**. Varje undersida används som stöd för utveckling av Git-grenen med samma namn.

   ![AEM Sites - sidan Skapa grenar](./assets/6-author-block/branches-page-3.png)

4. Under sidan **Förgreningar** skapar du en ny sida med namnet **Teaser** som matchar namnet på utvecklingsgrenen och redigerar sidan genom att klicka på **Öppna** .

   ![AEM Sites - Skapa Teaser-sida](./assets/6-author-block/teaser-page-3.png)

5. Uppdatera den universella redigeraren för att läsa in koden från grenen `teaser` genom att lägga till `?ref=teaser` i URL:en. Lägg till frågeparametern **BEFORE** i `#`-symbolen.

   ![Universell redigerare - Välj teasergren](./assets/6-author-block/select-branch.png)

6. Markera det första avsnittet under **Huvudsida**, klicka på knappen **Lägg till** och välj **Teaser** -blocket.

   ![Universell redigerare - Lägg till block](./assets/6-author-block/add-teaser-2.png)

7. Markera det nya lagret på arbetsytan och författare fälten till höger eller via funktionen för redigering direkt.

   ![Universell redigerare - Författarblock](./assets/6-author-block/author-block.png)

8. När du är klar med redigeringen väljer du knappen **Publicera** längst upp till höger i Universal Editor, väljer Publicera till **Förhandsgranska** och publicerar ändringarna i förhandsvisningsmiljön. Ändringarna publiceras sedan till domänen `aem.page` för webbplatsen.
   ![AEM Sites - Publicera eller Förhandsgranska](./assets/6-author-block/publish-to-preview.png)

9. Vänta tills ändringarna har publicerats för förhandsgranskning och öppna sedan webbsidan via [AEM CLI](./3-local-development-environment.md#install-the-aem-cli) på [http://localhost:3000/branches/teaser](http://localhost:3000/branches/teaser).

   ![Lokal plats - uppdatera](./assets/6-author-block/preview.png)

Nu finns det material och semantiska HTML som skapats av teaser-blocket på förhandsgranskningswebbplatsen, som är klart för utveckling med AEM CLI i den lokala utvecklingsmiljön.
