---
title: Konfigurera leverans av webbkanalsdokument
description: Det här är den sista delen i en flerstegskurs för att skapa ditt första interaktiva kommunikationsdokument. Här tittar vi på hur vi levererar webbkanalsdokument via e-post.
feature: Interactive Communication
doc-type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
discoiquuid: 1a7cf095-c5d8-4d92-a018-883cda76fe70
topic: Development
role: Developer
level: Beginner
exl-id: 510d1782-59b9-41a6-a071-a16170f2cd06
duration: 68
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '351'
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

## Test Email Delivery of Web Channel Document {#test-email-delivery-of-web-channel-document}

* [Installera exempelresurserna med pakethanteraren](assets/webchanneldelivery.zip)
* [Logga in på crx](http://localhost:4502/crx/de/index.jsp#)

* Navigera till /home/users

* Sök efter administratörsanvändare under användarens nod.

* Välj profilnoden för administratörsanvändaren.

* Skapa en egenskap med namnet &quot;accountNumber&quot;. Kontrollera att egenskapstypen är en sträng.

* Ange värdet för den här kontonummeregenskapen till &quot;3059827&quot;. Du kan ange det här värdet till valfritt slumptal som du vill.

* [Öppna getad.html](http://localhost:4502/content/getad.html)

* Koden som är associerad med denna URL hämtar kontonumret för den inloggade användaren. Kontonumret skickas sedan som begärandeattribut till FDM. FDM hämtar sedan data som är kopplade till det här kontonumret och fyller i webbkanalsdokumentet.

>[!NOTE]
>
>Ta en titt på filen **/apps/AEMForms/fetchad/GET.jsp** i crx. Kontrollera att strängvariabeln webChannelDocument pekar på en giltig kommunikationsdokumentsökväg.

## Nästa steg

[Konfigurera e-postleverans](../interactive-communications/delivery-of-web-channel-document-tutorial-use.md)