---
title: Förenklade steg för installation av AEM Forms i Windows
description: Snabba och enkla steg för att installera AEM Forms i Windows
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
topic: Development
role: Admin
level: Beginner
exl-id: 80288765-0b51-44a9-95d3-3bdb2da38615
source-git-commit: 09f6c4b0bec10edd306270a7416fcaff8a584e76
workflow-type: tm+mt
source-wordcount: '578'
ht-degree: 0%

---

# Förenklade steg för installation av AEM Forms i Windows

>[!NOTE]
>
>Dubbelklicka aldrig på AEM snabbstartsburk om du tänker använda AEM Forms.
>
>Kontrollera också att det inte finns några blanksteg i sökvägen till installationsmappen för AEM Forms.
>
>Installera till exempel inte AEM Forms i c:\jack and jill\AEM Forms folder

>[!NOTE]
>
>Om du installerar AEM Forms 6.5 ska du kontrollera att du har installerat följande 32-bitars omdistribuerbara Microsoft Visual C++.
>
>* Microsoft Visual C++ 2008 återdistribuerbar
>* Microsoft Visual C++ 2010 återdistribuerbar
>* Microsoft Visual C++ 2012 återdistribuerbar
>* Microsoft Visual C++ 2013 återdistribuerbar (från och med 6.5)


Vi rekommenderar att du följer [officiell dokumentation](https://helpx.adobe.com/experience-manager/6-3/forms/using/installing-configuring-aem-forms-osgi.html) för installation av AEM Forms. Följ de här stegen för att installera och konfigurera AEM Forms i Windows-miljö:

* Kontrollera att rätt JDK är installerat
   * AEM 6.2: Oracle SE 8 JDK 1.8.x (64 bitar)
* 
   * AEM 6.3 och AEM 6.4: Oracle SE 8 JDK 1.8.x (64 bitar)
* AEM 6.5 behöver du JDK 8 eller JDK 11
* [Officiella JDK-krav](https://experienceleague.adobe.com/docs/experience-manager-65/deploying/introduction/technical-requirements.html?lang=en) anges här
* Kontrollera att JAVA_HOME är inställt på att peka på den JDK som du har installerat.
   * Följ stegen nedan för att skapa variabeln JAVA_HOME i Windows:
      * Högerklicka på Den här datorn och välj Egenskaper
      * På fliken Avancerat väljer du Miljövariabler och skapar en ny systemvariabel som heter JAVA_HOME.
      * Ställ in variabelvärdet så att det pekar på JDK som är installerat på datorn. Till exempel c:\program files\java\jdk1.8.0_25

* Skapa en mapp med namnet AEMForms på C-enheten
* Leta reda på AEMQuickStart.Jar och flytta den till mappen AEMForms
* Kopiera filen license.properties till den här AEMForms-mappen
* Skapa en gruppfil med namnet&quot;StartAemForms.bat&quot; med följande innehåll:
   * `java -d64 -Xmx2048M -jar AEM_6.5_Quickstart.jar -gui`
      * Här AEM_6.5_Quickstart.jar är namnet på min AEM snabbrubb.
   * Du kan byta namn på behållaren till vilket namn som helst, men se till att namnet återspeglas i gruppfilen. Spara gruppfilen i mappen AEMForms.

* Öppna en ny kommandotolk och navigera till _c:\aemforms_.

* Kör filen StartAemForms.bat från kommandotolken.

* Du bör få en liten dialogruta med information om startförloppet.

* Öppna filen sling.properties när starten är klar. Det här finns i c:\AEMForms\crx-quickstart\conf folder.

* Kopiera de följande två raderna längst ned i filen
   * **sling.bootdelegation.class.com.rsa.jsafe.provider.JsafeJCE=com.rsa.&#42;** **sling.bootdelegation.class.org.bouncycastle.jce.provider.BouncyCastleProvider=org.bouncycastle.&#42;**
* Dessa två egenskaper krävs för att dokumenttjänster ska fungera
* Spara filen sling.properties
* [Ladda ned ett formulärtilläggspaket](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/forms-updates/aem-forms-releases.html?lang=en)
* Installera formulären som läggs till i paketet med [pakethanteraren.](http://localhost:4502/crx/packmgr/index.jsp)
* När du har installerat add-on package måste du följa följande steg

       **Kontrollera att alla paket är i aktivt läge. (Förutom för AEMFD-signaturpaket).**
       **Det tar normalt fem minuter för alla paket att aktiveras.**
   
   * **När alla paket är aktiva (förutom AEMFD Signatures-paketet) startar du om datorn för att slutföra AEM Forms-installationen**

## sun.util.calendar-paketet till tillåtelselista

1. Öppna Felix webbkonsol i din [webbläsarfönster](http://localhost:4502/system/console/configMgr)
2. Sök och öppna Firewall Configuration (Brandväggskonfiguration för deserialisering): `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl`
3. Lägg till `sun.util.calendar` som ny post under `com.adobe.cq.deserfw.impl.DeserializationFirewallImpl.firewall.deserialization.whitelist.name`
4. Spara ändringarna.

Grattis! Du har nu installerat och konfigurerat AEM Forms på datorn.
Beroende på dina behov kan du konfigurera  [Reader Extensions](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/document-services/configuring-reader-extension-osgi.html?lang=en) eller [ PDFG](https://experienceleague.adobe.com/docs/experience-manager-64/forms/install-aem-forms/osgi-installation/install-configure-document-services.html?lang=en) på servern
