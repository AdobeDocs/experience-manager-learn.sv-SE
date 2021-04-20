---
title: Developing with Service Users in AEM Forms
seo-title: Developing with Service Users in AEM Forms
description: I den här artikeln beskrivs hur du skapar en tjänstanvändare i AEM Forms
seo-description: I den här artikeln beskrivs hur du skapar en tjänstanvändare i AEM Forms
uuid: 996f30df-3fc5-4232-a104-b92e1bee4713
feature: Adaptive Forms
topics: development,administration
audience: implementer,developer
doc-type: article
activity: setup
discoiquuid: 65bd4695-e110-48ba-80ec-2d36bc53ead2
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '451'
ht-degree: 0%

---


# Developing with Service Users in AEM Forms

I den här artikeln beskrivs hur du skapar en tjänstanvändare i AEM Forms

I tidigare versioner av Adobe Experience Manager (AEM) användes den administrativa resurslösaren för backend-bearbetning som krävde åtkomst till databasen. Användningen av den administrativa resurslösaren har tagits bort i AEM 6.3. I stället används en systemanvändare med specifik behörighet i databasen.

I den här artikeln beskrivs hur du skapar en systemanvändare och konfigurerar egenskaperna för användarmappningen.

1. Navigera till [http://localhost:4502/crx/explorer/index.jsp](http://localhost:4502/crx/explorer/index.jsp)
1. Logga in som admin
1. Klicka på &#39; Användaradministration &#39;
1. Klicka på Skapa systemanvändare
1. Ange användartypen som data och klicka på den gröna ikonen för att slutföra processen att skapa systemanvändaren
1. [Öppna configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter &#39; Apache Sling Service User Mapper Service &#39; och klicka för att öppna egenskaperna
1. Klicka på ikonen *+* (plus) för att lägga till följande tjänstmappning

   * DevelopingWithServiceUser.core:getresourceresolver=data
   * DevelopingWithServiceUser.core:getformsresourceresolver=fd-service

1. Klicka på Spara

I ovanstående konfigurationsinställning är DevelopingWithServiceUser.core paketets symboliska namn. getresouresolver är undertjänstens namn.data är systemanvändaren som skapades i det tidigare steget.

Vi kan också hämta resurslösare för Fd-service-användare. Den här tjänstanvändaren används för dokumenttjänster. Om du t.ex. vill certifiera/använda användningsrättigheter använder vi resurslösare från fd-service-användare för att utföra åtgärderna

1. [Ladda ned och zippa upp zip-filen som är kopplad till den här artikeln.](assets/developingwithserviceuser.zip)
1. Navigera till [http://localhost:4502/system/console/bundles](http://localhost:4502/system/console/bundles)
1. Ladda upp och starta OSGi-paketet
1. Kontrollera att paketet är i aktivt läge
1. Du har nu skapat en *systemanvändare* och distribuerat *tjänstanvändarpaketet*.

   Ge systemanvändaren (&#39; data &#39;) läsbehörighet på innehållsnoden för att ge åtkomst till /content.

   1. Navigera till [http://localhost:4502/useradmin](http://localhost:4502/useradmin)
   1. Sök efter användarens data. Detta är samma systemanvändare som du skapade i det tidigare steget.
   1. Dubbelklicka på användaren och klicka sedan på fliken Behörigheter
   1. Ge läsbehörighet till mappen content.
   1. Använd följande kod för att få åtkomst till /content-mappen

   ```java
   com.mergeandfuse.getserviceuserresolver.GetResolver aemDemoListings = sling.getService(com.mergeandfuse.getserviceuserresolver.GetResolver.class);
   
   resourceResolver = aemDemoListings.getServiceResolver();
   
   // get the resource. This will succeed because we have given ' read ' access to the content node
   
   Resource contentResource = resourceResolver.getResource("/content/forms/af/sandbox/abc.pdf");
   ```

   Om du vill komma åt /content/dam/data.json i ditt paket använder du följande kod. Den här koden förutsätter att du har gett läsbehörighet till användaren&quot;data&quot; på noden /content/dam/

   ```java
   @Reference
   GetResolver getResolver;
   .
   .
   .
   ResourceResolver serviceResolver = getResolver.getServiceResolver();
   // to get resource resolver specific to fd-service user. This is for Document Services
   ResourceResolver fdserviceResolver = getResolver.getFormsServiceResolver();
   Node resNode = getResolver.getServiceResolver().getResource("/content/dam/data.json").adaptTo(Node.class);
   ```

   Den fullständiga koden för implementeringen anges nedan

   ```java
   package com.mergeandfuse.getserviceuserresolver.impl;
   
   import java.util.HashMap;
   
   import org.apache.sling.api.resource.LoginException;
   import org.apache.sling.api.resource.ResourceResolver;
   import org.apache.sling.api.resource.ResourceResolverFactory;
   import org.osgi.service.component.annotations.Component;
   import org.osgi.service.component.annotations.Reference;
   import com.mergeandfuse.getserviceuserresolver.GetResolver;
   
   @Component(service = GetResolver.class)
   public class GetResolverImpl implements GetResolver {
    @Reference
    ResourceResolverFactory resolverFactory;
    @Override
    public ResourceResolver getServiceResolver() {
     HashMap<String, Object> param = new HashMap<String, Object>();
     param.put(ResourceResolverFactory.SUBSERVICE, "getresourceresolver");
     ResourceResolver resolver = null;
     try {
      resolver = resolverFactory.getServiceResourceResolver(param);
     } catch (LoginException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
     }
     return resolver;
    }
   ```

