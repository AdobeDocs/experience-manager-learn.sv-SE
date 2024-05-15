---
title: Installera AEM Forms i Linux
description: Lär dig hur du installerar 32-bitars bibliotek så att AEM Forms kan användas vid Linux-installation.
feature: Adaptive Forms
type: Tutorial
version: 6.4, 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-7593
exl-id: b9809561-e9bd-4c67-bc18-5cab3e4aa138
last-substantial-update: 2019-06-09T00:00:00Z
duration: 204
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '938'
ht-degree: 0%

---

# Installera 32-bitarsversionen av delade bibliotek

När AEM FORMS OSGi eller AEM Forms j2EE distribueras i Linux måste du se till att 32-bitarsversioner av en uppsättning delade bibliotek är installerade och tillgängliga.  Beskrivningarna är hämtade från själva paketen.

* expat (Stream-Oriented XML parser C library for parsing XML, skrivet av James Clark)
* fontconfig (bibliotek för teckensnittskonfiguration och anpassning, utformat för att hitta teckensnitt i systemet och välja dem enligt de krav som anges av programmen)
* Freetype (motor för teckensnittsåtergivning) som utvecklats för att ge avancerat teckensnittsstöd för en rad olika plattformar och miljöer. Du kan öppna och hantera teckensnittsfiler samt läsa in, tipsa och återge enskilda tecken på ett effektivt sätt. Det är inte en teckensnittsserver eller ett komplett textåtergivningsbibliotek)
* glibc (Core-bibliotek för GNU-systemet och GNU/Linux-system, samt många andra system som använder Linux som kärna)
* libcurl (överföringsbibliotek för URL på klientsidan)
* libICE (Inter-Client Exchange Library)
* libicu (Library som ger robust och komplett funktionalitet för Unicode och språkinställningar - International Components for Unicode). Både 64- och 32-bitarsversionen av det här biblioteket krävs
* libSM (X11 Session Management Library)
* libuid (DCE-kompatibelt Universally Unique Identifier Library - används för att generera unika identifierare för objekt som kan nås utanför det lokala systemet)
* libX11 (X11-bibliotek på klientsidan)
* libXau (X11 Authorization Protocol - användbart för att begränsa klientåtkomst till skärmen)
* libxcb (X-protokoll C-language Binding - XCB)
* libXext (Bibliotek för vanliga tillägg till X11-protokollet)
* libXinerama (X11-tillägg som har stöd för att utöka en stationär dator över flera skärmar. Namnet heter Cinerama, ett widescreen-filmsformat med flera projektorer. libXtreama är biblioteket som interagerar med RandR-tillägget)
* libXrandr (tillägget Xinerama är i stort sett föråldrat nuförtiden - det har ersatts av tillägget RandR)
* libXrender (klientbibliotek för X Rendering Extension) nss-softokn-free (Freebl-bibliotek för Network Security Services)
* zlib (allmänt, patentfritt, förlustfritt datakomprimeringsbibliotek)

Från och med Red Hat Enterprise Linux 6 har 32-bitarsversionen av ett bibliotek filnamnstillägget .686 medan 64-bitarsversionen har .x86_64. Exempel: expat.i686. Före RHEL 6 hade 32-bitarsversionerna filnamnstillägget .i386. Innan du installerar 32-bitarsutgåvorna kontrollerar du att de senaste 64-bitarsutgåvorna är installerade. Om 64-bitarsversionen av ett bibliotek är äldre än den 32-bitarsversion som installeras visas ett felmeddelande enligt nedan:

0mError: Protected multilib versions: libsepol-2.5-10.el7.x86_64 != libsepol-2.5-6.el7.i686 [0mError: Versionsproblem för multilib hittades.]

## Första installationen

I Red Hat Enterprise Linux använder du YUM (YellowDog Update Modifier) för att installera enligt nedan:

