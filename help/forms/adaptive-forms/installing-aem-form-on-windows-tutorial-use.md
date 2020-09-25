---
title: Förenklade steg för installation av AEM Forms i Windows
seo-title: Förenklade steg för installation av AEM Forms i Windows
description: Snabba och enkla steg för att installera AEM Forms i Windows
seo-description: Snabba och enkla steg för att installera AEM Forms i Windows
uuid: a148b8f0-83db-47f6-89d3-c8a9961be289
feature: adaptive-forms
topics: administration
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
discoiquuid: 1182ef4d-5838-433b-991d-e24ab805ae0e
translation-type: tm+mt
source-git-commit: 82127d5be9a4b969537738f9ba537efe07f38479
workflow-type: tm+mt
source-wordcount: '613'
ht-degree: 0%

---

# Förenklade steg för installation av AEM Forms i Windows

>[!NOTE]
>Dubbelklicka aldrig på AEM snabbstartsburk om du tänker använda AEM Forms.
>Kontrollera också att det inte finns några blanksteg i sökvägen till installationsmappen för AEM Forms.
>Installera till exempel inte AEM Forms i c:\jack and jill\AEM Forms folder

>[!NOTE]
Om du installerar AEM Forms 6.5 ska du kontrollera att du har installerat följande 32-bitars omdistribuerbara Microsoft Visual C++-filer.

* Microsoft Visual C++ 2008 återdistribuerbar
* Microsoft Visual C++ 2010 återdistribuerbar
* Microsoft Visual C++ 2012 återdistribuerbar
* Microsoft Visual C++ 2013 redistributable (från och med 6.5)

Vi rekommenderar att du följer den [officiella dokumentationen](https://helpx.adobe.com/experience-manager/6-3/forms/using/installing-configuring-aem-forms-osgi.html) för installation av AEM Forms. Följ de här stegen för att installera och konfigurera AEM Forms i Windows-miljö:

* Kontrollera att rätt JDK är installerat
   * AEM 6.2: Oracle SE 8 JDK 1.8.x (64 bitar)
* 
   * AEM 6.3 och AEM 6.4: Oracle SE 8 JDK 1.8.x (64 bitar)
* AEM 6.5 behöver du JDK 8 eller JDK 11
* [De officiella JDK-kraven](https://helpx.adobe.com/experience-manager/6-3/sites/deploying/using/technical-requirements.html) anges här
* Kontrollera att JAVA_HOME är inställt på att peka på den JDK som du har installerat.
   * Följ stegen nedan för att skapa variabeln JAVA_HOME i Windows:
      * Högerklicka på Den här datorn och välj Egenskaper
      * På fliken Avancerat väljer du Miljövariabler och skapar en ny systemvariabel som heter JAVA_HOME.
      * Ställ in variabelvärdet så att det pekar på JDK som är installerat på datorn. Till exempel c:\program files\java\jdk1.8.0_25

* Skapa en mapp med namnet AEMForms på C-enheten
* Leta reda på AEMQuickStart.Jar och flytta den till mappen AEMForms
* Kopiera filen license.properties till den här AEMForms-mappen
* Skapa en gruppfil med namnet&quot;StartAemForms.bat&quot; med följande innehåll:
   * java -d64 -Xmx2048M -jar AEM_6.3_Quickstart.jar -gui.Here AEM_6.3_Quickstart.jar is the name of my AEM quickstart jar.
   * Du kan byta namn på behållaren till vilket namn som helst, men se till att namnet återspeglas i gruppfilen.Spara gruppfilen i mappen AEMForms.

* Öppna en ny kommandotolk och gå till c:\aemforms.

* Kör filen StartAemForms.bat från kommandotolken.

* Du bör få en liten dialogruta med information om startförloppet.

* Öppna filen sling.properties när startproceduren är klar. Det här finns i c:\AEMForms\crx-quickstart\conf folder.

* Kopiera de följande två raderna längst ned i filen
   * **sling.bootdelegation.class.com.rsa.jsafe.provider.JsafeJCE=com.rsa.*** **sling.bootdelegation.class.org.bouncycastle.jce.provider.BouncyCastleProvider=org.bouncycastle.***
* Dessa två egenskaper krävs för att dokumenttjänster ska fungera
* Spara filen sling.properties

* [Logga in på paketresurs](http://localhost:4502/crx/packageshare/login.html)

   * Du måste ha AdobeId för att logga in på paketresursen
   * Sök efter AEM Forms Add on-paket som passar din version av AEM Forms och operativsystemet
   * Eller så kan [du ladda ned rätt formulärtilläggspaket](https://helpx.adobe.com/aem-forms/kb/aem-forms-releases.html)
   * När du har installerat add-on-paketet måste du följa följande steg

      * **Kontrollera att alla paket är i aktivt läge. (Förutom för AEMFD-signaturpaket).**
      * **Det tar vanligtvis fem eller fler minuter för alla paket att aktiveras.**
   * **När alla paket är aktiva (förutom AEMFD Signatures-paketet) startar du om datorn för att slutföra AEM Forms-installationen**


* Lägg till `sun.util.calendar` paketet i tillåtelselista:

   1. Öppna Felix webbkonsol i [webbläsarfönstret](http://localhost:4502/system/console/configMgr)
   2. Sök och öppna Firewall Configuration (Brandväggskonfiguration för deserialisering): `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl`
   3. Lägg till `sun.util.calendar` som ny post under `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl.firewall.deserialization.whitelist.name`
   4. Spara ändringarna.

Grattis! Du har nu installerat och konfigurerat AEM Forms på datorn.
Beroende på dina behov kan du konfigurera [Reader Extensions](https://helpx.adobe.com/experience-manager/6-3/forms/using/configuring-document-services.html) eller [ PDFG](https://helpx.adobe.com/experience-manager/6-3/forms/using/install-configure-pdf-generator.html) på servern
