---
title: Konfigurera IntelliJ med Repo-verktyget
description: Förbered IntelliJ för synkronisering med AEM molnklar instans
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
kt: 8844
exl-id: 9a7ed792-ca0d-458f-b8dd-9129aba37df6
source-git-commit: 307ed6cd25d5be1e54145406b206a78ec878d548
workflow-type: tm+mt
source-wordcount: '504'
ht-degree: 2%

---

# Installerar Cygwin


Cygwin är en POSIX-kompatibel programmerings- och körningsmiljö som kan köras i Microsoft Windows.
Installera [Cygwin](https://www.cygwin.com/). Jag har installerat i C:\cygwin64 folder
>[!NOTE]
> Kontrollera att du har installerat paket för zip, uppzip, bläddring och synkronisering med cygwin-installationen

Skapa en mapp med namnet adoberepo under c:\cloudmanager.

[Installera repo-verktyget].(https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo).Installing) Repo-verktyget är inget annat än att kopiera repo-filen och placera den i din c:\cloudmanger\adoberepo folder.

Lägg till följande i miljövariabeln Path C:\cygwin64\bin;C:\CloudManager\adoberepo;

## Konfigurera externa verktyg

* Starta IntelliJ
* Tryck på Ctrl+Alt+S för att öppna inställningsfönstret.
* Välj Verktyg ->Externa verktyg och klicka sedan på plustecknet (+) och ange följande som visas på skärmbilden.
   ![rep](assets/repo.png)
* Se till att du skapar en grupp med namnet repo genom att skriva&quot;repo&quot; i listrutan Grupp och alla kommandon du skapar tillhör **repa** grupp


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
* Logga in med inloggningsinformation för admin/admin
* Stoppa AEM
* Skapa följande mappstruktur.C:\aemformscs\aem-sdk\author\crx-quickstart\install
* Kopiera aem-forms-addon-xxxxxx.far till installationsmappen
* Öppna kommandotolken och gå till c:\aemformscs\aem-sdk\author enter the following command java -jar aem-author-p4502.jar. Detta distribuerar formulären som läggs till i paketet i AEM.
