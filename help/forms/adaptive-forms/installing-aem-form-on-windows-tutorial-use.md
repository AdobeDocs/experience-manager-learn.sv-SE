---
title: Förenklade steg för installation av AEM Forms i Windows
description: Snabba och enkla steg för att installera AEM Forms i Windows
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Admin
level: Beginner
exl-id: 80288765-0b51-44a9-95d3-3bdb2da38615
last-substantial-update: 2020-06-09T00:00:00Z
duration: 113
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '545'
ht-degree: 0%

---

# Förenklade steg för installation av AEM Forms i Windows

>[!NOTE]
>
>Dubbelklicka aldrig på AEM snabbstartsburk om du tänker använda AEM Forms.
>
>Kontrollera också att det inte finns några blanksteg i sökvägen till installationsmappen för AEM Forms.
>
>Installera till exempel inte AEM Forms i mappen c:\jack and jill\AEM Forms

>[!NOTE]
>
>Om du installerar AEM Forms 6.5 ska du kontrollera att du har installerat följande 32-bitars omdistribuerbara Microsoft Visual C++.
>
>* Microsoft Visual C++ 2008 återdistribuerbar
>* Microsoft Visual C++ 2010 återdistribuerbar
>* Microsoft Visual C++ 2012 återdistribuerbar
>* Microsoft Visual C++ 2013 återdistribuerbar (från och med 6.5)

Vi rekommenderar att du följer den [officiella dokumentationen](https://helpx.adobe.com/experience-manager/6-3/forms/using/installing-configuring-aem-forms-osgi.html) för installation av AEM Forms. Följ de här stegen för att installera och konfigurera AEM Forms i Windows-miljö:

* Kontrollera att rätt JDK är installerat
   * AEM 6.2 du behöver: Oracle SE 8 JDK 1.8.x (64 bitar)
   * AEM 6.3 och AEM 6.4 du behöver: Oracle SE 8 JDK 1.8.x (64 bitar)
   * AEM 6.5 behöver JDK 8 eller JDK 11
   * [Officiella JDK-krav](https://experienceleague.adobe.com/docs/experience-manager-65/deploying/introduction/technical-requirements.html?lang=en) visas här
* Kontrollera att JAVA_HOME är inställt på att peka på den JDK som du har installerat.
   * Följ stegen nedan för att skapa variabeln JAVA_HOME i Windows:
      * Högerklicka på Den här datorn och välj Egenskaper
      * På fliken Avancerat väljer du Miljövariabler och skapar en ny systemvariabel som heter JAVA_HOME.
      * Ställ in variabelvärdet så att det pekar på JDK som är installerat på datorn. Till exempel c:\programfiler\java\jdk1.8.0_25

* Skapa en mapp med namnet AEMForms på C-enheten
* Leta reda på AEMQuickStart.Jar och flytta den till mappen AEMForms
* Kopiera filen license.properties till den här AEMForms-mappen
* Skapa en gruppfil med namnet&quot;StartAemForms.bat&quot; med följande innehåll:
   * `java -d64 -Xmx2048M -jar AEM_6.5_Quickstart.jar -gui`
      * Här är AEM_6.5_Quickstart.jar namnet på min AEM quickstart jar.
   * Du kan byta namn på behållaren till vilket namn som helst, men se till att namnet återspeglas i gruppfilen. Spara gruppfilen i mappen AEMForms.

* Öppna en ny kommandotolk och navigera till _c:\aemforms_.

* Kör filen StartAemForms.bat från kommandotolken.

* Du bör få en liten dialogruta med information om startförloppet.

* Öppna filen sling.properties när starten är klar. Detta finns i mappen c:\AEMForms\crx-quickstart\conf.

* Kopiera de följande två raderna längst ned i filen
   * **sling.bootdelegation.class.com.rsa.jsafe.provider.JsafeJCE=com.rsa.&#42;** **sling.bootdelegation.class.org.bouncycastle.jce.provider.BouncyCastleProvider=org.bouncycastle.&#42;**
* Dessa två egenskaper krävs för att dokumenttjänster ska fungera
* Spara filen sling.properties
* [Hämta lämpligt formulärtilläggspaket](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/forms-updates/aem-forms-releases.html?lang=en)
* Installera formulärtillägget i paketet med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp).
* När du har installerat add-on package måste du följa följande steg

   * **Kontrollera att alla paket är i aktivt läge. (Förutom för AEMFD-signaturpaket).**
   * **Det tar vanligtvis fem eller fler minuter för alla paket att aktiveras.**

   * **När alla paket är aktiva (förutom AEMFD-signaturpaketet) startar du om datorn för att slutföra AEM Forms-installationen**

## sun.util.calendar-paketet till tillåtelselista

1. Öppna Felix-webbkonsolen i ditt [webbläsarfönster](http://localhost:4502/system/console/configMgr)
1. Sök efter och öppna Firewall Configuration (Brandväggskonfiguration för deserialisering): `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl`
1. Lägg till `sun.util.calendar` som en ny post under `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl.firewall.deserialization.whitelist.name`
1. Spara ändringarna.

Grattis! Du har nu installerat och konfigurerat AEM Forms på datorn.
Beroende på dina behov kan du konfigurera [Reader Extensions](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/document-services/configuring-reader-extension-osgi.html) eller [PDFG](https://experienceleague.adobe.com/docs/experience-manager-65/forms/install-aem-forms/osgi-installation/install-configure-document-services.html) på servern
