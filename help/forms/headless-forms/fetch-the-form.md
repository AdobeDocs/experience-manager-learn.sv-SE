---
title: Hämta JSON för det adaptiva formuläret som ska bäddas in
description: Använd API:t för att hämta json för det adaptiva formuläret
feature: Adaptive Forms
version: 6.5
kt: 13285
topic: Development
role: User
level: Intermediate
source-git-commit: 6aa3dff44a7e6f1f8ac896e30319958d84ecf57f
workflow-type: tm+mt
source-wordcount: '149'
ht-degree: 0%

---


# Hämta formulärets JSON

Logga in på din AEM Forms-författarinstans och skapa en ny adaptiv med **Tom med kärnkomponenter** mall. Publicera formuläret i din publiceringsinstans.

För att bädda in formuläret hämtar vi först jsonen för det adaptiva formuläret genom att ringa ett get-anrop till vår publiceringsserver.

Följande kodfragment hämtar json för det adaptiva formuläret som kallas **konturer**

```javascript
const getForm = async () => {
        const resp = await fetch('/content/forms/af/contactus/jcr:content/guideContainer.model.json');
        let formJSON = await resp.json();
        console.log(formJSON);
        setForm(formJSON);
      }
```

Den fullständiga koden för kontaktfunktionskomponenten anges nedan

```javascript
import Form from './components/Form';
import PlainText from './components/plainText';
import TextField from './components/TextField';
import Button from './components/Button';
import Panel from './components/Panel';
import { useState,useEffect } from "react";
import { AdaptiveForm } from "@aemforms/af-react-renderer";

export default function Contact(){
   const [selectedForm, setForm] = useState("");
   const extendMappings = {
        'plain-text' : PlainText,
        'text-input' : TextField,
        'button' : Button,
        'form': Form
      };
    const getForm = async () => {
        
        const resp = await fetch('/content/forms/af/contactus/jcr:content/guideContainer.model.json');
        let formJSON = await resp.json();
        console.log(formJSON);
        setForm(formJSON);
      }
      useEffect( ()=>{
        getForm();
        

    },[]);
    return(
        
        <div>
            <h1>Get in touch with us!!!!</h1>
            <AdaptiveForm mappings={extendMappings} formJson={selectedForm} />
      
          
        </div>
    )
}
```

Ovanstående kod använder inbyggda HTML-komponenter som är mappade till de komponenter som används i det adaptiva formuläret. Vi mappar till exempel den anpassningsbara formulärkomponenten för textinmatning till TextField-komponenten. De inbyggda komponenterna som används i artikeln [kan hämtas härifrån](./assets/native-components.zip)

## Nästa steg

[Välj ett formulär i listrutan](./select-form-from-drop-down-list.md)