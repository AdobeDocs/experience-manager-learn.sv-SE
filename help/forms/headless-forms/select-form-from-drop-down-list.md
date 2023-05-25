---
title: Välj ett formulär i en lista över tillgängliga formulär
description: Använd listforms-API för att fylla i listrutan
feature: Adaptive Forms
version: 6.5
kt: 13346
topic: Development
role: User
level: Intermediate
source-git-commit: 6aa3dff44a7e6f1f8ac896e30319958d84ecf57f
workflow-type: tm+mt
source-wordcount: '281'
ht-degree: 0%

---


# Välj ett formulär som ska fyllas i från en nedrullningsbar lista

Listrutor är ett kompakt och organiserat sätt att presentera en lista med alternativ för användarna. Objekten i den nedrullningsbara listan fylls i med resultaten från [listforms-API](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/List-Forms/operation/listForms)

![kortvy](./assets/forms-drop-down.png)

## Nedrullningsbar lista

Följande kod användes för att fylla i den nedrullningsbara listan med resultaten från API-anropet för listformulär. Beroende på vad användaren väljer visas det anpassade formuläret så att användaren kan fylla i och skicka det. [Material, UI-komponenter](https://mui.com/) har använts för att skapa det här gränssnittet

```javascript
import * as React from 'react';
import Form from './components/Form';
import PlainText from './components/plainText';
import TextField from './components/TextField';
import Button from './components/Button';
import Box from '@mui/material/Box';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select, { SelectChangeEvent } from '@mui/material/Select';
import { AdaptiveForm } from "@aemforms/af-react-renderer";

import { useState,useEffect } from "react";
export default function SelectFormFromDropDownList()
 {
    const extendMappings =
    {
        'plain-text' : PlainText,
        'text-input' : TextField,
        'button' : Button,
        'form': Form
    };

const[formPath, setFormPath] = useState('');
const[afForms,SetOptions] = useState([]);
const [selectedForm, setForm] = useState('');
const HandleChange = (event) =>
     {
        console.log("The path is "+event.target.value) 
    
        setFormPath(event.target.value)
        console.log("The formPath"+ formPath);
     };
const getForm = async () =>
     {
        const resp = await fetch(`${formPath}/jcr:content/guideContainer.model.json`);
        let formJSON = await resp.json();
        console.log(formJSON);
        setForm(formJSON);
     }
const getAFForms =async()=>
     {
        const response = await fetch("/adobe/forms/af/listforms")
        //let myresp = await response.status;
        let myForms = await response.json();
        console.log("Got response"+myForms.items[0].title);
        console.log(myForms.items)
        
        //setFormID('test');
        SetOptions(myForms.items)

        
     }
     useEffect( ()=>{
        getAFForms()
        

    },[]);
    useEffect( ()=>{
        getForm()
        

    },[formPath]);

  return (
    <Box sx={{ minWidth: 120 }}>
      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Please select the form</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          value={formPath}
          label="Please select a form"
          onChange={HandleChange}
          
        >
       {afForms.map((afForm,index) => (
    
        
          <MenuItem  key={index} value={afForm.path}>{afForm.title}</MenuItem>
        ))}
        
       
        </Select>
      </FormControl>
      <div><AdaptiveForm mappings={extendMappings} formJson={selectedForm}/></div>
    </Box>
    

  );
  

}
```

Följande två API-anrop användes när användargränssnittet skapades

* [ListForm](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/List-Forms/operation/listForms). Anropet om att hämta formulären görs bara en gång när komponenten återges. Resultatet av API-anropet lagras i afForms-variabeln.
I ovanstående kod itererar vi igenom afForms med hjälp av mappningsfunktionen och för varje objekt i afForms-arrayen skapas en MenuItem-komponent som läggs till i Select-komponenten.

* Hämta formulär - Ett get-anrop görs till följande slutpunkt, där formPath är sökvägen till det valda adaptiva formuläret av användaren i listrutan. Resultatet av det här GET-anropet lagras i selectedForm.

```
${formPath}/jcr:content/guideContainer.model.json`
```

* Visa det markerade formuläret. Följande kod användes för att visa det valda formuläret. Elementet AdaptiveForm finns i paketet aemforms/af-response-renderer npm och mappningarna och formJson förväntas som dess egenskaper

```
<div><AdaptiveForm mappings={extendMappings} formJson={selectedForm}/></div>
```

## Nästa steg

[Visa formulären i kortlayouten](./display-forms-card-view.md)



