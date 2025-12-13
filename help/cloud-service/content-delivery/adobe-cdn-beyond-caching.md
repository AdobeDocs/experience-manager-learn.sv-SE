---
title: Adobe CDN - Avancerade funktioner utöver cachelagring
description: Lär dig mer om avancerade funktioner i Adobe CDN utöver cachelagring, som att konfigurera trafik på CDN, konfigurera tokens och inloggningsuppgifter, CDN-felsidor och mycket mer.
version: Experience Manager as a Cloud Service
feature: Website Performance, CDN Cache
topic: Architecture, Performance, Content Management
role: Developer, User, Leader
level: Beginner
doc-type: Article
duration: 0
last-substantial-update: 2024-08-21T00:00:00Z
jira: KT-15123
thumbnail: KT-15123.jpeg
exl-id: 8948a900-01e9-49ed-9ce5-3a057f5077e4
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '546'
ht-degree: 0%

---

# Adobe CDN - Avancerade funktioner utöver cachelagring

Lär dig mer om avancerade funktioner i Adobe Content Delivery Network (CDN) utöver cachning, som att konfigurera trafik vid CDN, konfigurera tokens och autentiseringsuppgifter, CDN-felsidor och mycket mer.

Förutom att cache-lagra innehåll har Adobe CDN flera avancerade funktioner som kan hjälpa dig att optimera webbplatsens prestanda. Bland dessa funktioner finns:

- Konfigurera trafik vid leveransnätverket
- Konfigurera CDN-autentiseringsuppgifter och autentisering
- CDN-felsidor

De här funktionerna är **självbetjäningsfunktioner**. Konfigureras i filen `cdn.yaml` i ditt AEM-projekt och distribueras med Cloud Manager konfigurationsflöde.

>[!VIDEO](https://video.tv.adobe.com/v/3433104?quality=12&learn=on)

## Konfigurera trafik vid leveransnätverket

Låt oss förstå nyckelfunktionerna som är relaterade till _Konfigurera trafik på CDN_:

- **DoS-attacker:** Adobe CDN absorberar DoS-attacker i nätverkslagret, vilket förhindrar dem från att nå din ursprungliga server.
- **Hastighetsbegränsning:** Om du vill skydda din ursprungliga server från att överbelastas med för många begäranden kan du konfigurera hastighetsbegränsning i CDN.
- **Brandvägg för webbaserade program (WAF):** WAF skyddar din webbplats från vanliga sårbarheter i webbprogram, som SQL-injektion, serveröverskridande skript med mera. Den utökade säkerhetslicensen eller WAF-DDoS-skyddslicensen krävs för att den här funktionen ska kunna användas.
- **Begäranomvandling:** Ändra inkommande begäranden som att ange eller ta bort rubriker, ändra frågeparametrar, cookies och mycket annat.
- **Svarsomvandling:** Ändra utgående svar, till exempel ange eller ta bort rubriker.
- **Urval av ursprung:** Dirigera trafik till olika ursprungliga servrar (Adobe och icke-Adobe) baserat på begärande-URL.
- **URL-omdirigering:** Omdirigeringsbegäranden (HTTP 301/302) till en annan absolut eller relativ URL.

## Konfigurera CDN-autentiseringsuppgifter och autentisering

Låt oss förstå nyckelfunktionerna som rör _Konfigurera CDN-autentiseringsuppgifter och autentisering_:

- **Rensa API-token**: Gör att du kan skapa en egen rensningsnyckel för att rensa en enskild eller grupp eller alla resurser från cachen.
- **Grundläggande autentisering**: En lättviktig autentiseringsmekanism när du vill begränsa åtkomsten till din webbplats eller en del av den. Krävs oftast som en del av olika granskningsprocesser innan de publiceras.
- **Verifiering av HTTP-huvud**: Används när ett kundhanterat CDN dirigerar trafik till Adobe CDN. Adobe CDN validerar inkommande begäran baserat på rubrikvärdet `X-AEM-Edge-Key`. Gör att du kan skapa ett eget värde för rubriken `X-AEM-Edge-Key`.

## CDN-felsidor

Låt oss förstå nyckelfunktionerna som är relaterade till _CDN-felsidor_:

- **Varumärkesprofilerade felsidor**: Visa en profilerad felsida för dina användare i det _osannolika scenariot_ när Adobe CDN inte kan nå din ursprungliga server.

## Implementera

Implementeringen av dessa avancerade funktioner omfattar två steg:

1. **Uppdatera CDN-konfigurationsfilen**: Uppdatera `cdn.yaml`-filen i ditt AEM-projekt med de nödvändiga konfigurationerna. Konfigurationerna läggs till som regler och de följer en regelsyntax. Regeln innehåller tre huvudkomponenter: `name`, `when` och `action`.

2. **Distribuera CDN-konfigurationsfilen**: Distribuera den uppdaterade `cdn.yaml` filen med hjälp av Cloud Manager konfigurationsflöde. Mer information finns i [Distribuera regler via Cloud Manager](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#deploy-rules-through-cloud-manager).

### Exempel

I exemplet nedan är WKND-exempelwebbplatsen konfigurerad att omdirigera URL:en `/top3` till `/us/en/top3.html`.

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
data:
  redirects:
    rules:
      - name: redirect-top3-adventures
        when: { reqProperty: path, equals: "/top3" }
        action:
          type: redirect
          status: 302
          location: /us/en/top3.html
```

## Relaterade självstudier

[Skydda webbplatser med trafikfilterregler](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/overview)

[Konfigurera och distribuera CDN-regel för HTTP Header-validering](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/content-delivery/custom-domain-names-with-customer-managed-cdn#configure-and-deploy-http-header-validation-cdn-rule)

[Töm CDN-cachen](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/caching/how-to/purge-cache)

[Konfigurera CDN-felsidor](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/content-delivery/custom-error-pages#cdn-error-pages)

[Konfigurera trafik vid CDN](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn-configuring-traffic#client-side-redirectors)

[Konfigurerar CDN-autentiseringsuppgifter och autentisering](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn-credentials-authentication)

