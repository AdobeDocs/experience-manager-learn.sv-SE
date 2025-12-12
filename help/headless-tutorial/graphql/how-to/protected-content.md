---
title: Skyddat innehåll i AEM Headless
description: Lär dig skydda innehåll i AEM Headless.
version: Experience Manager as a Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
jira: KT-15233
last-substantial-update: 2024-05-01T00:00:00Z
exl-id: c4b093d4-39b8-4f0b-b759-ecfbb6e9e54f
duration: 254
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1151'
ht-degree: 0%

---

# Skydda innehåll i AEM Headless

Att säkerställa dataintegriteten och datasäkerheten när du levererar AEM Headless-innehåll från AEM Publish är avgörande när du levererar känsligt innehåll. Så här går du igenom hur du skyddar innehåll som hanteras av AEM Headless API-slutpunkter för GraphQL.

Vägledningen i den här självstudiekursen där det finns strikta krav på att innehåll endast ska vara tillgängligt för specifika användare eller användargrupper. Det är av största vikt att skilja mellan personaliserat marknadsföringsinnehåll och privat innehåll, som PII-innehåll eller personuppgifter, för att undvika förvirring och oavsiktliga resultat. Den här självstudiekursen handlar om att skydda privat innehåll.

När vi diskuterar marknadsföringsinnehåll syftar vi på innehåll som är skräddarsytt för enskilda användare eller grupper och som inte är avsett för allmän konsumtion. Men det är viktigt att förstå att även om innehållet kan vara riktat till vissa användare så innebär dess exponering utanför det avsedda sammanhanget (t.ex. genom hantering av HTTP-begäranden) inte någon säkerhetsrisk, juridisk risk eller anseenderisk.

Det betonas att allt innehåll som behandlas i den här artikeln antas vara privat och endast kan ses av utsedda användare eller grupper. Marknadsföringsmaterial kräver ofta inget skydd, utan levereras till specifika användare och kan hanteras av programmet och cachas för att ge resultat.

Detta handledningar täcker inte:

- Skydda slutpunkterna direkt, men i stället fokusera på att skydda innehållet de levererar.
- Autentisering för AEM Publish eller hämtning av inloggningstoken. Autentiseringsmetoder och överföring av autentiseringsuppgifter beror på individuella användningsfall och implementeringar.

## Användargrupper

Först måste vi definiera en [användargrupp](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/accessing/aem-users-groups-and-permissions) som innehåller de användare som ska ha tillgång till det skyddade innehållet.

![AEM Headless-användargrupp för skyddat innehåll](./assets/protected-content/user-groups.png){align="center"}

Användargrupper tilldelar åtkomst till AEM Headless-innehåll, inklusive Content Fragments eller andra refererade resurser.

1. Logga in på AEM Author som **användaradministratör**.
1. Navigera till **Verktyg** > **Dokumentskydd** > **Grupper**.
1. Välj **Skapa** i det övre högra hörnet.
1. På fliken **Detaljer** anger du **Grupp-ID** och **Gruppnamn**.
   - Grupp-ID och gruppnamn kan vara vad som helst, men i det här exemplet används namnet **AEM Headless API-användare**.
1. Välj **Spara och stäng**.
1. Markera den nyligen skapade gruppen och välj sedan **Aktivera** i åtgärdsfältet.

Om olika åtkomstnivåer krävs skapar du flera användargrupper som kan kopplas till olika innehåll.

### Lägga till användare i användargrupper

Om du vill ge AEM Headless GraphQL API-begäranden åtkomst till skyddat innehåll kan du koppla den headless-begäran till en användare som tillhör en viss användargrupp. Här är två vanliga metoder:

1. **AEM as a Cloud Service [tekniska konton](https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials):**
   - Skapa ett tekniskt konto i AEM as a Cloud Service Developer Console.
   - Logga in på AEM Author en gång med det tekniska kontot.
   - Lägg till det tekniska kontot i användargruppen via **Verktyg > Säkerhet > Grupper > AEM Headless API-användare > Medlemmar**.
   - **Aktivera** både den tekniska kontoanvändaren och användargruppen i AEM Publish.
   - Den här metoden kräver att den headless-klienten inte exponerar tjänstens autentiseringsuppgifter för användaren, eftersom de är autentiseringsuppgifter för en viss användare och inte ska delas.

   ![Grupphantering för AEM tekniska konto](./assets/protected-content/group-membership.png){align="center"}

2. **Namngivna användare:**
   - Autentisera namngivna användare och lägg direkt till dem i användargruppen i AEM Publish.
   - Den här metoden kräver att den headless-klienten autentiserar inloggningsuppgifter med AEM Publish, hämtar en inloggnings- eller åtkomsttoken från AEM och använder denna token för efterföljande förfrågningar till AEM. Detaljerna för hur detta ska uppnås beskrivs inte i det här handtaget och är beroende av implementeringen.

## Skydda innehållsfragment

