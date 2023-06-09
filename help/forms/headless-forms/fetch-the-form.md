---
title: Hämta JSON för det adaptiva formuläret som ska bäddas in
description: Använd API:t för att hämta json för det adaptiva formuläret
feature: Adaptive Forms
version: 6.5
kt: 13285
topic: Development
role: User
level: Intermediate
exl-id: 5953a1ad-0eaf-43f0-b356-6d20c0b59fee
source-git-commit: 529e98269a08431152686202a8a2890712b9c835
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---

# Hämta formulärets JSON

Logga in på din AEM Forms-författarinstans och skapa en ny adaptiv med **Tom med kärnkomponenter** mall. Publicera formuläret i din publiceringsinstans.

För att bädda in formuläret hämtar vi först jsonen för det adaptiva formuläret genom att ringa ett get-anrop till vår publiceringsserver.

Följande kodfragment hämtar json för det adaptiva formuläret som kallas **konturer**

```javascript
const getForm = async () => {
        
        const resp = await fetch('/adobe/forms/af/L2NvbnRlbnQvZm9ybXMvYWYvZmlyc3RoZWFkbGVzcw==');
        // Get the form id manually using the listform api
        let formJSON = await resp.json();
        console.log("The contact form json is "+formJSON);
        setForm(formJSON.afModelDefinition)
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
        
        const resp = await fetch('/adobe/forms/af/dor/L2NvbnRlbnQvZm9ybXMvYWYvcmlzaGk=');
        let formJSON = await resp.json();
        setForm(formJSON.afModelDefinition)
      
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
