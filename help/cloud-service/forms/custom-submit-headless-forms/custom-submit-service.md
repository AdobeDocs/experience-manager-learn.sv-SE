---
title: Skapa en anpassad skicka-tjänst för hantering av headless adaptive form submit
description: Returnera anpassat svar baserat på skickade data
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-13520
exl-id: c23275d7-daf7-4a42-83b6-4d04b297c470
duration: 134
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '451'
ht-degree: 0%

---

# Skapa anpassad sändning

AEM Forms tillhandahåller ett antal inskickningsalternativ som uppfyller de flesta användningsområdena.Förutom de här fördefinierade inskickningsåtgärderna kan du med AEM Forms skriva en egen anpassad inskickningshanterare som bearbetar inskickandet av formuläret efter dina behov.

Så här skriver du en anpassad skicka-tjänst:

## Skapa AEM

Om du redan har ett AEM Forms Cloud Service-projekt kan du [hoppa till att skriva anpassad skicka-tjänst](#Write-the-custom-submit-service)

* Skapa en mapp som kallas molnhanterare på din c-enhet.
* Navigera till den nya mappen
* Kopiera och klistra in innehållet [den här textfilen](./assets/creating-maven-project.txt) i kommandotolken.Du kan behöva ändra DarchetypeVersion=41 beroende på [senaste versionen](https://github.com/adobe/aem-project-archetype/releases). Den senaste versionen var 41 när den här artikeln skrevs.
* Kör kommandot genom att trycka på tangenten enter.Om allt är rätt ska du se meddelandet om att det lyckades.

## Skriv den anpassade skicka-tjänsten{#Write-the-custom-submit-service}

Starta IntelliJ och öppna AEM. Skapa en ny java-klass som kallas **HandleRegistrationFormSubmission** som visas på skärmbilden nedan
![skräddarsydd tjänst](./assets/custom-submit-service.png)

Följande kod skrevs för att implementera tjänsten

```java
package com.aem.bankingapplication.core;
import java.util.HashMap;
import java.util.Map;
import com.google.gson.Gson;
import org.osgi.service.component.annotations.Component;
import com.adobe.aemds.guide.model.FormSubmitInfo;
import com.adobe.aemds.guide.service.FormSubmitActionService;
import com.adobe.aemds.guide.utils.GuideConstants;
import com.google.gson.JsonObject;
import org.slf4j.*;

@Component(
        service=FormSubmitActionService.class,
        immediate = true
)
public class HandleRegistrationFormSubmission implements FormSubmitActionService {
    private static final String serviceName = "Core Custom AF Submit";
    private static Logger logger = LoggerFactory.getLogger(HandleRegistrationFormSubmission.class);



    @Override
    public String getServiceName() {
        return serviceName;
    }

    @Override
    public Map<String, Object> submit(FormSubmitInfo formSubmitInfo) {
        logger.error("in my custom submit service");
        Map<String, Object> result = new HashMap<>();
        logger.error("in my custom submit service");
        String data = formSubmitInfo.getData();
        JsonObject formData = new Gson().fromJson(data,JsonObject.class);
        logger.error("The form data is "+formData);
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("firstName",formData.get("firstName").getAsString());
        jsonObject.addProperty("lastName",formData.get("lastName").getAsString());
        result.put(GuideConstants.FORM_SUBMISSION_COMPLETE, Boolean.TRUE);
        result.put("json",jsonObject.toString());
        return result;
    }

}
```

## Skapa en crx-nod under appar

Expandera noden ui.apps och skapa ett nytt paket med namnet **HandleRegistrationFormSubmission** under programnoden enligt skärmbilden nedan
![crx-node](./assets/crx-node.png)
Skapa en fil med namnet .content.xml under **HandleRegistrationFormSubmission**. Kopiera och klistra in följande kod i .content.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:sling="http://sling.apache.org/jcr/sling/1.0"
    jcr:description="Handle Registration Form Submission"
    jcr:primaryType="sling:Folder"
    guideComponentType="fd/af/components/guidesubmittype"
    guideDataModel="xfa,xsd,basic"
    submitService="Core Custom AF Submit"/>
```

Värdet för **submitService** elementet måste matcha  **serviceName = &quot;Core Custom AF Submit&quot;** i FormSubmitActionService-implementeringen.

## Distribuera koden till din lokala AEM Forms-instans

Innan du skickar ändringarna till molnhanterardatabasen bör du distribuera koden till den lokala molnförberedda författarinstansen för att testa koden. Kontrollera att författarinstansen körs.
Om du vill distribuera koden till den molnförberedda författarinstansen går du till rotmappen för ditt AEM projekt och kör följande kommando

```
mvn clean install -PautoInstallSinglePackage
```

Detta distribuerar koden som ett enda paket till författarinstansen

## Skicka koden till molnhanteraren och distribuera koden

När du har verifierat koden på din lokala instans skickar du koden till din molninstans.
Skicka ändringarna till din lokala Git-databas och sedan till molnhanterardatabasen. Du kan läsa  [Git-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/setup-git.html), [överföra AEM till molnhanterardatabasen](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/push-project-to-cloud-manager-git.html) och [distribuera till utvecklingsmiljön](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/deploy-to-dev-environment.html) artiklar.

När piplexin har körts korrekt bör du kunna koppla formulärskickaåtgärden till den anpassade överföringshanteraren, som visas på skärmbilden nedan
![skicka-åtgärd](./assets/configure-submit-action.png)

## Nästa steg

[Visa det anpassade svaret i din svarsapp](./handle-response-react-app.md)
