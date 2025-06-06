---
title: Avancerade nätverk
description: Läs om AEM as a Cloud Service avancerade nätverksalternativ.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Integrations, Security
role: Architect, Developer
level: Intermediate
jira: KT-9354
thumbnail: KT-9354.png
last-substantial-update: 2022-10-13T00:00:00Z
exl-id: d1c1a3cf-989a-4693-9e0f-c1b545643e41
duration: 85
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '450'
ht-degree: 0%

---

# Avancerade nätverk

AEM as a Cloud Service har avancerade nätverksfunktioner som möjliggör exakt hantering av anslutningar till och från AEM as a Cloud Service-program.

|                                                   | [Produktionsprogram](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-production-programs.html?lang=sv-SE) | [Sandlådeprogram](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-sandbox-programs.html?lang=sv-SE) |
|---------------------------------------------------|:-----------------------:|:---------------------:|
| Stöd för avancerade nätverk | ✔ | ✘ |


AEM avancerade nätverk består av tre alternativ för hantering av anslutning med externa tjänster. Ett Cloud Manager-program, och dess AEM as a Cloud Service-miljöer, kan bara använda en enda typ av avancerad nätverkskonfiguration åt gången, så se till att du väljer den lämpligaste typen.

|                                   | HTTP/HTTPS på standardportar | HTTP/HTTPS på portar som inte är standard | Icke-HTTP/HTTPS-anslutningar | Dedikerad IP-adress för utgångar | Listan&quot;Inga proxyvärdar&quot; | Anslut till VPN-skyddade tjänster | Begränsa AEM Publish-trafik med IP |
|-----------------------------------|:----------------------------:|:--------------------------------:|:--------------------------:|:-------------------:|:-------------------------------------:|:-------------------------------------:|:----:|
| __Inga avancerade nätverk__ | ✔ | ✘ | ✘ | ✘ | ✘ | ✘ | ✘ |
| [__Flexibel portutgång__](./flexible-port-egress.md) | ✔ | ✔ | ✔ | ✘ | ✘ | ✘ | ✘ |
| [__Dedikerad IP-adress för utgångar__](./dedicated-egress-ip-address.md) | ✔ | ✔ | ✔ | ✔ | ✔ | ✘ | ✘ |
| [__Virtuellt privat nätverk__](./vpn.md) | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |


Mer information om vad du bör tänka på när du väljer lämplig avancerad nätverkstyp finns i [avancerad nätverksdokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/security/configuring-advanced-networking.html?lang=sv-SE).

## Avancerade självstudiekurser för nätverk

När det lämpligaste avancerade nätverksalternativet baserat på organisationens behov har identifierats kan du klicka i motsvarande självstudiekurs nedan för att få stegvisa instruktioner och kodexempel.

<table>
  <tr>
   <td>
      <a  href="./flexible-port-egress.md"><img alt="Flexibel portutgång" src="./assets/flexible-port-egress.png"/></a>
      <div><strong><a href="./flexible-port-egress.md">Flexibel portutgång</a></strong></div>
      <p>
          Tillåt utgående AEM as a Cloud Service-trafik på icke-standardportar.
      </p>
    </td>   
   <td>
      <a  href="./dedicated-egress-ip-address.md"><img alt="FleDedicated egress IP-adress" src="./assets/dedicated-egress-ip-address.png"/></a>
      <div><strong><a href="./dedicated-egress-ip-address.md">Dedikerad IP-adress för utgångar</a></strong></div>
      <p>
        Ursprunglig utgående AEM as a Cloud Service-trafik från en dedikerad IP-adress.
      </p>
    </td>   
   <td>
      <a  href="./vpn.md"><img alt="VPN (Virtual Private Network)" src="./assets/vpn.png"/></a>
      <div><strong><a href="./vpn.md">VPN (Virtual Private Network)</a></strong></div>
      <p>
        Säker trafik mellan en kund- eller leverantörsinfrastruktur och AEM as a Cloud Service.
      </p>
    </td>   
  </tr>
</table>

## Exempel på koder

Den här samlingen innehåller exempel på den konfiguration och kod som krävs för att utnyttja avancerade nätverksfunktioner för specifika användningsområden.

Kontrollera att rätt [avancerad nätverkskonfiguration](#advanced-networking) har konfigurerats innan du följer dessa självstudier.

<table><tr>
   <td>
      <a  href="./examples/email-service.md"><img alt="VPN (Virtual Private Network)" src="./assets/code-examples__email.png"/></a>
      <div><strong><a href="./examples/email-service.md">E-posttjänst</a></strong></div>
      <p>
        Exempel på OSGi-konfiguration som använder AEM för att ansluta till externa e-posttjänster.
      </p>
    </td>  
    <td>
        <a  href="./examples/http-dedicated-egress-ip-vpn.md"><img alt="HTTP/HTTPS" src="./assets/code-examples__http.png"/></a>
        <div><strong><a href="./examples/http-dedicated-egress-ip-vpn.md">HTTP/HTTPS</a></strong></div>
        <p>
            Exempel på Java™-kod som skapar HTTP/HTTPS-anslutning från AEM as a Cloud Service till en extern tjänst med HTTP/HTTPS-protokoll.
        </p>
    </td>
    <td>
      <a  href="./examples/sql-datasourcepool.md"><img alt="SQL-anslutning med JDBC DataSourcePool" src="./assets//code-examples__sql-osgi.png"/></a>
      <div><strong><a href="./examples/sql-datasourcepool.md">SQL-anslutning med JDBC DataSourcePool</a></strong></div>
      <p>
            Exempel på Java™-kod som ansluter till externa SQL-databaser genom att konfigurera AEM JDBC-datakällpool.
      </p>
    </td>   
    </tr><tr>
    <td>
      <a  href="./examples/sql-java-apis.md"><img alt="SQL-anslutning med Java API:er" src="./assets/code-examples__sql-java-api.png"/></a>
      <div><strong><a href="./examples/sql-java-apis.md">SQL-anslutning med Java™ API:er</a></strong></div>
      <p>
            Exempel på Java™-kod som ansluter till externa SQL-databaser med Java™ SQL API:er.
      </p>
    </td>   
    <td>
      <a  href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list.html?lang=sv-SE"><img alt="Använda IP tillåtelselista" src="./assets/code_examples__vpn-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list.html?lang=sv-SE">Använder en IP-tillåtelselista</a></strong></div>
      <p>
            Konfigurera en IP-tillåtelselista så att endast VPN-trafik kan komma åt AEM.
      </p>
    </td>
   <td>
      <a  href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/security/configuring-advanced-networking.html?lang=sv-SE#restrict-vpn-to-ingress-connections"><img alt="Sökvägsbaserade begränsningar för VPN-åtkomst till AEM Publish" src="./assets/code_examples__vpn-path-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/security/configuring-advanced-networking.html?lang=sv-SE#restrict-vpn-to-ingress-connections">Sökvägsbaserade begränsningar för VPN-åtkomst till AEM Publish</a></strong></div>
      <p>
            Kräv VPN-åtkomst för specifika sökvägar i AEM Publish.
      </p>
    </td>
</tr>
</table>