Skydda innehållsfragment är nödvändigt för att skydda ditt AEM Headless-innehåll och uppnås genom att koppla innehållet till en Closed User Group (CUG). När en användare skickar en begäran till AEM Headless GraphQL API filtreras det returnerade innehållet baserat på användarens CUG.

![AEM Headless CUG](./assets/protected-content/cugs.png){align="center"}

Följ de här stegen för att uppnå detta genom [Stängda användargrupper (CUG)](https://experienceleague.adobe.com/en/docs/experience-manager-learn/assets/advanced/closed-user-groups).

1. Logga in på AEM Author som **DAM-användare**.
2. Navigera till **Assets > Filer** och markera den **mapp** som innehåller de innehållsfragment som ska skyddas. CUG-filer används hierarkiskt och påverkar undermappar om de inte åsidosätts av en annan CUG-fil.
   - Se till att användare som tillhör andra kanaler som använder innehållet i mapparna inkluderas i den här användargruppen. Du kan också inkludera användargrupperna som är associerade med dessa kanaler i listan över CUG-grupper. Annars kommer innehållet inte att vara tillgängligt för dessa kanaler.
3. Markera mappen och välj **Egenskaper** i verktygsfältet.
4. Välj fliken **Behörigheter**.
5. Skriv in **gruppnamnet** och välj knappen **Lägg till** för att lägga till den nya CUG-filen.
6. **Spara** om du vill använda CUG-filen.
7. **Markera** resursmappen och välj **Publicera** för att skicka mappen med de använda användargränssnitten till AEM Publish, där den utvärderas som en behörighet.

Utför samma steg för alla mappar som innehåller innehållsfragment som behöver skyddas och använd rätt CUG för varje mapp.

När en HTTP-begäran görs till AEM Headless GraphQL API-slutpunkten inkluderas nu endast de innehållsfragment som är tillgängliga för den begärande användarens angivna CUG. Om användaren saknar åtkomst till något innehållsfragment kommer resultatet att vara tomt, men ändå returnera en 200 HTTP-statuskod.

### Skydda refererat innehåll

Innehållsfragment refererar ofta till annat AEM-innehåll, t.ex. bilder. Om du vill skydda det refererade innehållet använder du CUG:er på resursmapparna där de refererade resurserna lagras. Observera att refererade resurser vanligtvis efterfrågas med andra metoder än de i AEM Headless GraphQL API:er. Följaktligen kan sättet som åtkomsttoken skickas på på för begäranden till dessa refererade resurser variera.

Beroende på innehållsarkitekturen kan det vara nödvändigt att använda användargränssnitten på flera mappar för att säkerställa att allt innehåll som refereras är skyddat.

## Förhindra cachelagring av skyddat innehåll

AEM as a Cloud Service [cachelagrar HTTP-svar som standard](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/caching/publish) för prestandaförbättringar. Detta kan dock orsaka problem med att skicka skyddat innehåll. Om du vill förhindra cachelagring av sådant innehåll [tar du bort cacherubriker för specifika slutpunkter](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/caching/publish#how-to-customize-cache-rules-1) i Apache-konfigurationen för AEM Publish-instansen.

Lägg till följande regel i ditt Dispatcher-projekts Apache-konfigurationsfil för att ta bort cacherubriker för specifika slutpunkter:

```xml
# dispatcher/src/conf.d/available_vhosts/example.vhost

<VirtualHost *:80>
    ...
    # Replace `example` with the name of your GraphQL endpoint's configuration name.
    <LocationMatch "^/graphql/execute.json/example/.*$">
        # Remove cache headers for protected endpoints so they are not cached
        Header unset Cache-Control
        Header unset Surrogate-Control
        Header set Age 0
    </LocationMatch>
    ...
</VirtualHost>
```

Observera att detta medför en prestandaförsämring eftersom innehållet inte cachas av avsändaren eller CDN. Detta är en kompromiss mellan prestanda och säkerhet.

## Skydda AEM Headless GraphQL API-slutpunkter

Den här guiden skyddar inte själva [AEM Headless GraphQL API-slutpunkterna](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/headless/graphql-api/graphql-endpoint), utan fokuserar på att skydda det innehåll som hanteras av dem. Alla användare, även anonyma användare, har åtkomst till slutpunkterna som innehåller skyddat innehåll. Endast det innehåll som är tillgängligt för användarens stängda användargrupper returneras. Om inget innehåll är tillgängligt kommer AEM Headless API-svaret fortfarande att ha en 200 HTTP-svarskod, men resultatet kommer att vara tomt. Normalt räcker det att skydda innehållet eftersom själva slutpunkterna inte exponerar känsliga data. Om du behöver skydda slutpunkterna lägger du till åtkomstkontrollistor i dem i AEM Publish via [Repoinit-skript (Sling Repository Initialization)](https://sling.apache.org/documentation/bundles/repository-initialization.html#repoinit-parser-test-scenarios).
