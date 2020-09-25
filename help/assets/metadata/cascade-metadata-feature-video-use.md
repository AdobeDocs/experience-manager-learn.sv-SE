---
title: Använda Cascading Metadata i AEM Assets
seo-title: Använda Cascading Metadata i AEM Assets
description: Med avancerad metadatahantering kan användare skapa överlappande fältregler för att skapa sammanhangsberoende relationer mellan metadata i AEM Assets. I videon nedan visas nya dynamiska regler för fältkrav, synlighet och sammanhangsberoende val. I videon finns även information om de steg som en administratör behöver för att tillämpa dessa regler på ett anpassat metadataschema.
seo-description: Med avancerad metadatahantering kan användare skapa överlappande fältregler för att skapa sammanhangsberoende relationer mellan metadata i AEM Assets. I videon nedan visas nya dynamiska regler för fältkrav, synlighet och sammanhangsberoende val. I videon finns även information om de steg som en administratör behöver för att tillämpa dessa regler på ett anpassat metadataschema.
uuid: 470c1b1a-f888-4c90-87d7-acfa9a5fa6b1
discoiquuid: ccd1acb1-bb7f-48c2-91e0-cccbeedad831
topics: metadata
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 67ca08bf386a217807da3755d46abed225050d02
workflow-type: tm+mt
source-wordcount: '318'
ht-degree: 0%

---


# Använda Cascading Metadata i AEM Assets{#using-cascading-metadata-in-aem-assets}

Med avancerad metadatahantering kan användare skapa överlappande fältregler för att skapa sammanhangsberoende relationer mellan metadata i AEM Assets. I videon nedan visas nya dynamiska regler för fältkrav, synlighet och sammanhangsberoende val. I videon finns även information om de steg som en administratör behöver för att tillämpa dessa regler på ett anpassat metadataschema.

>[!VIDEO](https://video.tv.adobe.com/v/20702/?quality=9&learn=on)

Det finns tre dynamiska regeluppsättningar som kan aktiveras för ett givet metadatafält:

1. **Krav** : ett fält kan dynamiskt markeras som obligatoriskt baserat på värdet i ett annat listrutefält.

2. **Synlighet** : fält kan alltid vara synliga eller bara synliga baserat på värdet i ett annat listrutefält.

3. **Alternativ** : (endast tillgängligt för listrutefält) filtrera de alternativ som visas för användaren baserat på det valda värdet för ett annat listrutefält.

>[!NOTE]
>
>Det går ENDAST att skapa regler som baseras på värdet/värdena i ett nedrullningsbart fält. Det går att använda alla tre regeluppsättningarna i samma metadatafält, men som en bra metod bör du göra varje regeluppsättning beroende av samma metadatalistruta.

Hämta [anpassat metadatapaket](assets/cascade-metadata-values-001.zip)

## Ytterligare resurser{#additional-resources}

Anpassat metadataschema skapades på: `/conf/global/settings/dam/adminui-extension/metadataschema/custom`. AEM nedan kommer att tillämpa ett anpassat schema för mappen: `/content/dam/we-retail/en/activities`:

