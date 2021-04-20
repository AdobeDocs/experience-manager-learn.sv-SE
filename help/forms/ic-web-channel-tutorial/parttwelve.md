---
title: Konfigurera leverans av webbkanalsdokument
seo-title: Konfigurera leverans av webbkanalsdokument
description: Det här är den sista delen i en flerstegskurs för att skapa ditt första interaktiva kommunikationsdokument. Här tittar vi på hur vi levererar webbkanalsdokument via e-post.
seo-description: Det här är den sista delen i en flerstegskurs för att skapa ditt första interaktiva kommunikationsdokument. Här tittar vi på hur vi levererar webbkanalsdokument via e-post.
uuid: c1066600-1abd-4401-b04f-b93c28603cc7
feature: Interactive Communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 1a7cf095-c5d8-4d92-a018-883cda76fe70
topic: Development
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '394'
ht-degree: 0%

---


# Konfigurera leverans av webbkanalsdokument {#setting-up-the-delivery-of-web-channel-document}


Här tittar vi på hur vi levererar webbkanalsdokument via e-post.

När du har definierat och testat ett interaktivt webbkanalsdokument behöver du en leveransfunktion för att kunna leverera webbkanalsdokumentet till mottagaren.

För att kunna använda e-post som en leveransmekanism för vårt webbkanalsdokument måste vi göra en mindre ändring av formulärdatamodellen.

[Läs mer om webbkanalsleverans via e-post](/help/forms/interactive-communications/delivery-of-web-channel-document-tutorial-use.md)

Logga in på AEM Forms.

* Navigera till Forms ->Dataintegrering

* Öppna datamodellen RetirementAccountStatement i redigeringsläge.

* Markera saldoobjektet och klicka på redigeringsknappen.

* Välj pennikonen för att öppna id-argumentet i redigeringsläget.

* Ändra bindningen till RequestAttribute.

* Ange kontonumret i bindningsvärdet enligt nedan.

* På det här sättet skickar vi kontonumret via attributet request till formulärdatamodellen

* Se till att du sparar ändringarna.
   ![fdm](assets/requestattribute.gif)

## Testa e-postleverans av webbkanalsdokument {#test-email-delivery-of-web-channel-document}

* [Installera exempelresurserna med pakethanteraren](assets/webchanneldelivery.zip)
* [Logga in på crx](http://localhost:4502/crx/de/index.jsp#)

* Navigera till /home/users

* Sök efter administratörsanvändare under användarens nod.

* Välj profilnoden för administratörsanvändaren.

* Skapa en egenskap med namnet &quot;accountNumber&quot;. Kontrollera att egenskapstypen är en sträng.

* Ange värdet för den här kontonummeregenskapen till &quot;3059827&quot;. Du kan ange det här värdet till valfritt slumptal.

* [Öppna getad.html](http://localhost:4502/content/getad.html)

* Koden som är associerad med denna URL hämtar kontonumret för den inloggade användaren. Kontonumret skickas sedan som begärandeattribut till FDM. FDM hämtar sedan data som är kopplade till det här kontonumret och fyller i webbkanalsdokumentet.

>[!NOTE]
>
>Ta en titt på filen **/apps/AEMForms/fetchad/GET.jsp** i crx. Kontrollera att strängvariabeln webChannelDocument pekar på en giltig kommunikationsdokumentsökväg.
