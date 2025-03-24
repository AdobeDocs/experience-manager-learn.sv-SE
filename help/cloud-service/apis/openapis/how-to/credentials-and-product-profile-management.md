---
title: API-referenser och hantering av produktprofiler
description: Lär dig hur du hanterar autentiseringsuppgifter och produktprofiler för AEM API:er.
version: Experience Manager as a Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Article
jira: KT-17428
thumbnail: KT-17428.jpeg
last-substantial-update: 2025-02-28T00:00:00Z
duration: 0
exl-id: 277b4789-b035-4904-b489-c827c970fb55
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '738'
ht-degree: 0%

---

# API-referenser och hantering av produktprofiler

Lär dig hur du hanterar _autentiseringsuppgifter och produktprofil_ för OpenAPI-baserade AEM-API:er.

I den här självstudiekursen får du lära dig att lägga till eller ta bort:

- _Autentiseringsuppgifter_: Ange autentisering för ett AEM-API.
- _Produktprofiler_: Ange behörigheter (eller auktorisering) för autentiseringsuppgifter för åtkomst till AEM-resurserna.

## Bakgrund

När du använder ett AEM-API måste du definiera _autentiseringsuppgifter_ och _produktprofil_ i Adobe Developer Console-projektet (eller ADC-projektet). På följande skärmbild kan du se _Autentiseringsuppgifter_ och _produktprofil_ för ett AEM Assets Author API:

![Autentiseringsuppgifter och produktprofil](../assets/how-to/API-Credentials-Product-Profile.png)

_Autentiseringsuppgifterna_ tillhandahåller autentiseringsmekanismen för API:t. _Produktprofilen_ ger _behörighet (eller behörighet)_ till autentiseringsuppgifterna och ger åtkomst till AEM-resurserna. API-begäran kan vara för ett program eller en användare.

En produktprofil är associerad med en eller flera _tjänster_. I AEM as a Cloud Service representerar en _tjänst_ användargrupper med fördefinierade åtkomstkontrollistor (ACL) för databasnoder, vilket möjliggör detaljerad behörighetshantering.

![Användarproduktprofil för tekniskt konto](../assets/s2s/technical-account-user-product-profile.png)

När API-anropet lyckades skapas en användare som representerar ADC-projektets autentiseringsuppgifter i AEM Author-tjänsten tillsammans med användargrupperna som matchar produktprofilen och tjänstkonfigurationen.

![Användarmedlemskap för tekniskt konto](../assets/s2s/technical-account-user-membership.png)

I ovanstående scenario skapas användaren `1323d2...` i AEM Author-tjänsten och är medlem i användargrupperna `AEM Assets Collaborator Users - Service` och `AEM Assets Collaborator Users - author - Program XXX - Environment XXX`.

## Lägg till eller ta bort autentiseringsuppgifter

AEM API:er har stöd för följande typer av autentiseringsuppgifter:

1. **OAuth Server-till-server**: Utformad för interaktioner mellan dator och dator.
1. **OAuth Web App**: Utformad för användardrivna interaktioner med en serverdel i klientprogrammet.
1. **OAuth-app för en sida**: Utformad för användardrivna interaktioner utan en serverdel i klientprogrammet.

Du kan använda olika användningsfall med olika typer av autentiseringsuppgifter.

Alla autentiseringsuppgifter hanteras i ADC-projektet.

>[!BEGINTABS]

>[!TAB Lägg till autentiseringsuppgifter]

Om du vill lägga till autentiseringsuppgifter för ett AEM API går du till avsnittet **API:er** i ADC-projektet och klickar på **Anslut en annan autentiseringsuppgift**. Följ sedan instruktionerna för den specifika autentiseringstypen.

![Anslut en annan autentiseringsuppgift](../assets/how-to/connect-another-credential.png)

>[!TAB Ta bort autentiseringsuppgifter]

Om du vill ta bort en AEM API-autentiseringsuppgift markerar du den i avsnittet **API:er** i ADC-projektet och klickar sedan på **Ta bort autentiseringsuppgifter**.

![Ta bort autentiseringsuppgifter](../assets/how-to/delete-credential.png)


>[!ENDTABS]

## Lägg till eller ta bort produktprofiler

_Produktprofilen_ ger _behörighet (eller behörighet)_ till autentiseringsuppgifterna för åtkomst till AEM-resurserna. Behörigheterna som tillhandahålls av _produktprofilen_ baseras på de _tjänster_ som är kopplade till _produktprofilen_. De flesta _tjänster_ ger behörighet _READ_ till AEM-resurserna, via användargrupperna i AEM-instansen som har samma namn som _tjänsten_.

Det finns tillfällen när autentiseringsuppgifterna (även tekniska kontoanvändare) behöver ytterligare behörigheter, som _Skapa, Uppdatera, Ta bort_ (CUD) för AEM-resurser. I sådana fall måste du lägga till en ny _produktprofil_ som är associerad med _tjänsterna_ som ger de behörigheter som krävs.

När ett anrop till AEM Assets Author API tar emot [403-fel för icke-GET-begäranden](../use-cases/invoke-api-using-oauth-s2s.md#403-error-for-non-get-requests) kan du till exempel lägga till **AEM-administratörer - författare - Program XXX - Miljö XXX** _Produktprofil_ för att lösa problemet.

>[!CAUTION]
>
>Tjänsten **AEM Administrators** ger _FULL_ administrativ åtkomst till Experience Manager. Du kan också uppdatera [tjänstbehörighet](./services-user-group-permission-management.md) så att bara de behörigheter som krävs anges.

>[!BEGINTABS]

>[!TAB Lägg till produktprofiler]

Om du vill lägga till produktprofiler för ett AEM API klickar du på **Redigera produktprofiler** i avsnittet **API:er** i ADC-projektet, väljer önskad produktprofil i dialogrutan **Konfigurera API** och sparar ändringarna.

    ![Redigera produktprofiler](../assets/how-to/edit-product-profiles.png)

Välj önskad produktprofil (t.ex. **AEM-administratörer - författare - Program XXX - Miljö XXX**) som är kopplad till de tjänster som krävs och spara sedan ändringarna.

    ![Välj produktprofil](../assets/how-to/select-product-profile.png)

Observera att produktprofilen **AEM-administratörer - författare - program XXX - miljö XXX** är kopplad till både **AEM-administratörstjänsten** och **AEM Assets API-användartjänsten**. Utan den senare kommer produktprofilen inte att visas i listan över tillgängliga produktprofiler.

    ![Product Profile Services](../assets/how-to/product-profile-services.png)

**PATCH**-begäran om att uppdatera metadata för resursen bör nu fungera utan problem.

    ![PATCH Request](../assets/how-to/patch-request.png)


>[!TAB Ta bort produktprofiler]

Om du vill ta bort produktprofiler för ett AEM API klickar du på **Redigera produktprofiler** i avsnittet **API:er** i ADC-projektet, avmarkerar önskad produktprofil i dialogrutan **Konfigurera API** och sparar ändringarna.
![Avmarkera produktprofil](../assets/how-to/deselect-product-profile.png)

>[!ENDTABS]

## Sammanfattning

Du lärde dig att ändra autentiseringsmekanismen och behörigheterna för AEM API:er med _Autentiseringsuppgifter och produktprofil_ i Adobe Developer Console-projektet (ADC).
