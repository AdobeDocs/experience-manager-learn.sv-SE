---
title: Konfigurera IntelliJ med Repo-verktyget
description: Förbered IntelliJ för synkronisering med AEM molnklar instans
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
topic: Development
kt: 8844
source-git-commit: d42fd02b06429be1b847958f23f273cf842d3e1b
workflow-type: tm+mt
source-wordcount: '481'
ht-degree: 2%

---

# Installerar Cygwin

Installera [Cygwin](https://www.cygwin.com/). Jag har installerat i C:\cygwin64 folder
>[Anteckning]
> Kontrollera att du har installerat paket för zip, uppzip, bläddring och synkronisering med cygwin-installationen

[Installera repo-verktyget].(https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo).Installing) Repo-verktyget är inget annat än att kopiera repo-filen och placera den i din c:\cloudmanger\adoberepo folder.

Lägg till följande i miljövariabeln Path C:\cygwin64\bin;C:\CloudManager\adoberepo;

## Konfigurera externa verktyg

Starta IntelliJ Tryck på Ctrl+Alt+S för att öppna inställningsfönstret Välj Verktyg ->Externa verktyg och klicka sedan på +-tecknet och ange följande som visas på skärmbilden Se till att du skapar en grupp som heter repo genom att skriva &quot;repo&quot; i grupplistrutan och alla kommandon som du skapar tillhör **repa** grupp

**Placera kommando**
**Program**: C:\cygwin64\bin\bash
**Argument**: -l C:\CloudManager\adoberepo\repo put -f \$FilePath\$
**Arbetsflöde**: \$ProjectFileDir\$
![put-command](assets/put-command.png)

**Hämta kommando**
**Program**: C:\cygwin64\bin\bash
**Argument**: -l C:\CloudManager\adoberepo\repo get -f \$FilePath\$
**Arbetsflöde**: \$ProjectFileDir\$
![get-command](assets/get-command.png)

**Statuskommando**
**Program**: C:\cygwin64\bin\bash
**Argument**: -l C:\CloudManager\adoberepo\repo st -f \$FilePath\$
**Arbetsflöde**: \$ProjectFileDir\$
![status-command](assets/status-command.png)

**Diff-kommando**
**Program**: C:\cygwin64\bin\bash
**Argument**: -l C:\CloudManager\adoberepo\repo diff -f $FilePath$
**Arbetsflöde**: \$ProjectFileDir\$
![diff-command](assets/diff-command.png)

Extrahera .repo-filen från [repo.zip](assets/repo.zip) och placera den i AEM projektrotmapp. (C:\CloudManager\aem-banking-application). Öppna .repo-filen och kontrollera att server- och inloggningsinställningarna matchar din miljö.
Öppna .gitignore-filen och lägg till följande längst ned i filen och spara ändringarna \# repo .repo

Välj ett projekt i ett aem-Banking-applikationsprojekt, till exempel ui.content, och högerklicka så ser du repoalternativet och under repoalternativet ser du de fyra kommandona vi lade till tidigare.

## Konfigurera AEM Author Instance

Följande steg kan följas för att snabbt konfigurera en molnklar instans på ditt lokala system.
* [Ladda ned den senaste AEM SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)

* [Ladda ned den senaste AEM Forms-appen](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)

* Skapa följande mappstruktur c:\aemformscs\aem-sdk\author

* Extrahera filen aem-sdk-quickstart-xxxxxxx.jar från AEM SDK zip-filen och placera den i c:\aemformscs\aem-sdk\author folder.Rename filen jar till aem-author-p4502.jar

* Öppna kommandotolken och gå till c:\aemformscs\aem-sdk\author enter the following command java -jar aem-author-p4502.jar. Detta startar installationen av AEM.
* Logga in med inloggningsuppgifter för admin/admin
* Stoppa AEM
* Skapa följande mappstruktur.C:\aemformscs\aem-sdk\author\crx-quickstart\install
* Kopiera aem-forms-addon-xxxxxx.far till installationsmappen
* Öppna kommandotolken och gå till c:\aemformscs\aem-sdk\author enter the following command java -jar aem-author-p4502.jar. Detta distribuerar formulären som läggs till i paketet i AEM.



















