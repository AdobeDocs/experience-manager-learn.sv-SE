---
title: Anpassat domännamn med CDN som hanteras av Adobe
description: Lär dig hur du implementerar ett anpassat domännamn på AEM as a Cloud Service webbplats som använder ett CDN som hanteras med Adobe.
version: Cloud Service
feature: Cloud Manager, Operations
topic: Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
duration: 1042
last-substantial-update: 2024-03-12T00:00:00Z
jira: KT-15121
thumbnail: KT-15121.jpeg
exl-id: 8936c3ae-2daf-4d0f-b260-28376ae28087
source-git-commit: 13657903c37b90c6d854dcba317dc1801d869de0
workflow-type: tm+mt
source-wordcount: '728'
ht-degree: 0%

---

# Anpassat domännamn med Adobe CDN

Lär dig hur du implementerar ett eget domännamn för en AEM as a Cloud Service-webbplats som använder CDN (Adobe Content Delivery Network).

I den här självstudiekursen har varumärket för exempelwebbplatsen [AEM WKND](https://github.com/adobe/aem-guides-wknd) förbättrats genom att ett anpassat domännamn `wknd.enablementadobe.com` med HTTPS-adresserbart läggs till med TLS (Transport Layer Security).

>[!VIDEO](https://video.tv.adobe.com/v/3427903?quality=12&learn=on)

Stegen på hög nivå är:

![Anpassat domännamn med Adobe CDN](./assets/add-custom-domain-name-with-Adobe-CDN.png){width="800" zoomable="yes"}

## Förutsättningar

>[!VIDEO](https://video.tv.adobe.com/v/3427909?quality=12&learn=on)

- [OpenSSL](https://www.openssl.org/) och [dig](https://www.isc.org/blogs/dns-checker/) är installerade på din lokala dator.
- Tillgång till tredjepartstjänster:
   - Certifikatutfärdare (CA) - att begära det signerade certifikatet för din webbplatsdomän, som [DigitCert](https://www.digicert.com/)
   - DNS-värdtjänst (Domain Name System) - för att lägga till DNS-poster för din anpassade domän, som Azure DNS eller AWS Route 53.
- Åtkomst till [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/) som **Business Owner** eller **Deployment Manager**.
- Exempelwebbplatsen [AEM WKND](https://github.com/adobe/aem-guides-wknd) har distribuerats till AEM as a Cloud Service-miljön av typen [production program](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-production-programs).

Om du inte har tillgång till tredjepartstjänster kan du _samarbeta med ditt säkerhets- eller värdteam för att slutföra stegen_.

## Generera SSL-certifikat

>[!VIDEO](https://video.tv.adobe.com/v/3427908?quality=12&learn=on)

Du har två alternativ:

1. Använd kommandoradsverktyget `openssl` för att generera en privat nyckel och en CSR (Certificate Signing Request) för din webbplatsdomän. Om du vill begära ett signerat certifikat skickar du CSR till en certifikatutfärdare (CA).
1. Ditt värdteam tillhandahåller den privata nyckel och det signerade certifikat som krävs för din webbplats.

Vi går igenom stegen för det första alternativet.

Om du vill generera en privat nyckel och en CSR kör du följande kommandon och anger nödvändig information när du uppmanas till det:

```bash
# Generate a private key and a CSR
$ openssl req -newkey rsa:2048 -keyout <YOUR-SITE-NAME>.key -out <YOUR-SITE-NAME>.csr -nodes
```

Om du vill begära ett signerat certifikat tillhandahåller du den genererade CSR till certifikatutfärdaren genom att följa CA:s dokumentation. När certifikatutfärdaren har signerat CSR-koden får du den signerade certifikatfilen.

### Granska signerat certifikat

Granska det signerade certifikatet innan du lägger till det i Cloud Manager. Granska certifikatinformationen med följande kommando:

```bash
# Review the certificate details
$ openssl crl2pkcs7 -nocrl -certfile <YOUR-SIGNED-CERT>.crt | openssl pkcs7 -print_certs -noout
```

Det signerade certifikatet kan innehålla certifikatkedjan, som innehåller rot- och mellanliggande certifikat tillsammans med slutentitetscertifikatet.

Adobe Cloud Manager godkänner slutentitetscertifikatet och certifikatkedjan _i separata formulärfält_, så du måste extrahera slutentitetscertifikatet och certifikatkedjan från det signerade certifikatet.

I den här självstudien används det [DigitCert](https://www.digicert.com/)-signerade certifikatet som utfärdats mot domänen `*.enablementadobe.com` som exempel. Slutentiteten och certifikatkedjan extraheras genom att det signerade certifikatet öppnas i en textredigerare och innehållet mellan markörerna `-----BEGIN CERTIFICATE-----` och `-----END CERTIFICATE-----` kopieras.

## Lägg till SSL-certifikat i Cloud Manager

>[!VIDEO](https://video.tv.adobe.com/v/3427906?quality=12&learn=on)

Om du vill lägga till SSL-certifikatet i Cloud Manager följer du dokumentationen för [lägg till SSL-certifikat](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-ssl-certificates/add-ssl-certificate).

## Verifiering av domännamn

>[!VIDEO](https://video.tv.adobe.com/v/3427905?quality=12&learn=on)

Så här verifierar du domännamnet:

- Lägg till ett domännamn i Cloud Manager genom att följa dokumentationen för [lägg till eget domännamn](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/add-custom-domain-name).
- Lägg till en AEM specifik [TXT-post](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/add-text-record) i DNS-värdtjänsten.
- Kontrollera ovanstående steg genom att fråga DNS-servrarna med kommandot `dig`.

```bash
# General syntax, the `_aemverification` is prefix provided by Adobe
$ dig _aemverification.[YOUR-DOMAIN-NAME] -t txt

# This tutorial specific example, as the subdomain `wknd.enablementadobe.com` is used
$ dig _aemverification.wknd.enablementadobe.com -t txt
```

Samplet av lyckat svar ser ut så här:

```bash
; <<>> DiG 9.10.6 <<>> _aemverification.wknd.enablementadobe.com -t txt
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8636
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1220
;; QUESTION SECTION:
;_aemverification.wknd.enablementadobe.com. IN TXT

;; ANSWER SECTION:
_aemverification.wknd.enablementadobe.com. 3600    IN TXT "adobe-aem-verification=wknd.enablementadobe.com/105881/991000/bef0e843-9280-4385-9984-357ed9a4217b"

;; Query time: 81 msec
;; SERVER: 153.32.14.247#53(153.32.14.247)
;; WHEN: Tue Mar 12 15:54:25 EDT 2024
;; MSG SIZE  rcvd: 181
```

I den här självstudien används Azure DNS, men alla DNS-leverantörer kan användas. Om du vill lägga till TXT-posten måste du följa dokumentationen för DNS-värdtjänsten.

Granska dokumentationen [för kontroll av domännamnsstatus](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/check-domain-name-status) om det finns något problem.

## Konfigurera DNS-post

>[!VIDEO](https://video.tv.adobe.com/v/3427907?quality=12&learn=on)

Så här konfigurerar du DNS-posten för din anpassade domän:

1. Ta reda på DNS-posttypen (CNAME eller APEX) baserat på domäntypen, till exempel rotdomän (APEX) eller underdomän (CNAME), och följ dokumentationen för [Konfigurera DNS-inställningar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/configure-dns-settings).
1. Lägg till DNS-posten i DNS-värdtjänsten.
1. Utlös verifieringen av DNS-posten genom att följa dokumentationen för [Kontrollera DNS-poststatus](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/check-dns-record-status).

I den här självstudien läggs CNAME-posttypen som pekar på `cdn.adobeaemcloud.com` till, eftersom en **underdomän** `wknd.enablementadobe.com` används.

Om du använder **rotdomänen** måste du lägga till en APEX-posttyp (även A, ALIAS eller ANAME) som pekar på de IP-adresser som tillhandahålls av Adobe.

## Platsverifiering

>[!VIDEO](https://video.tv.adobe.com/v/3427904?quality=12&learn=on)

Om du vill verifiera att webbplatsen är tillgänglig med det anpassade domännamnet öppnar du en webbläsare och navigerar till den anpassade domän-URL:en. Kontrollera att webbplatsen är tillgänglig och att webbläsaren visar en säker anslutning till hänglåsikonen.

## Avsluta video

Du kan även titta på en video från början till slut som demonstrerar översikten, förutsättningarna och ovanstående steg för att lägga till ett anpassat domännamn på en AEM as a Cloud Service-värdwebbplats.

>[!VIDEO](https://video.tv.adobe.com/v/3427817?quality=12&learn=on)
