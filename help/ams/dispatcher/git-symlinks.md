---
title: Lägga till Symlinks i GIT på rätt sätt
description: Instruktioner om hur och var du ska lägga till länkar när du arbetar med dina Dispatcher-konfigurationer.
version: 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 6e751586-e92e-482d-83ce-6fcae4c1102c
duration: 295
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1231'
ht-degree: 0%

---

# Lägga till symboler i GIT

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Dispatcher hälsokontroll](./health-check.md)

I AMS får du en färdigfylld GIT-databas som innehåller källkoden för din dispatcher och är klar att börja utveckla och anpassa.

När du har skapat din första `.vhost`-fil eller `farm.any`-fil på den översta nivån måste du skapa en symbolisk länk från katalogen `available_*` till katalogen `enabled_*`. Att använda rätt länktyp är avgörande för en lyckad driftsättning via Cloud Manager pipeline. På den här sidan får du hjälp att göra detta.

## Dispatcher Archetype

AEM utvecklare startar sitt projekt vanligtvis från [AEM-arkitypen](https://github.com/adobe/aem-project-archetype)

Här följer ett exempel på området i källkoden där du kan se de symboler som används:

```
$ tree dispatcher
dispatcher
└── src
   ├── conf.d
.....SNIP.....
    │   └── available_vhosts
    │   │   ├── 000_unhealthy_author.vhost
    │   │   ├── 000_unhealthy_publish.vhost
    │   │   ├── aem_author.vhost
    │   │   ├── aem_flush.vhost
    │   │   ├── aem_health.vhost
    │   │   ├── aem_lc.vhost
    │   │   └── aem_publish.vhost
    └── dispatcher_vhost.conf
    │   └── enabled_vhosts
    │   │   ├── aem_author.vhost -> ../available_vhosts/aem_author.vhost
    │   │   ├── aem_flush.vhost -> ../available_vhosts/aem_flush.vhost
    │   │   ├── aem_health.vhost -> ../available_vhosts/aem_health.vhost
    │   │   └── aem_publish.vhost -> ../available_vhosts/aem_publish.vhost
.....SNIP.....
    └── conf.dispatcher.d
    │   ├── available_farms
    │   │   ├── 000_ams_author_farm.any
    │   │   ├── 001_ams_lc_farm.any
    │   │   └── 002_ams_publish_farm.any
.....SNIP.....
    │   └── enabled_farms
    │   │   ├── 000_ams_author_farm.any -> ../available_farms/000_ams_author_farm.any
    │   │   └── 002_ams_publish_farm.any -> ../available_farms/002_ams_publish_farm.any
.....SNIP.....
17 directories, 60 files
```

Som exempel innehåller katalogen `/etc/httpd/conf.d/available_vhosts/` de mellanlagrade potentiella `.vhost`-filer som kan användas i konfigurationen som körs.

De aktiverade `.vhost`-filerna visas som en relativ sökväg `symlinks` i katalogen `/etc/httpd/conf.d/enabled_vhosts/`.

## Skapa en länk

Vi använder symboliska länkar till filen så att Apache Webserver hanterar målfilen som samma fil.  Vi vill inte duplicera filen i båda katalogerna.  I stället är det bara en genväg från en katalog (symbolisk länk) till en annan.

Känn igen att dina distribuerade konfigurationer har en Linux-värd som mål.  Om du skapar en länk som inte är kompatibel med målsystemet kommer det att leda till fel och oönskade resultat.

Om din arbetsstation inte är en Linux-dator kommer du antagligen att undra vilka kommandon som ska användas för att skapa länkarna på rätt sätt så att de kan implementera dem i GIT.

> `TIP:` Det är viktigt att använda relativa länkar eftersom länkarna fortfarande fungerar om du har installerat en lokal kopia av Apache Webserver och en annan installationsbas.  Om du använder en absolut sökväg måste arbetsstationen eller andra system matcha samma exakta katalogstruktur.

### OSX/Linux

Symbollänkar är inbyggda i dessa operativsystem och här är några exempel på hur du skapar länkarna.  Öppna ditt favoritterminalprogram och använd följande exempelkommandon för att skapa länken:

```
$ cd <LOCATION OF CLONED GIT REPO>\src\conf.d\enabled_vhosts
$ ln -s ../available_vhosts/<Destination File Name> <Target File Name>
```

Här följer ett ifyllt kommandoexempel för referens:

```
$ git clone https://github.com/adobe/aem-project-archetype.git
$ cd aem-project-archetype/src/main/archetype/dispatcher.ams/src/conf.d/enabled_vhosts/
$ ln -s ../available_vhosts/aem_flush.vhost aem_flush.vhost
```

Här är ett exempel på länken nu, om du listar filen med kommandot `ls`:

```
ls -l
total 0
lrwxrwxrwx. 1 root root 35 Oct 13 21:38 aem_flush.vhost -> ../available_vhosts/aem_flush.vhost
```

### Windows

> `Note:` Visar att MS Windows (bättre, NTFS) har stöd för symboliska länkar sedan.. Windows Vista!

![Bild av Windows-kommandotolken som visar hjälputdata för kommandot mklink](./assets/git-symlinks/windows-terminal-mklink.png)

> Kommandot `Warning:` mklink för att skapa symboler kräver administratörsbehörighet för att kunna köras korrekt. Även som ett administratörskonto måste du köra Kommandotolken &quot;Som administratör&quot; om inte utvecklarläget är aktiverat
> <br/>Felaktiga behörigheter:
> ![Bild av Windows-kommandotolken som visar att kommandot misslyckades på grund av behörighet ](./assets/git-symlinks/windows-mklink-underpriv.png)
> <br/>Rätt behörigheter:
> ![Bilden av Windows-kommandotolken kördes som administratör ](./assets/git-symlinks/windows-mklink-properpriv.png)

Här är kommandona som skapar länken:

```
C:\<PATH TO SRC>\enabled_vhosts> mklink <Target File Name> ..\available_vhosts\<Destination File Name>
```


Här följer ett ifyllt kommandoexempel för referens:

```
C:\> git clone https://github.com/adobe/aem-project-archetype.git
C:\> cd aem-project-archetype\src\main\archetype\dispatcher.ams\src\conf.d\enabled_vhosts\
C:\aem-project-archetype\src\main\archetype\dispatcher.ams\src\conf.d\enabled_vhosts> mklink aem_flush.vhost ..\available_vhost\aem_flush.vhost
symbolic link created for aem_flush.vhost <<===>> ..\available_vhosts\aem_flush.vhost
```

#### Utvecklarläge ( Windows 10 )

När du använder [Utvecklarläge](https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) kan du i Windows 10 enklare testa program som du utvecklar, använda Ubuntu Bash-gränssnittsmiljön, ändra en mängd inställningar för utvecklare och göra andra saker.

Microsoft verkar fortsätta lägga till funktioner i utvecklarläget, eller aktivera vissa av dessa funktioner som standard när de har blivit mer spridda och betraktas som stabila (t.ex. med Creators Update, Ubuntu Bash Shell-miljö behöver inte längre vara i utvecklarläget).

Symboler då? När utvecklarläget är aktiverat behöver du inte köra en kommandotolk med utökad behörighet för att kunna skapa symboler. När utvecklarläget är aktiverat kan alla användare därför skapa länkar.

> När du har aktiverat Developer Mode bör du logga ut/logga in för att ändringarna ska börja gälla.

Nu kan du se kommandot fungera utan att köra som administratör

![Bild av Windows-kommandotolken körs som en vanlig användare med utvecklarläge aktiverat](./assets/git-symlinks/windows-mklink-devmode.png)

#### Alternativ/programmatisk metod

Det finns en specifik princip som kan tillåta vissa användare att skapa symboliska länkar → [Skapa symboliska länkar (Windows 10) - Windows-säkerhet | Microsoft Docs](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/create-symbolic-links)

PRO:
- Detta kan utnyttjas av kunder för att programmatiskt tillåta att symboliska länkar skapas för alla utvecklare i deras organisation (t.ex. Active Directory) utan att behöva aktivera Developer Mode manuellt på varje enhet.
- Dessutom bör den här principen vara tillgänglig i tidigare versioner av MS Windows som inte har något utvecklarläge.

CON:
- Den här principen verkar inte ha någon effekt på användare som tillhör gruppen Administratörer. Administratörer måste fortfarande köra kommandotolken med förhöjd behörighet. Konstigt.

> Användarutloggning/inloggning krävs för att ändringarna av den lokala principen/gruppprincipen ska börja gälla.

Kör `gpedit.msc`, lägg till/ändra användare efter behov. Administratörer finns där som standard

![Fönstret Grupprincipredigerare visar behörighet att justera](./assets/git-symlinks/windows-localpolicies-symlinks.png)

#### Aktivera symboler i GIT

Git hanterar symboler enligt alternativet core.symlinks

Source: [Git - git-config-dokumentation](https://git-scm.com/docs/git-config#Documentation/git-config.txt-coresymlinks)

*Om core.symbollinks är false checkas symboliska länkar ut som små oformaterade filer som innehåller länktexten. `git-update-index[1]` och `git-add[1]` ändrar inte den inspelade typen till vanlig fil. Användbart i filsystem som FAT som inte stöder symboliska länkar.
Standardvärdet är true, förutom `git-clone[1]` eller `git-init[1] will probe and set core.symlinks false if appropriate when the repository is created.` I de flesta fall antar Git att Windows inte är bra för symboler och att det kommer att anges som false.*

Beteendet för Git i Windows förklaras här: Symboliska länkar ・ Git-for-windows/git Wiki ・ GitHub

> `Info`: Antagandena i den dokumentation som är länkad ovan verkar vara OK med en möjlig AEM Developer&#39;s Setup i Windows, framför allt NTFS, och det faktum att vi bara har filsymboler jämfört med katalogsymboler

Här är de goda nyheterna eftersom [Git för Windows version 2.10.2](https://github.com/git-for-windows/git/releases/tag/v2.10.2.windows.1) har installeraren ett [explicit alternativ för att aktivera stöd för symboliska länkar.](https://github.com/git-for-windows/git/issues/921)

> `Warning`: Alternativet core.symlink kan anges vid körning när databasen klonas, eller också kan det lagras som en global konfiguration.

![Visar GIT-installationsprogrammet med stöd för länkar](./assets/git-symlinks/windows-git-install-symlink.png)

Git för Windows lagrar globala inställningar i `"C:\Program Files\Git\etc\gitconfig"`. De här inställningarna kanske inte beaktas av andra Git-klientprogram.
Här är haken, alla utvecklare kommer inte att använda Git-klienten (t.ex. Git Cmd, Git Bash), och vissa av Git-skrivbordsapparna (t.ex. GitHub Desktop, Atlassian SourceTree) kan ha olika inställningar/standardinställningar för att använda System eller ett inbäddat Git

Här är ett exempel på vad som finns i filen `gitconfig`

```
[diff "astextplain"]
    textconv = astextplain
[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true
[http]
    sslBackend = openssl
    sslCAInfo = C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
[core]
    autocrlf = true
    fscache = true
    symlinks = true
[pull]
    rebase = false
[credential]
    helper = manager-core
[credential "https://dev.azure.com"]
    useHttpPath = true
[init]
    defaultBranch = master
```

#### Git-kommandoradstips

Det kan finnas scenarier där du måste skapa nya symboliska länkar (t.ex. lägga till en ny värd eller en ny servergrupp).

I dokumentationen ovan har vi sett att Windows erbjuder ett&quot;mklink&quot;-kommando för att skapa symboliska länkar.

Om du arbetar i en Git Bash-miljö kan du i stället använda standardkommandot Bash `ln -s`, men det måste föregås av en specialinstruktion som i exemplet här:

```
MSYS=winsymlinks:nativestrict ln -s test_vhost_symlink ../dispatcher/src/conf.d/available_vhosts/default.vhost
```

#### Sammanfattning

För att få Git-hanteringssymboler på rätt sätt (åtminstone för omfånget för den aktuella AEM dispatcher-konfigurationsbaslinjen) på ett Microsoft Windows-operativsystem behöver du:

| Objekt | Minsta version/konfiguration | Rekommenderad version/konfiguration |
|------|---------------------------------|-------------------------------------|
| Operativsystem | Windows Vista eller senare | Windows 10 Creator Update eller senare |
| Filsystem | NTFS | NTFS |
| Möjlighet att hantera symboler för Windows-användare | `"Create symbolic links"` grupp/lokal princip `under "Group Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment"` | Windows 10 Developer Mode är aktiverat |
| GIT | Inbyggd klientversion 1.5.3 | Inbyggd klientversion 2.10.2 eller senare |
| Git-konfiguration | Alternativet `--core.symlinks=true` vid Git-kloning från kommandoraden | Git global konfiguration <br/>`[core]`<br/>    symlinks = true <br/> Konfigurationssökväg för inbyggda Git-klienter: `C:\Program Files\Git\etc\gitconfig` <br/> Standardplats för Git Desktop-klienter: `%HOMEPATH%\.gitconfig` |

> `Note:` Om du redan har en lokal databas måste du klona om från början. Du kan klona till en ny plats och manuellt sammanfoga dina ej genomförda/ej mellanlagrade lokala ändringar i den nya klonade databasen.
