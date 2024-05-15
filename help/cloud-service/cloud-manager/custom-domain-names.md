---
title: Lägg till anpassat domännamn
description: Lär dig hur du lägger till ett anpassat domännamn AEM som en molntjänstvärd webbplats.
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
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '701'
ht-degree: 0%

---

# Lägg till anpassat domännamn

Lär dig hur du lägger till ett anpassat domännamn AEM en as a Cloud Service webbplats.

I den här självstudiekursen är det bara varumärket [AEM WKND](https://github.com/adobe/aem-guides-wknd) webbplatsen har förbättrats genom att ett anpassat domännamn med HTTPS-adress läggs till `wknd.enablementadobe.com` med TLS (Transport Layer Security)

>[!VIDEO](https://video.tv.adobe.com/v/3427903?quality=12&learn=on)

Stegen på hög nivå är:

![Namn på anpassad hög domän](./assets/add-custom-domain-name-steps.png){width="800" zoomable="yes"}

## Förutsättningar

>[!VIDEO](https://video.tv.adobe.com/v/3427909?quality=12&learn=on)

- [OpenSSL](https://www.openssl.org/) och [digga](https://www.isc.org/blogs/dns-checker/) installeras på din lokala dator.
- Tillgång till tredjepartstjänster:
   - Certifikatutfärdare (CA) - för att begära det signerade certifikatet för din webbplatsdomän, som [DigitCert](https://www.digicert.com/)
   - DNS-värdtjänst (Domain Name System) - för att lägga till DNS-poster för din anpassade domän, som Azure DNS eller AWS Route 53.
- Åtkomst till [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/) som Business Owner eller Deployment Manager-roll.
- Exempel [AEM WKND](https://github.com/adobe/aem-guides-wknd) -sajten används i AEMCS-miljön för [produktionsprogram](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-production-programs) typ.

Om du inte har tillgång till tjänster från tredje part _samarbeta med ditt säkerhets- eller värdteam för att slutföra stegen_.

## Generera SSL-certifikat

>[!VIDEO](https://video.tv.adobe.com/v/3427908?quality=12&learn=on)

Du har två alternativ:

- Använda `openssl` kommandoradsverktyg - du kan generera en privat nyckel och en CSR-fil (Certificate Signing Request) för din webbplatsdomän. Om du vill begära ett signerat certifikat skickar du CSR till en certifikatutfärdare (CA).

- Ditt värdteam tillhandahåller den privata nyckel och det signerade certifikat som krävs för din webbplats.

Vi går igenom stegen för det första alternativet.

Om du vill generera en privat nyckel och en CSR kör du följande kommandon och anger nödvändig information när du uppmanas till det:

```bash
# Generate a private key and a CSR
$ openssl req -newkey rsa:2048 -keyout <YOUR-SITE-NAME>.key -out <YOUR-SITE-NAME>.csr -nodes
```

Om du vill begära ett signerat certifikat tillhandahåller du den genererade CSR-koden till certifikatutfärdaren genom att följa deras dokumentation. När certifikatutfärdaren har signerat CSR-koden får du den signerade certifikatfilen.

### Granska signerat certifikat

Det är bra att granska det signerade certifikatet innan du lägger till det i Cloud Manager. Du kan granska certifikatinformationen med följande kommando:

```bash
# Review the certificate details
$ openssl crl2pkcs7 -nocrl -certfile <YOUR-SIGNED-CERT>.crt | openssl pkcs7 -print_certs -noout
```

Det signerade certifikatet kan innehålla certifikatkedjan, som innehåller rot- och mellanliggande certifikat tillsammans med slutentitetscertifikatet.

Adobe Cloud Manager godkänner slutentitetscertifikatet och certifikatkedjan _i separata formulärfält_ så du måste extrahera slutenhetscertifikatet och certifikatkedjan från det signerade certifikatet.

I den här självstudien [DigitCert](https://www.digicert.com/) signerat certifikat utfärdat mot `*.enablementadobe.com` domän används som exempel. Slutentiteten och certifikatkedjan extraheras genom att det signerade certifikatet öppnas i en textredigerare och innehållet kopieras mellan `-----BEGIN CERTIFICATE-----` och `-----END CERTIFICATE-----` markörer.

## Lägg till SSL-certifikat i Cloud Manager

>[!VIDEO](https://video.tv.adobe.com/v/3427906?quality=12&learn=on)

Om du vill lägga till SSL-certifikatet i Cloud Manager följer du [Lägg till SSL-certifikat](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-ssl-certificates/add-ssl-certificate) dokumentation.

## Verifiering av domännamn

>[!VIDEO](https://video.tv.adobe.com/v/3427905?quality=12&learn=on)

Så här verifierar du domännamnet:

- Lägg till domännamn i Cloud Manager genom att följa följande [Lägg till anpassat domännamn](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/add-custom-domain-name) dokumentation.
- Lägg till en AEM [TXT-post](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/add-text-record) i din DNS-värdtjänst.
- Verifiera ovanstående steg genom att fråga DNS-servrarna med `dig` -kommando.

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

I den här självstudiekursen används Azure DNS som exempel. Om du vill lägga till TXT-posten måste du följa dokumentationen för DNS-värdtjänsten.

Granska [Kontrollerar domännamnsstatus](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/check-domain-name-status) dokumentation om det finns ett problem.

## Konfigurera DNS-post

>[!VIDEO](https://video.tv.adobe.com/v/3427907?quality=12&learn=on)

Så här konfigurerar du DNS-posten för din anpassade domän:

- Ta reda på DNS-posttypen (CNAME eller APEX) baserat på domäntypen, till exempel rotdomän (APEX) eller underdomän (CNAME), och följ [Konfigurera DNS-inställningar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/configure-dns-settings) dokumentation.
- Lägg till DNS-posten i DNS-värdtjänsten.
- Utlös verifieringen av DNS-posten genom att följa följande [Kontrollerar DNS-poststatus](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/custom-domain-names/check-dns-record-status) dokumentation.

I den här självstudiekursen som **underdomän** `wknd.enablementadobe.com` används, CNAME-posttypen som pekar på `cdn.adobeaemcloud.com` läggs till.

Om du använder **rotdomän** måste du lägga till en APEX-posttyp (även A, ALIAS eller ANAME) som pekar på de IP-adresser som tillhandahålls av Adobe.

## Platsverifiering

>[!VIDEO](https://video.tv.adobe.com/v/3427904?quality=12&learn=on)

Om du vill verifiera att webbplatsen är tillgänglig med det anpassade domännamnet öppnar du en webbläsare och navigerar till den anpassade domän-URL:en. Kontrollera att webbplatsen är tillgänglig och att webbläsaren visar en säker anslutning till hänglåsikonen.

## Avsluta video

Du kan också titta på den kompletta videon som demonstrerar översikten, förutsättningarna och ovanstående steg för att lägga till ett anpassat domännamn AEM en webbplats som är as a Cloud Service.

>[!VIDEO](https://video.tv.adobe.com/v/3427817?quality=12&learn=on)
