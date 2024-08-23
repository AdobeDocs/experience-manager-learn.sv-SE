---
title: Rensa CDN-cachen
description: Lär dig hur du rensar eller tar bort det cachelagrade HTTP-svaret från AEM as a Cloud Service CDN.
version: Cloud Service
feature: Operations, CDN Cache
topic: Administration, Performance
role: Admin, Architect, Developer
level: Intermediate
doc-type: Tutorial
duration: 0
last-substantial-update: 2024-08-13T00:00:00Z
jira: KT-15963
thumbnail: KT-15963.jpeg
source-git-commit: e03480e37463b7d35a49203e331ce661b6dc52f9
workflow-type: tm+mt
source-wordcount: '892'
ht-degree: 0%

---

# Rensa CDN-cachen

Lär dig hur du rensar eller tar bort det cachelagrade HTTP-svaret från AEM as a Cloud Service CDN. Med självbetjäningsfunktionen **Rensa API-token** kan du rensa cachen för en viss resurs, en grupp resurser och hela cachen.

I den här självstudien får du lära dig hur du konfigurerar och använder rensnings-API-token för att rensa CDN-cachen för exempelwebbplatsen [AEM WKND](https://github.com/adobe/aem-guides-wknd) med hjälp av självbetjäningsfunktionen.

>[!VIDEO](https://video.tv.adobe.com/v/3432948?quality=12&learn=on)

## Cacheogiltigförklaring kontra explicit tömning

Det finns två sätt att ta bort cachelagrade resurser från CDN:

1. **Cacheogiltigförklaring:** Det är processen att ta bort cachelagrade resurser från CDN baserat på cacherubriker som `Cache-Control`, `Surrogate-Control` eller `Expires`. Cacherubrikens `max-age`-attributvärde används för att fastställa resursernas cachelivstid, som också kallas TTL-cache (Time To Live). När cacheminnets livstid går ut tas de cachelagrade resurserna automatiskt bort från CDN-cachen.

1. **Explicit rensning:** Det är processen att manuellt ta bort cachelagrade resurser från CDN-cachen innan TTL-värdet upphör att gälla. Den explicita rensningen är användbar när du vill ta bort de cachelagrade resurserna omedelbart. Det ökar dock trafiken till den ursprungliga servern.

När cachelagrade resurser tas bort från CDN-cachen hämtar nästa begäran för samma resurs den senaste versionen från den ursprungliga servern.

## Konfigurera rensnings-API-token

Låt oss lära oss hur du ställer in rensnings-API-token för att rensa CDN-cachen.

### Konfigurera CDN-regeln

Token för rensnings-API skapas genom att CDN-regeln konfigureras i AEM projektkod.

1. Öppna filen `cdn.yaml` från huvudmappen `config` i AEM. Exempel: filen cdn.yaml](https://github.com/adobe/aem-guides-wknd/blob/main/config/cdn.yaml) för [WKND-projektet.

1. Lägg till följande CDN-regel i filen `cdn.yaml`:

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
data:  
  authentication: # The main authentication configuration
    authenticators: # The list of authenticators
       - name: purge-auth # The name of the authenticator
         type: purge  # The type of the authenticator, must be purge
         purgeKey1: ${{CDN_PURGEKEY_081324}} # The first purge key, must be referenced by the Cloud Manager secret-type environment variable name ${{CDN_EDGEKEY_073124}}
         purgeKey2: ${{CDN_PURGEKEY_111324}} # The second purge key, must be referenced by the Cloud Manager secret-type environment variable name ${{CDN_EDGEKEY_111324}}. It is used for the rotation of secrets without any interruptions.
    rules: # The list of authentication rules
       - name: purge-auth-rule # The name of the rule
         when: { reqProperty: tier, equals: "publish" } # The condition when the rule should be applied
         action: # The action to be taken when the rule is applied
           type: authenticate # The type of the action, must be authenticate
           authenticator: purge-auth # The name of the authenticator to be used, must match the name from the above authenticators list               
```

1. Spara, implementera och skicka ändringarna till databasen i det övre Adobe.

### Skapa Cloud Manager-miljövariabel

Skapa sedan Cloud Manager-miljövariablerna för att lagra Token-värdet för rensnings-API.

1. Logga in på Cloud Manager på [my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com/) och välj organisation och program.

1. Klicka på **ellipserna** (..) bredvid önskad miljö i avsnittet __Miljö__ och välj **Visa detaljer**.

   ![Visa detaljer](../assets/how-to/view-env-details.png)

1. Välj sedan fliken **Konfiguration** och klicka på knappen **Lägg till konfiguration** .

1. Ange följande information i dialogrutan **Miljökonfiguration**:
   - **Namn**: Ange namnet på miljövariabeln. Det måste matcha värdet `purgeKey1` eller `purgeKey2` från filen `cdn.yaml`.
   - **Värde**: Ange Token-värdet för rensnings-API.
   - **Tjänsten används**: Välj alternativet **Alla**.
   - **Typ**: Välj alternativet **Hemlighet**.
   - Klicka på knappen **Lägg till**.

   ![Lägg till variabel](../assets/how-to/add-cloud-manager-secrete-variable.png)

1. Upprepa stegen ovan för att skapa den andra systemvariabeln för värdet `purgeKey2`.

1. Klicka på **Spara** för att spara och tillämpa ändringarna.

### Distribuera CDN-regeln

Distribuera slutligen den konfigurerade CDN-regeln till AEM as a Cloud Service-miljön med Cloud Manager pipeline.

1. I Cloud Manager går du till avsnittet **Pipelines**.

1. Skapa en ny pipeline eller välj den befintliga pipeline som endast distribuerar **Config**-filerna. Detaljerade steg finns i [Skapa en konfigurationspipeline](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#deploy-rules-through-cloud-manager).

1. Klicka på knappen **Kör** för att distribuera CDN-regeln.

   ![Kör pipeline](../assets/how-to/run-config-pipeline.png)

## Använd rensnings-API-token

Om du vill rensa CDN-cachen anropar du den AEM tjänstspecifika domän-URL:en med rensnings-API-token. Syntaxen för att rensa cachen är följande:

```
PURGE <URL> HTTP/1.1
Host: <AEM_SERVICE_SPECIFIC_DOMAIN>
X-AEM-Purge-Key: <PURGE_API_TOKEN>
X-AEM-Purge: <PURGE_TYPE>
Surrogate-Key: <SURROGATE_KEY>
```

Var:

- **PURGE`<URL>`**: Metoden `PURGE` följs av URL-sökvägen för resursen som du vill rensa.
- **Värd:`<AEM_SERVICE_SPECIFIC_DOMAIN>`**: Den anger domänen för AEM.
- **X-AEM-Rensa-nyckel:`<PURGE_API_TOKEN>`**: En anpassad rubrik som innehåller Token-värdet för Rensa API.
- **X-AEM-Rensa:`<PURGE_TYPE>`**: En anpassad rubrik som anger typen av rensningsåtgärd. Värdet kan vara `hard`, `soft` eller `all`. I följande tabell beskrivs varje tömningstyp:

  | Töm typ | Beskrivning |
  |:------------:|:-------------:|
  | hård (standard) | Tar bort den cachelagrade resursen omedelbart. Undvik det eftersom det ökar trafiken till den ursprungliga servern. |
  | mjuk | Markerar den cachelagrade resursen som inaktuell och hämtar den senaste versionen från den ursprungliga servern. |
  | alla | Tar bort alla cachelagrade resurser från CDN-cachen. |

- **Surrogate-Key:`<SURROGATE_KEY>`**: (Valfritt) En anpassad rubrik som anger surrogatnycklarna (avgränsade med blanksteg) för resursgrupperna som ska rensas. surrogatnyckeln används för att gruppera resurserna och måste anges i resursens svarshuvud.

>[!TIP]
>
>I exemplen nedan används `X-AEM-Purge: hard` som exempel. Du kan ersätta den med `soft` eller `all` baserat på dina krav. Var försiktig när du använder rensningstypen `hard` eftersom den ökar trafiken till den ursprungliga servern.

### Rensa cacheminnet för en viss resurs

I det här exemplet rensar kommandot `curl` cachen för resursen `/us/en.html` på WKND-platsen som distribuerats i en AEM as a Cloud Service-miljö.

```bash
curl -X PURGE "https://publish-p46652-e1315806.adobeaemcloud.com/us/en.html" \
-H "X-AEM-Purge-Key: 123456789" \
-H "X-AEM-Purge: hard"
```

När rensningen lyckades returneras ett `200 OK`-svar med JSON-innehåll.

```json
{ "status": "ok", "id": "1000098-1722961031-13237063" }
```

### Rensa cacheminnet för en grupp resurser

I det här exemplet rensar kommandot `curl` cachen för resursgruppen med surrogatnyckeln `wknd-assets`. Svarshuvudet `Surrogate-Key` anges i [`wknd.vhost`](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.d/available_vhosts/wknd.vhost#L176), till exempel:

```http
<VirtualHost *:80>
    ...

    # Core Component Image Component: long-term caching (30 days) for immutable URLs, background refresh to avoid MISS
    <LocationMatch "^/content/.*\.coreimg.*\.(?i:jpe?g|png|gif|svg)$">
        Header set Cache-Control "max-age=2592000,stale-while-revalidate=43200,stale-if-error=43200,public,immutable" "expr=%{REQUEST_STATUS} < 400"
        # Set Surrogate-Key header to group the cache of WKND assets, thus it can be flushed independtly
        Header set Surrogate-Key "wknd-assets"
        Header set Age 0
    </LocationMatch>

    ...
</VirtualHost>
```

```bash
curl -X PURGE "https://publish-p46652-e1315806.adobeaemcloud.com" \
-H "Surrogate-Key: wknd-assets" \
-H "X-AEM-Purge-Key: 123456789" \
-H "X-AEM-Purge: hard"
```

När rensningen lyckades returneras ett `200 OK`-svar med JSON-innehåll.

```json
{ "wknd-assets": "10027-1723478994-2597809-1" }
```

### Rensa hela cacheminnet

I det här exemplet rensas hela cachen från exempelwebbplatsen WKND som distribuerats i AEM as a Cloud Service-miljön med kommandot `curl`.

```bash
curl -X PURGE "https://publish-p46652-e1315806.adobeaemcloud.com/" \
-H "X-AEM-Purge-Key: 123456789" \
-H "X-AEM-Purge: all"
```

När rensningen lyckades returneras ett `200 OK`-svar med JSON-innehåll.

```json
{"status":"ok"}
```

### Verifiera rensning av cache

Verifiera rensningen av cacheminnet genom att öppna resurs-URL:en i webbläsaren och granska svarsrubrikerna. Rubrikvärdet `X-Cache` ska vara `MISS`.

![X-cache-huvud](../assets/how-to/x-cache-miss.png)