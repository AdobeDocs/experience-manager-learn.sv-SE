---
title: Autentisering i AEM as a Cloud Service
description: Läs mer om autentisering i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Integrations, Security
role: Developer
level: Intermediate
jira: KT-10436
thumbnail: KT-10436.png
last-substantial-update: 2022-10-14T00:00:00Z
exl-id: 4dba6c09-2949-4153-a9bc-d660a740f8f7
duration: 28
source-git-commit: 447ce616f043a67cb493507fc3de593859a53cb9
workflow-type: tm+mt
source-wordcount: '144'
ht-degree: 0%

---

# AEM as a Cloud Service-autentisering

AEM as a Cloud Service har stöd för flera autentiseringsalternativ och varierar beroende på tjänstetyp.

|                       | AEM Author | AEM Publish |
|-----------------------|:----------:|:-----------:|
| [Adobe IMS ](../accessing/overview.md)<br>*(AEM Preview does not support Adobe IMS)* | ✔ | ✔ |
| [OpenID Connect (OIDC)](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/open-id-connect-support-for-aem-as-a-cloud-service-on-publish-tier) | ✘ | ✔ |
| [SAML 2.0 via Adobe IMS](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/ims-support.html#how-to-set-up) | ✔ | ✔ |
| [SAML 2.0](./saml-2-0.md) | ✘ | ✔ |
| [Enkel inloggning (SSO)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/personalization/user-and-group-sync-for-publish-tier.html#integration-with-an-idp) | ✘ | ✔ |
| [OAuth](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/personalization/user-and-group-sync-for-publish-tier.html#integration-with-an-idp) | ✘ | ✔ |
| [Tokenautentisering](../../headless-tutorial/authentication/overview.md) | ✔ | ✔ |
| Grundläggande autentisering | ✘ | ✘ |

## Autentiseringsalternativ

Klicka på motsvarande länk nedan om du vill ha mer information om hur du konfigurerar och använder autentiseringsmetoden.

<table>
  <tr>
   <td>
      <a  href="../accessing/overview.md"><img alt="Adobe IMS" src="./assets/card--adobe-ims.png"/></a>
      <div><strong><a href="../accessing/overview.md">Adobe IMS</a></strong></div>
      <p>
          Hantera åtkomsten till AEM Author med Adobe IMS via Adobe Admin Console.
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
        Tillåt att program och mellanvara autentiserar till AEM med en API-tjänsttoken.
      </p>
    </td>   
  </tr>
</table>
