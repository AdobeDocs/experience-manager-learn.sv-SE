---
title: CSRF-skydd
description: Lär dig hur du skapar och lägger till AEM CSRF-token för tillåtna POST-, PUT och Delete-begäranden till AEM för autentiserade användare.
version: Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
doc-type: Code Sample
last-substantial-update: 2023-07-14T00:00:00Z
jira: KT-13651
thumbnail: KT-13651.jpeg
exl-id: 747322ed-f01a-48ba-a4a0-483b81f1e904
duration: 135
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '439'
ht-degree: 0%

---

# CSRF-skydd

Lär dig hur du skapar och lägger till AEM CSRF-token för tillåtna POST-, PUT och Delete-begäranden till AEM för autentiserade användare.

AEM kräver att en giltig CSRF-token skickas för __autentiserad__ __POST__, __PUT, eller __DELETE__ HTTP-begäranden till både AEM Author och Publish.

CSRF-token krävs inte för __GET__ förfrågningar, eller __anonym__ förfrågningar.

Om ingen CSRF-token skickas med en POST-, PUT eller DELETE-begäran returnerar AEM ett 403-förbjudet svar och AEM loggar följande fel:

```log
[INFO][POST /path/to/aem/endpoint HTTP/1.1][com.adobe.granite.csrf.impl.CSRFFilter] isValidRequest: empty CSRF token - rejecting
[INFO][POST /path/to/aem/endpoint HTTP/1.1][com.adobe.granite.csrf.impl.CSRFFilter] doFilter: the provided CSRF token is invalid
```

Se [mer information om AEM CSRF-skydd](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/csrf-protection.html).


## CSRF-klientbibliotek

AEM tillhandahåller ett klientbibliotek som kan användas för att generera och lägga till CSRF-tokens XHR och formulärförfrågningar via patchning av kärnprototypfunktioner. Funktionen finns i `granite.csrf.standalone` klientbibliotekskategori.

Lägg till `granite.csrf.standalone` som ett beroende till klientbiblioteket som läses in på sidan. Om du till exempel använder `wknd.site` klientbibliotekskategori, lägga till `granite.csrf.standalone` som ett beroende till klientbiblioteket som läses in på sidan.

## Skräddarsydd formulärinlämning med CSRF-skydd

Om användning av [`granite.csrf.standalone` klientbibliotek](#csrf-client-library) är inte aktiverat för ditt användningsfall, kan du lägga till en CSRF-token manuellt i ett formulär som skickas. I följande exempel visas hur du lägger till en CSRF-token i en formulärsändning.

Detta kodfragment visar hur CSRF-token kan hämtas från AEM när formulär skickas och läggas till i en formulärinmatning med namnet `:cq_csrf_token`. Eftersom CSRF-token har kort livslängd är det bäst att hämta och ställa in CSRF-token omedelbart innan formuläret skickas, vilket säkerställer dess giltighet.

```javascript
// Attach submit handler event to form onSubmit
document.querySelector('form').addEventListener('submit', async (event) => {
    event.preventDefault();

    const form = event.target;
    const response = await fetch('/libs/granite/csrf/token.json');
    const json = await response.json();
    
    // Create a form input named ``:cq_csrf_token`` with the CSRF token.
    let csrfTokenInput = form.querySelector('input[name=":cq_csrf_token"]');
    if (!csrfTokenInput?.value) {
        // If the form does not have a CSRF token input, add one.
        form.insertAdjacentHTML('beforeend', `<input type="hidden" name=":cq_csrf_token" value="${json.token}">`);
    } else {
        // If the form already has a CSRF token input, update the value.
        csrfTokenInput.value = json.token;
    }
    // Submit the form with the hidden input containing the CSRF token
    form.submit();
});
```

## Hämta med CSRF-skydd

Om användning av [`granite.csrf.standalone` klientbibliotek](#csrf-client-library) är inte aktiverat för ditt användningsfall, kan du lägga till en CSRF-token manuellt i en XHR-begäran eller hämta begäranden. I följande exempel visas hur du lägger till en CSRF-token i en XHR som skapats med fetch.

Detta kodfragment visar hur du hämtar en CSRF-token från AEM och lägger till den i en hämtningsbegäran `CSRF-Token` HTTP-begärandehuvud. Eftersom CSRF-token har kort livslängd är det bäst att hämta och ställa in CSRF-token omedelbart innan hämtningsbegäran görs, vilket säkerställer dess giltighet.

```javascript
/**
 * Get CSRF token from AEM.
 * CSRF token expire after a few minutes, so it is best to get the token before each request.
 * 
 * @returns {Promise<string>} that resolves to the CSRF token.
 */
async function getCsrfToken() {
    const response = await fetch('/libs/granite/csrf/token.json');
    const json = await response.json();
    return json.token;
}

// Fetch from AEM with CSRF token in a header named 'CSRF-Token'.
await fetch('/path/to/aem/endpoint', {
    method: 'POST',
    headers: {
        'CSRF-Token': await getCsrfToken()
    },
});
```

## Dispatcher-konfiguration

När du använder CSRF-token på AEM Publiceringstjänst måste Dispatcher-konfigurationen uppdateras för att tillåta GET-begäranden till CSRF-tokenslutpunkten. Följande konfiguration tillåter GET-begäranden till CSRF-tokenslutpunkten i AEM Publiceringstjänst. Om den här konfigurationen inte läggs till returnerar CSRF-tokenslutpunkten ett 404-svar som inte hittades.

* `dispatcher/src/conf.dispatcher.d/filters/filters.any`

```
...
/0120 { /type "allow" /method "GET" /url "/libs/granite/csrf/token.json" }
...
```
