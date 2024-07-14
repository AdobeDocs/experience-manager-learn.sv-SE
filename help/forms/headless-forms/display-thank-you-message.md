---
title: Visa tackmeddelande när formulär skickas
description: Använd hanteraren onSubmitSuccess för att visa det konfigurerade tackmeddelandet i svarsappen
feature: Adaptive Forms
version: 6.5
jira: KT-13490
topic: Development
role: User
level: Intermediate
exl-id: 489970a6-1b05-4616-84e8-52b8c87edcda
duration: 61
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '171'
ht-degree: 0%

---

# Visa det konfigurerade tackmeddelandet

Ett tack för att du skickar in formulär är ett omtänksamt sätt att tacka användaren för att han/hon fyllt i och skickat in ett formulär. Det är en bekräftelse på att deras inlagor har tagits emot och uppskattats. Tacka-meddelandet har konfigurerats med fliken för att skicka i behållaren för den adaptiva formulärguiden

![tack-du-message](assets/thank-you-message.png)

Det konfigurerade tackmeddelandet finns i händelsehanteraren onSuccess för superkomponenten AdaptiveForm.
Koden för att associera onSuccess-händelsen och koden för onSuccess-händelsehanteraren visas nedan

```javascript
<AdaptiveForm mappings={extendMappings} onSubmitSuccess={onSuccess} formJson={selectedForm}/>
```

```javascript
const onSuccess=(action) =>{
        let body = action.payload?.body;
        debugger;
        setThankYouMessage(body.thankYouMessage.replace(/<(.|\n)*?>/g, ''));
        console.log("Thank you message "+body.thankYouMessage.replace(/<(.|\n)*?>/g, ''));

      }
```

Den fullständiga koden för kontaktfunktionskomponenten anges nedan

```javascript
import Form from './components/Form';
import PlainText from './components/plainText';
import TextField from './components/TextField';
import Button from './components/Button';
import { useState,useEffect } from "react";
import { AdaptiveForm } from "@aemforms/af-react-renderer";
export default function Contact(){
  
    const [selectedForm, setForm] = useState("");
    const [thankYouMessage, setThankYouMessage] = useState("");
    const [formSubmitted, setFormSubmitted] = useState(false);
  
    const extendMappings = {
        'plain-text' : PlainText,
        'text-input' : TextField,
        'button' : Button,
        'form': Form
      };
     const onSuccess=(action) =>{
        let body = action.payload?.body;
        debugger;
        setFormSubmitted(true);
        setThankYouMessage(body.thankYouMessage.replace(/<(.|\n)*?>/g, ''));
        // Remove any html tags in the thank you message
        console.log("Thank you message "+body.thankYouMessage.replace(/<(.|\n)*?>/g, ''));

      }
      
      const getForm = async () => {
        
        const resp = await fetch('/adobe/forms/af/L2NvbnRlbnQvZm9ybXMvYWYvY29udGFjdHVz');
        // Get the form id manually using the listform api
        let formJSON = await resp.json();
        setForm(formJSON.afModelDefinition)
      }
      useEffect( ()=>{
        getForm()
        

    },[]);
    
    return(
        
        <div>
           {!formSubmitted ?
            (
                <div>
                    <h1>Get in touch with us!!!!</h1>
                    <AdaptiveForm mappings={extendMappings} onSubmitSuccess={onSuccess} formJson={selectedForm}/>
                </div>
            ) :
            (
                <div>
                    <div>{thankYouMessage}</div>
                </div>
            )}
        </div>
      
          
        
    )
}
```

Ovanstående kod använder inbyggda HTML-komponenter som är mappade till de komponenter som används i det adaptiva formuläret. Vi mappar till exempel den anpassningsbara formulärkomponenten för textinmatning till TextField-komponenten. De inbyggda komponenterna som används i artikeln [kan hämtas härifrån](./assets/native-components.zip)
