---
title: Välj ett formulär i en lista över tillgängliga formulär
description: Använd listforms-API för att fylla i listrutan
feature: Adaptive Forms
version: 6.5
jira: KT-13346
topic: Development
role: User
level: Intermediate
exl-id: 49b6a172-8c96-4fc6-8d31-c2109f65faac
duration: 91
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '266'
ht-degree: 0%

---

# Välj ett formulär som ska fyllas i från en nedrullningsbar lista

Listrutor är ett kompakt och organiserat sätt att presentera en lista med alternativ för användarna. Objekten i den nedrullningsbara listan fylls i med resultaten från [listforms-API](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/List-Forms/operation/listForms)

![kortvy](./assets/forms-drop-down.png)

## Listruta

Följande kod användes för att fylla i den nedrullningsbara listan med resultaten från API-anropet för listformulär. Beroende på vad användaren väljer visas det anpassade formuläret så att användaren kan fylla i och skicka det. [Material, UI-komponenter](https://mui.com/) har använts för att skapa gränssnittet

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

const[formID, setFormID] = useState('');
const[afForms,SetOptions] = useState([]);
const [selectedForm, setForm] = useState('');
const HandleChange = (event) =>
     {
        console.log("The form id is "+event.target.value) 
    
        setFormID(event.target.value)
        
     };
const getForm = async () =>
     {
        
        console.log("The formID in getForm"+ formID);
        const resp = await fetch(`/adobe/forms/af/${formID}`);
        let formJSON = await resp.json();
        console.log(formJSON.afModelDefinition);
        setForm(formJSON.afModelDefinition);
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
        

    },[formID]);

  return (
    <Box sx={{ minWidth: 120 }}>
      <FormControl fullWidth>
        <InputLabel id="demo-simple-select-label">Please select the form</InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          value={formID}
          label="Please select a form"
          onChange={HandleChange}
          
        >
       {afForms.map((afForm,index) => (
    
        
          <MenuItem  key={index} value={afForm.id}>{afForm.title}</MenuItem>
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

* Hämta formulär - ett get-anrop görs till [getForm](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/Get-Form-Definition), där ID:t är ID:t för det valda adaptiva formuläret av användaren i listrutan. Resultatet av det här GET-anropet lagras i selectedForm.

```
const resp = await fetch(`/adobe/forms/af/${formID}`);
let formJSON = await resp.json();
console.log(formJSON.afModelDefinition);
setForm(formJSON.afModelDefinition);
```

* Visa det markerade formuläret. Följande kod användes för att visa det valda formuläret. Elementet AdaptiveForm finns i paketet aemforms/af-response-renderer npm och mappningarna och formJson förväntas som dess egenskaper

```
<div><AdaptiveForm mappings={extendMappings} formJson={selectedForm}/></div>
```

## Nästa steg

[Visa formulären i kortlayout](./display-forms-card-view.md)
