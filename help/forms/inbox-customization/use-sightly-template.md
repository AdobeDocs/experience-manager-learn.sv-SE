---
title: Använda enkel mall för att visa inkorgsdata
description: Lägg till anpassade kolumner för att visa ytterligare data i arbetsflödet med hjälp av en enkel mall
feature: Adaptive Forms
doc-type: article
version: 6.5
jira: KT-5830
topic: Development
role: Developer
level: Experienced
exl-id: d09b46ed-3516-44cf-a616-4cb6e9dfdf41
duration: 68
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 0%

---

# Använda enkel mall för att visa inkorgsdata

Du kan använda en liten mall för att formatera de data som ska visas i inkorgskolumner. I det här exemplet visas koral-ui-ikoner beroende på värdet i resultatkolumnen. På följande skärmbild visas hur ikoner används i resultatkolumnen
![intäkter-ikoner](assets/income-column.PNG)

[Den smidiga mallen](assets/sightly-template.zip) som används för att visa de anpassade gränssnittsikonerna för coral anges som en del av den här artikeln.

## Liten mall

Här följer en enkel mall. Koden i mallen visas med ikonen beroende på inkomsten. Ikonerna är tillgängliga som en del av [ikonbibliotek för coral ui](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html#availableIcons) som kommer med AEM.

```java
<template data-sly-template.incomeTemplate="${@ item}>">
    <td is="coral-table-cell" class="payload-income-cell">
         <div data-sly-test="${(item.workflowMetadata && item.workflowMetadata.income)}" data-sly-set.income ="${item.workflowMetadata.income}">
                 <coral-icon icon="confidenceOne" size="M" data-sly-test="${income >=0 && income <10000}"></coral-icon>
                 <coral-icon icon="confidenceTwo" size="M" data-sly-test="${income >=10000 && income <100000}"></coral-icon>
                 <coral-icon icon="confidenceThree" size="M" data-sly-test="${income >=100000 && income <500000}"></coral-icon>
                 <coral-icon icon="confidenceFour" size="M" data-sly-test="${income >=500000}"></coral-icon>
          </div>
    </td>
</template>
```

## Tjänstimplementering

Följande kod är implementeringen av tjänsten för att visa resultatkolumnen.

Rad 12 associerar kolumnen med den synta mallen

```java
import java.util.Map;
import org.osgi.service.component.annotations.Component;
import com.adobe.cq.inbox.ui.InboxItem;
import com.adobe.cq.inbox.ui.column.Column;
import com.adobe.cq.inbox.ui.column.provider.ColumnProvider;

@Component(service = ColumnProvider.class, immediate = true)
public class IncomeProvider implements ColumnProvider {
@Override
public Column getColumn() {

return new Column("income", "Income", String.class.getName(),"inbox/customization/column-templates.html", "incomeTemplate");
}

@Override
public Object getValue(InboxItem inboxItem) {
Object val = null;

Map workflowMetadata = inboxItem.getWorkflowMetadata();

if (workflowMetadata != null && workflowMetadata.containsKey("income"))
    val = workflowMetadata.get("income");

return val;
}
}
```

## Testa på servern

>[!NOTE]
>
>Den här artikeln förutsätter att du har installerat [exempelarbetsflöde](assets/review-workflow.zip) och [exempelformulär](assets/snap-form.zip) från [föregående artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/inbox-customization/add-married-column.html) i den här serien.

* [Logga in som administratör](http://localhost:4502/crx/de/index.jsp)
* [importera enkel mall](assets/sightly-template.zip)
* [Logga in på AEM webbkonsol](http://localhost:4502/system/console/bundles)
* [Distribuera och starta anpassningspaketet för inkorgen](assets/income-column-customization.jar)
* [Öppna din inkorg](http://localhost:4502/aem/inbox)
* Öppna administrationskontrollen genom att klicka på listvyn bredvid knappen Skapa
* Lägg till resultatkolumn i Inkorgen och spara ändringarna
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/snapform/jcr:content?wcmmode=disabled)
* Välj _civilstånd_ och skicka in formuläret
* [Visa inkorg](http://localhost:4502/aem/inbox)

Om du skickar formuläret kommer arbetsflödet att utlösas och en uppgift tilldelas&quot;admin&quot;-användaren. Du bör se lämplig ikon under resultatkolumnen
