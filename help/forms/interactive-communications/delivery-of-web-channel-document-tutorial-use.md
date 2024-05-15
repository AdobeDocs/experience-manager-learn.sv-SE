---
title: Delivery Interactive Communication Document - Web Channel AEM Forms
description: Skicka webbkanalsdokument via länk i e-post
feature: Interactive Communication
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
exl-id: 50858100-3d0c-42bd-87b8-f626212669e2
last-substantial-update: 2019-07-07T00:00:00Z
duration: 60
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '279'
ht-degree: 0%

---

# E-postleverans av webbkanalsdokument

När du har definierat och testat ett interaktivt webbkanalsdokument behöver du en leveransfunktion för att kunna leverera webbkanalsdokumentet till mottagaren.

I den här artikeln tittar vi på e-post som en leveransmekanism för dokument i webbkanaler. Mottagaren får en länk till webbkanalsdokumentet via e-post.När användaren klickar på länken ombeds han/hon att autentisera och webbkanalsdokumentet fylls i med data som är specifika för den inloggade användaren.

Låt oss titta på följande kodfragment. Den här koden är en del av GET.jsp som aktiveras när användaren klickar på länken i e-postmeddelandet för att visa webbkanalsdokumentet. Vi får den inloggade användaren med den schackanin UserManager. När vi får den inloggade användaren får vi värdet för egenskapen accountNumber som är associerad med användarens profil.

Sedan associerar vi värdet accountNumber med en nyckel som kallas kontonummer på kartan. Nyckeln **kontonummer** är definierad i formulärdata modal som ett Request Attribute. Värdet för det här attributet skickas som en indataparameter till lästjänstmetoden Form Data Modal.

Rad 7: Vi skickar den mottagna begäran till en annan server, baserat på den resurstyp som identifieras av URL:en för interaktivt kommunikationsdokument. Svaret som returneras av den här andra servern inkluderas i den första serverns svar.

```java
org.apache.jackrabbit.api.security.user.UserManager um = ((org.apache.jackrabbit.api.JackrabbitSession) session).getUserManager();
org.apache.jackrabbit.api.security.user.Authorizable loggedinUser = um.getAuthorizable(session.getUserID());
String accountNumber = loggedinUser.getProperty("profile/accountNumber")[0].getString();
map.put("accountnumber",accountNumber);
slingRequest.setAttribute("paramMap",map);
CustomParameterRequest wrapperRequest = new CustomParameterRequest(slingRequest,"GET");
wrapperRequest.getRequestDispatcher("/content/forms/af/401kstatement/irastatement/channels/web.html").include(wrapperRequest, response);
```

![Inkludera metod](assets/includemethod.jpg)

Visuell representation av rad 7-kod

![Parameterkonfiguration för begäran](assets/requestparameter.png)

Begärandeattribut definierat för lästjänsten för modala formulärdata

[AEM](assets/webchanneldelivery.zip).
