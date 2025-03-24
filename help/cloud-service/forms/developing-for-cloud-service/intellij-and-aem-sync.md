---
title: Konfigurera IntelliJ med Repo-verktyget
description: Förbered IntelliJ för synkronisering med AEM molnklar instans
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
jira: KT-8844
exl-id: 9a7ed792-ca0d-458f-b8dd-9129aba37df6
duration: 92
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '501'
ht-degree: 0%

---

# Installerar Cygwin


Cygwin är en POSIX-kompatibel programmerings- och körningsmiljö som kan köras i Microsoft Windows.
Installera [Cygwin](https://www.cygwin.com/). Jag har installerat i mappen C:\cygwin64
>[!NOTE]
> Kontrollera att du har installerat paket för zip, uppzip, bläddring och synkronisering med cygwin-installationen

Skapa en mapp med namnet adoberepo under c:\cloudmanager.

[Installera repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo) Att installera repo-verktyget är ingenting annat än att kopiera repo-filen och placera den i mappen c:\cloudmanger\adoberepo.

Lägg till följande i miljövariabeln Path C:\cygwin64\bin;C:\CloudManager\adoberepo;

## Konfigurera externa verktyg

* Starta IntelliJ
* Tryck på Ctrl+Alt+S för att öppna inställningsfönstret.
* Välj Verktyg ->Externa verktyg och klicka sedan på plustecknet (+) och ange följande som visas på skärmbilden.
  ![rep](assets/repo.png)
* Se till att du skapar en grupp med namnet repo genom att skriva&quot;repo&quot; i listrutan Grupp och alla kommandon du skapar tillhör gruppen **repo**


**Skicka kommando**
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

Extrahera .repo-filen från [repo.zip](assets/repo.zip) och placera den i AEM-projektens rotmapp. (C:\CloudManager\aem-banking-application). Öppna .repo-filen och kontrollera att server- och inloggningsinställningarna matchar din miljö.
Öppna .gitignore-filen och lägg till följande längst ned i filen och spara ändringarna
\# repo
.repo

Välj ett projekt i ett aem-Banking-applikationsprojekt, till exempel ui.content, och högerklicka så ser du repoalternativet och under repoalternativet ser du de fyra kommandona vi lade till tidigare.

## Konfigurera AEM Author Instance{#set-up-aem-author-instance}

Följande steg kan följas för att snabbt konfigurera en molnklar instans på ditt lokala system.
* [Hämta den senaste versionen av AEM SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)

* [Ladda ned den senaste AEM Forms-appen](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)

* Skapa följande mappstruktur
c:\aemformscs\aem-sdk\author

* Extrahera filen aem-sdk-quickstart-xxxxxxx.jar från filen AEM SDK zip och placera den i mappen c:\aemformscs\aem-sdk\author.Byt namn på filen jar till aem-author-p4502.jar

* Öppna kommandotolken och gå till \aemformscs\aem-sdk\author
Ange följande kommando java -jar aem-author-p4502.jar -gui. Detta startar installationen av AEM.
* Logga in med administratörs-/administratörsbehörighet
* Stoppa AEM-instansen
* Skapa följande mappstruktur.C:\aemformscs\aem-sdk\author\crx-quickstart\install
* Kopiera aem-forms-addon-xxxxxx.far till installationsmappen
* Öppna kommandotolken och gå till \aemformscs\aem-sdk\author
Ange följande kommando java -jar aem-author-p4502.jar -gui. Då distribueras de formulär som läggs till i paketet i din AEM-instans.

## Nästa steg

[Synkronisera formulär och mallar från AEM med AEM-projekt](./deploy-your-first-form.md)
