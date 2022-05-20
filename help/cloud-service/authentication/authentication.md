---
title: Autentisering på AEM as a Cloud Service
description: Lär dig mer om autentisering i AEM as a Cloud Service.
version: Cloud Service
feature: Security
topic: Development, Integrations, Security
role: Architect, Developer
level: Intermediate
kt: 10436
thumbnail: KT-10436.jpeg
source-git-commit: e666e38d6b2a7057f7016b35ad1034a4487e9bc7
workflow-type: tm+mt
source-wordcount: '115'
ht-degree: 0%

---


# AEM as a Cloud Service autentisering

AEM as a Cloud Service stöder flera autentiseringsalternativ och varierar beroende på tjänsttyp.

|  | AEM Author | AEM Publish |
|-----------------------|:----------:|:-----------:|
| [Adobe IMS](../accessing/overview.md) | ✔ | ✘ |
| [SAML 2.0](./saml-2-0.md) | ✘ | ✔ |
| [Tokenautentisering](../../headless-tutorial/authentication/overview.md) | ✔ | ✔ |

## Autentiseringsalternativ

Klicka på motsvarande länk nedan om du vill ha mer information om hur du konfigurerar och använder autentiseringsmetoden.

<table>
  <tr>
   <td>
      <a  href="../accessing/overview.md"><img alt="Adobe IMS" src="./assets/card--adobe-ims.png"/></a>
      <div><strong><a href="../accessing/overview.md">Adobe IMS</a></strong></div>
      <p>
          Åtkomst till AEM Author med Adobe IMS via Adobe Admin Console.
      </p>
    </td>   
   <td>
      <a  href="./saml-2-0.md"><img alt="SAML 2.0" src="./assets/card--saml-2-0.png"/></a>
      <div><strong><a href="./saml-2-0.md">SAML 2.0</a></strong></div>
      <p>
        Autentisera webbplatsens användare till en IDP med hjälp av AEM Publish-tjänstens SAML 2.0-integrering.
      </p>
    </td>   
   <td>
      <a  href="../../headless-tutorial/authentication/overview.md"><img alt="Token" src="./assets/card--token.png"/></a>
      <div><strong><a href="../../headless-tutorial/authentication/overview.md">Tokenautentisering</a></strong></div>
      <p>
        Tillåt att program och mellanvara autentiserar AEM med en API-tjänsttoken.
      </p>
    </td>   
  </tr>
</table>
