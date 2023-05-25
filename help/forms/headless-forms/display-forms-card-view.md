---
title: Visa de hämtade formulären i kortvyn
description: Använd listforms-API för att visa formulären
feature: Adaptive Forms
version: 6.5
kt: 13311
topic: Development
role: User
level: Intermediate
source-git-commit: 6aa3dff44a7e6f1f8ac896e30319958d84ecf57f
workflow-type: tm+mt
source-wordcount: '213'
ht-degree: 0%

---


# Hämta och visa formulären i kortformat

Kortvyformatet är ett designmönster som visar information eller data i form av kort. Varje kort representerar ett diskret innehålls- eller datainmatningskort och består vanligtvis av en visuellt distinkt behållare med specifika element i. I den här artikeln använder vi [listforms-API](https://opensource.adobe.com/aem-forms-af-runtime/api/#tag/List-Forms/operation/listForms) för att hämta formulären och visa dem i kortformat enligt nedan

![kortvy](./assets/card-view-forms.png)

## Kortmall

Följande kod användes för att utforma kortmallen. Kortmallen visar det adaptiva formulärets rubrik och beskrivning tillsammans med Adobe logotyp. [Material, UI-komponenter](https://mui.com/) har använts för att skapa den här layouten.

```javascript
import Paper from "@mui/material/Paper";
import Grid from "@mui/material/Grid";
import Container from "@mui/material/Container";
import { Typography } from "@mui/material";
import { Box } from "@mui/system";
const FormCard =({headlessForm}) => {
    return (
              <Grid item xs={3}>
                <Paper elevation={3}>
                    <img src="/content/dam/formsanddocuments/registrationform/jcr:content/renditions/cq5dam.thumbnail.48.48.png" className="img"/>
                    <Box padding={3}>
                    <Typography variant="subtititle2" component="h2">
                        {headlessForm.title}
                    
                    </Typography>
                    <Typography variant="subtititle3" component="h4">
                        {headlessForm.description}
                    
                    </Typography>
                    </Box>
                </Paper>
                </Grid>
          


    );
    

};
export default FormCard;
```

## Hämta formulären

Listforms-API användes för att hämta formulären från AEM. API:t returnerar en array med JSON-objekt, där varje JSON-objekt representerar ett formulär.

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