1. yum install expat.i686
2. yum install fontconfig.i686
3. yum install freetype.i686
4. yum install glibc.i686
5. yum install libcurl.i686
6. yum install libICE.i686
7. yum install libicu.i686
8. yum install libicu
9. yum install libSM.i686
10. yum install libuuid.i686
11. yum install libX11.i686
12. yum install libXau.i686
13. yum install libxcb.i686
14. yum install libXext.i686
15. yum install libXinerama.i686
16. yum install libXrandr.i686
17. yum install libXrender.i686
18. yum install nss-softokn-free.i686
19. yum install zlib.i686

## Symlänkar

Dessutom måste du skapa symbolerna libcurl.so, libcrypto.so och libssl.so som pekar på de senaste 32-bitarsversionerna av biblioteken libcurl, libcrypto och libssl. Du hittar filerna i /usr/lib/libcurl.so.4.5.0 /usr/lib/libcurl.so ln -s /usr/lib/libcrypto.so.1.1.1c /usr/lib/libcrypto.so ln -s /usr/lib/libssl.so.1.1.1c /usr/lib/libssl.so

## Uppdateringar av befintligt system

Det kan finnas konflikter mellan x86_64- och i686-arkitekturer under uppdateringar, till exempel: Fel: Transaktionskontrollfel: fil /lib/ld-2.28.so från installation av glibc-2.28-72.el8.i686 står i konflikt med fil från paketet glibc32-2.28-2 42.1.el8.x86_64

Om du stöter på detta avinstallerar du först det felaktiga paketet, som i det här fallet: yum remove glibc32-2.28-42.1.el8.x86_64

Allt detta är klart och du vill att versionerna x86_64 och i686 ska vara exakt desamma, som till exempel den här utskriften till kommandot: yum info glibc

Senaste kontroll av förfallodatum för metadata: 0:41:För 33 år sedan den 18 januari 2020 11:37:08 EST.
Namn på installerade paket: glibc Version : 2.28 Release : 72.el8 Architecture : i686 Size : 13 M Source : glibc-2.28-72.el8.src.rpm Repository : @System From repo : BaseOS Summary : The GNU libc libraries URL : http://www.gnu.org/software/glibc/ License : LGPL v2+ och LGPLv2+ med undantag och GPLv2+ och GPLv2+ med undantag samt BSD och Inner-Net och ISC och Public Domain och GFDL Description: Glibc-paketet innehåller standardbibliotek som används av : flera program i systemet. För att spara diskutrymme och : minne, samt för att underlätta uppgraderingen, finns en gemensam systemkod: som lagras på ett ställe och som delas mellan program. Det här paketet innehåller de viktigaste uppsättningarna med delade bibliotek: standardbiblioteket C : och standardbiblioteket för matematik. Utan dessa två bibliotek fungerar inte a: Linux-systemet.

Namn : glibc Version : 2.28 Release : 72.el8 Architecture : x86_64 Size : 15 M Source : glibc-2.28-72.el8.src.rpm Repository : @System From repo : BaseOS Summary : GNU libc libraries URL : http://www.gnu.org/software/glibc/ License : LGPLv 2+ och LGPLv2+ med undantag och GPLv2+ och GPLv2+ med undantag samt BSD och Inner-Net och ISC och Public Domain och GFDL Description: Glibc-paketet innehåller standardbibliotek som används av : flera program i systemet. För att spara diskutrymme och : minne, samt för att underlätta uppgraderingen, finns en gemensam systemkod: som lagras på ett ställe och som delas mellan program. Det här paketet innehåller de viktigaste uppsättningarna med delade bibliotek: standardbiblioteket C : och standardbiblioteket för matematik. Utan dessa två bibliotek fungerar inte a: Linux-systemet.

## Några praktiska yum-kommandon

yumlista installerad yumsökning [part_of_package_name]
yum what [package_name]
yum-installation [package_name]
ominstallation [package_name]
yum info [package_name]
yum deplist [package_name]
yumborttagning [package_name]
yum check-update [package_name]
yumuppdatering [package_name]
