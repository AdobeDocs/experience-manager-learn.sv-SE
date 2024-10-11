---
title: Använda formatsystem i AEM Forms
description: Definiera CSS-klasserna för variationerna
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16276
source-git-commit: 86d282b426402c9ad6be84e9db92598d0dc54f85
workflow-type: tm+mt
source-wordcount: '245'
ht-degree: 0%

---

# Skapa varianter för knappkomponenten

När temat har klonats öppnar du projektet med visuell studiokod. Du bör se en liknande vy
i visuell studiokod
![projektutforskaren](assets/easel-theme.png)

Öppna src->components->button->_button.scss-filen. Vi ska definiera våra anpassade variationer i den här filen.

## Företagsvariation

```css
.cmp-adaptiveform-button-corporate {
  @include container;
  .cmp-adaptiveform-button {
    &__widget {
      @include primary-button;
      background: $brand-red;
      text-transform: uppercase;
      border-radius: 0px;
      color: yellow;
    }
  }
}
```

## Förklaring

* **cmp-adaptiveform-button—corporate**: Detta är huvudwrapper- eller behållarklassen för komponenten &quot;cmp-adaptiveform-button—corporate&quot;.
Alla format och blandningar i det här blocket gäller för element i den här klassen.
* **@include-behållare**: Detta använder en blandning med namnet container, som definieras i _mixins.scss. Blandbehållaren använder vanligtvis layoutrelaterade format som marginaler, utfyllnad eller andra strukturella format för att säkerställa att behållaren fungerar på ett konsekvent sätt.
* **.cmp-adaptiveform-button**: I blocket corporate-style-button anger du det underordnade elementet som mål med klassen .cmp-adaptiveform-button.
* **&amp;__widget**: &amp;-symbolen refererar till den överordnade väljaren, som i det här fallet är .cmp-adaptiveform-button.
Det innebär att den sista klassen som anges som mål är .cmp-adaptiveform-button_widget, en BEM-klass (Block Element Modifier) som representerar en underkomponent (elementet __widget) inuti .cmp-adaptiveform-button-blocket.
* **@include primär knapp**: Detta inkluderar en primärknappsblandning som definieras i _mixin.scss och lägger till format som är relaterade till knappen (till exempel utfyllnad, färger, hovringseffekter osv.). Egenskaperna background,text-transform,border-radius,color som definieras i mixin-primärknappen åsidosätts.

Filen _mixins.scss definieras under src->site så som visas på skärmbilden nedan

![mixin.scss](assets/mixins.png)

## Marknadsföringsvariation

```css
.cmp-adaptiveform-button--marketing {
  
  @include container;
  .cmp-adaptiveform-button {
  &__widget {
    @include primary-button;
    background-color: #3498db;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 50px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: all 0.3s ease;
    outline: none;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    &:hover:not([disabled]) {
      position: relative;
      scale: 102%;
      transition: box-shadow 0.1s ease-out, transform 0.1s ease-out;
      background-color: #2980b9;
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
      transform: translateY(-3px);
    }
  }
}
  
}
```

## Nästa steg

[Testa variationerna](./build.md)


