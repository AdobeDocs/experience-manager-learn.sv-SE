---
title: Visa de hämtade formulären i kortvyn
description: Använd listforms-API för att visa formulären
feature: Adaptive Forms
version: Experience Manager 6.5
jira: KT-13311
topic: Development
role: User
level: Intermediate
exl-id: c01ad68e-23c9-4564-8e3e-1924af34a493
duration: 91
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '286'
ht-degree: 0%

---

# Hämta och visa formulären i kortformat

Kortvyformatet är ett designmönster som visar information eller data i form av kort. Varje kort representerar ett diskret innehålls- eller datainmatningskort och består vanligtvis av en visuellt distinkt behållare med specifika element i.
Klickbara kort i React är interaktiva komponenter som liknar kort eller rutor och som användaren kan klicka på eller trycka på. När en användare klickar eller trycker på ett klickbart kort utlöses en viss åtgärd eller ett visst beteende, till exempel navigering till en annan sida, öppning av ett modalt kort eller uppdatering av användargränssnittet.

I den här artikeln använder vi [listforms-API](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/List-Forms/operation/listForms) för att hämta formulären och visa formulären i kortformat och öppna det adaptiva formuläret i click-händelsen.

![kort-vy](./assets/card-view-forms.png)

## Kortmall

Följande kod användes för att utforma kortmallen. Kortmallen visar det adaptiva formulärets titel och beskrivning tillsammans med Adobe logotyp. [Material-gränssnittskomponenter](https://mui.com/) har använts för att skapa den här layouten.



```javascript
import Container from "@mui/material/Container";
import Form from './Form';
import PlainText from './plainText'
import TextField from './TextField'
import Button from './Button';
import { AdaptiveForm } from "@aemforms/af-react-renderer";

import { CardActionArea, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { useState,useEffect } from "react";
import DisplayForm from "../DisplayForm";
import { Link } from "react-router-dom";
export default function FormCard({headlessForm}) {
const extendMappings =
    {
        'plain-text' : PlainText,
        'text-input' : TextField,
        'button' : Button,
        'form': Form
    };
   
    return (
        
            <Grid item xs={3}>
                <Paper elevation={3}>
                    <img src="/content/dam/formsanddocuments/registrationform/jcr:content/renditions/cq5dam.thumbnail.48.48.png" className="img"/>
                    <Box padding={3}>
                        <Link style={{ textDecoration: 'none' }} to={`/displayForm${headlessForm.id}`}>
                            <Typography variant="subtititle2" component="h2">
                                {headlessForm.title}
                            </Typography>
                            <Typography variant="subtititle3" component="h4">
                                {headlessForm.description}
                            </Typography>
                        </Link>
                
                    </Box>
                </Paper>
            </Grid>
    );
    

};
```

Följande väg definierades i Main.js för att navigera till DisplayForm.js

```javascript
    <Route path="/displayForm/:formID" element={<DisplayForm/>} exact/>
```

## Hämta formulären

Listforms-API användes för att hämta formulären från AEM-servern. API:t returnerar en array med JSON-objekt, där varje JSON-objekt representerar ett formulär.

```javascript
import { useState,useEffect } from "react";
import React, { Component } from "react";
import FormCard from "./components/FormCard";
import Grid from "@mui/material/Grid";
import Paper from "@mui/material/Paper";
import Container from "@mui/material/Container";
 
export default function ListForm(){
    const [fetchedForms,SetHeadlessForms] = useState([])
    const getForms=async()=>{
        const response = fetch("/adobe/forms/af/listforms")
        let headlessForms = await (await response).json();
        console.log(headlessForms.items);
        SetHeadlessForms(headlessForms.items);
    }
    useEffect( ()=>{
        getForms()
        

    },[]);
    return(
        <div>
             <div>
                <Container>
                   <Grid container spacing={3}>
                       {
                            fetchedForms.map( (afForm,index) =>
                                <FormCard headlessForm={afForm} key={index}/>
                         
                            )
                        }
                    </Grid>
                </Container>
             </div>

        </div>
    )
}
```

I ovanstående kod itererar vi genom elementen fetchedForms med hjälp av funktionen map och för varje objekt i arrayen fetchedForms skapas en FormCard-komponent som läggs till i rutnätsbehållaren. Nu kan du använda ListForm-komponenten i appen React enligt dina önskemål.

## Nästa steg

[Visa det adaptiva formuläret när användaren klickar på ett kort](./open-form-card-view.md)
