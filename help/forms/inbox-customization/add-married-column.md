---
title: Lägg till anpassade kolumner
description: Lägg till anpassade kolumner för att visa ytterligare data i arbetsflödet
feature: Adaptive Forms
doc-type: article
version: 6.5
jira: KT-5830
topic: Development
role: Developer
level: Experienced
exl-id: 0b141b37-6041-4f87-bd50-dade8c0fee7d
duration: 75
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '276'
ht-degree: 0%

---

# Lägg till anpassade kolumner

Om du vill visa arbetsflödesdata i en inkorg måste vi definiera och fylla i variabler i arbetsflödet. Värdet för variabeln måste anges innan en uppgift tilldelas en användare. Vi har tagit fram ett exempelarbetsflöde som är klart att distribueras på AEM.

* [Logga in på AEM](http://localhost:4502/crx/de/index.jsp)
* [Importera granskningsarbetsflödet](assets/review-workflow.zip)
* [Granska arbetsflödet](http://localhost:4502/editor.html/conf/global/settings/workflow/models/reviewworkflow.html)

Det här arbetsflödet har två definierade variabler (isGift och Inkomst) och dess värden ställs in med den angivna variabelkomponenten. Dessa variabler är tillgängliga som kolumner som ska läggas till i AEM inkorg

## Skapa tjänst

För varje kolumn som vi måste visa i vår inkorg måste vi skriva en tjänst. Med följande tjänst kan vi lägga till en kolumn som visar värdet för variabeln isMarry

```java
import com.adobe.cq.inbox.ui.column.Column;
import com.adobe.cq.inbox.ui.column.provider.ColumnProvider;

import com.adobe.cq.inbox.ui.InboxItem;
import org.osgi.service.component.annotations.Component;

import java.util.Map;

/**
 * This provider does not require any sightly template to be defined.
 * It is used to display the value of 'ismarried' workflow variable as a column in inbox
 */
@Component(service = ColumnProvider.class, immediate = true)
public class MaritalStatusProvider implements ColumnProvider {@Override
public Column getColumn() {
return new Column("married", "Married", Boolean.class.getName());
}

// Return True or False if 'ismarried' is set. Else returns null
private Boolean isMarried(InboxItem inboxItem) {
Boolean ismarried = null;

Map metaDataMap = inboxItem.getWorkflowMetadata();
if (metaDataMap != null) {
if (metaDataMap.containsKey("isMarried")) {
    ismarried = (Boolean) metaDataMap.get("isMarried");
}
}

return ismarried;
}

@Override
public Object getValue(InboxItem inboxItem) {
return isMarried(inboxItem);
}
}
```

>[!NOTE]
>
>Du måste inkludera AEM 6.5.5 Uber.jar i projektet för att ovanstående kod ska fungera

![uber-jar](assets/uber-jar.PNG)

## Testa på servern

* [Logga in på AEM webbkonsol](http://localhost:4502/system/console/bundles)
* [Distribuera och starta anpassningspaketet för inkorgen](assets/inboxcustomization.inboxcustomization.core-1.0-SNAPSHOT.jar)
* [Öppna din inkorg](http://localhost:4502/aem/inbox)
* Öppna administrationskontrollen genom att klicka på _Listvy_ ikon bredvid _Skapa_ knapp
* Lägg till en gift kolumn i Inkorgen och spara ändringarna
* [Gå till användargränssnittet för FormsAndDocuments](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Importera exempelformuläret](assets/snap-form.zip) genom att välja _Filöverföring_ från _Skapa_ meny
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/snapform/jcr:content?wcmmode=disabled)
* Välj _civilstånd_ och skicka in formuläret
  [visa inkorg](http://localhost:4502/aem/inbox)

Om du skickar formuläret kommer arbetsflödet att utlösas och en uppgift tilldelas&quot;admin&quot;-användaren. Du bör se ett värde under kolumnen Gift, vilket visas i skärmbilden

![gift-kolumn](assets/married-column.PNG)

## Nästa steg

[Visa gift kolumn](./use-sightly-template.md)
