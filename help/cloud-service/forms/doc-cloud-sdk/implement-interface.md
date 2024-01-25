---
title: Implementera gränssnittsmetoderna
description: Implementera gränssnittsmetoderna för att skapa PDF-filer med Document Cloud REST API.
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
thumbnail: 7826.jpg
jira: KT-7826
exl-id: c1fd02aa-577b-453f-8948-ca50e3e8f89b
duration: 167
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '44'
ht-degree: 0%

---

# Implementering av gränssnitt

Här följer den fullständiga koden för den klass som implementerar gränssnittet.

Den här klassen använder två verktygsmetoder `getAccessToken`, `getJWTToken` och statisk metod `getContentAnalyserRequest` av `GetContentAnalyser` klassen.


```java
package com.aemforms.doccloud.core.impl;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.security.KeyFactory;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.KeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.BodyPart;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.metatype.annotations.Designate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.aemfd.docmanager.Document;
import com.aemforms.doccloud.core.DocumentCloudConfiguration;

import com.aemforms.doccloud.core.DocumentCloudSDKService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mergeandfuse.getserviceuserresolver.GetResolver;
import static io.jsonwebtoken.SignatureAlgorithm.RS256;
import io.jsonwebtoken.Jwts;

@Component

@Designate(ocd = DocumentCloudConfiguration.class)
public class DocumentCloudServiceImpl implements DocumentCloudSDKService {
    private final Logger log = LoggerFactory.getLogger(getClass());
    private static final String AUTH_ENDPOINT = "/ims/exchange/jwt/";
    private static final String imsHost = "ims-na1.adobelogin.com";
    private static final String CREATE_PDF_URL = "https://cpf-ue1.adobe.io/ops/:create?respondWith=%7B%22reltype%22%3A%20%22http%3A%2F%2Fns.adobe.com%2Frel%2Fprimary%22%7D";

    private DocumentCloudConfiguration config;
    @Reference
    GetResolver getResolver;
    @Activate
    protected void activate(DocumentCloudConfiguration config) {
        log.debug("####In my DocumentCloudServiceImpl activate method");
        log.debug("clientID:" + config.getClientID() + "Tech ID: " + config.getTechnicalAccount());
        this.config = config;

    }
    @Override
    public Document getPDF(String location, String accessToken, String fileName) {
        log.debug("In getting the converted pdf from  " + location);
        HttpGet httpGet = new HttpGet(location);
        httpGet.addHeader("Authorization", "Bearer " + accessToken);
        httpGet.addHeader("X-Api-Key", config.getClientID());
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            HttpResponse response = httpclient.execute(httpGet);
            System.out.println("$$$$ The response I got in Poll is  " + response.getStatusLine().getStatusCode());
            InputStream in = new BufferedInputStream(response.getEntity().getContent());
            ByteArrayDataSource datasource = new ByteArrayDataSource( in , "multipart/form-data");
            MimeMultipart multipart = new MimeMultipart(datasource);
            int count = multipart.getCount();
            log.debug("count " + count);
            for (int i = 0; i<count; i++) {
                BodyPart bodyPart = multipart.getBodyPart(i);
                if (bodyPart.isMimeType("application/octet-stream")) {
                    System.out.println("The mime type is " + bodyPart.getContentType());
                    InputStream is = bodyPart.getInputStream();
                    Document convertedPDF = new Document(is);
                    if (log.isDebugEnabled()) {
                        String[] fileNameParts = fileName.split("\\.(?=[^\\.]+$)");
                        convertedPDF.copyToFile(new File(fileNameParts[0] + ".pdf"));
                    }
                    return convertedPDF;
                }
            }

        } catch (Exception e) {

            log.debug(e.getMessage());
        }
        return null;
    }
    @Override
    public Document createPDFFromInputStream(InputStream is, String fileName) {
        HttpPost httpPost = new HttpPost(CREATE_PDF_URL);
        String accessToken = getAccessToken();
        log.debug("The Access Token I got was " + accessToken);
        httpPost.addHeader("Authorization", "Bearer " + getAccessToken());
        httpPost.addHeader("X-Api-Key", config.getClientID());
        log.debug("Got document to convert");
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        ContentType strContent = ContentType.create("text/plain", Charset.forName("UTF-8"));
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        builder.addBinaryBody("InputFile0", is);
        builder.addTextBody("contentAnalyzerRequests", GetContentAnalyser.getContentAnalyserRequest(fileName), strContent);
        try {
            HttpEntity entity = builder.build();
            httpPost.setEntity(entity);
            CloseableHttpClient httpclient = HttpClients.createDefault();
            HttpResponse response = httpclient.execute(httpPost);
            log.debug("The response after sending document for conversion...  was " + response.getStatusLine().getStatusCode());
            log.debug("The location is " + response.getFirstHeader("location").getValue());
            return getPDF(response.getFirstHeader("location").getValue(), accessToken, fileName);
        } catch (IOException e) {

            log.debug(e.getMessage());
        }
        return null;
    }

    private String getJWTToken() {
        String CLIENT_ID = config.getClientID();

        String METASCOPE_ID = config.getMetascope();
        String TECH_ACCT = config.getTechnicalAccount();
        String ORG_ID = config.getOrganizationID();

        try {
            ResourceResolver rr = getResolver.getServiceResolver();
            Resource privateKeyRes = rr.getResource("/etc/key/documentcloud/private.key");
            System.out.println("Got resource private key");
            InputStream is = privateKeyRes.adaptTo(InputStream.class);
            BufferedInputStream bis = new BufferedInputStream(is);
            ByteArrayOutputStream buf = new ByteArrayOutputStream();
            int result = bis.read();
            while (result != -1) {
                byte b = (byte) result;
                buf.write(b);
                result = bis.read();
            }
            String privatekeyString = buf.toString();
            privatekeyString = privatekeyString.replaceAll("\\n", "").replace("-----BEGIN PRIVATE KEY-----", "").replace("-----END PRIVATE KEY-----", "");
            log.debug("The sanitized private key string is " + privatekeyString);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            log.debug("The key factory algorithm is " + keyFactory.getAlgorithm());
            byte[] byteArray = privatekeyString.getBytes();
            log.debug("The array length is " + byteArray.length);
            byte[] encodedBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(privatekeyString);
            KeySpec ks = new PKCS8EncodedKeySpec(encodedBytes);
            String metascopes[] = new String[] {
                METASCOPE_ID
            };
            RSAPrivateKey privateKey = (RSAPrivateKey) keyFactory.generatePrivate(ks);
            HashMap<String, Object> jwtClaims = new HashMap<>();
            jwtClaims.put("iss", ORG_ID);
            jwtClaims.put("sub", TECH_ACCT);
            Long expirationTime = System.currentTimeMillis() / 1000 + 86400 L;
            jwtClaims.put("exp", expirationTime);
            jwtClaims.put("aud", "https://" + imsHost + "/c/" + CLIENT_ID);
            for (String metascope: metascopes) {
                jwtClaims.put("https://" + imsHost + "/s/" + metascope, java.lang.Boolean.TRUE);
            }
            String jwtToken = Jwts.builder().setClaims(jwtClaims).signWith(RS256, privateKey).compact();
            return jwtToken;
        } catch (Exception e) {
            log.debug("Error in creating JWT Token " + e.getMessage());
        }
        return null;

    }

    public String getAccessToken() {

        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpHost authServer = new HttpHost(imsHost, 443, "https");
        HttpPost authPostRequest = new HttpPost(AUTH_ENDPOINT);
        authPostRequest.addHeader("Cache-Control", "no-cache");
        List<NameValuePair> params = new ArrayList<NameValuePair> ();
        params.add(new BasicNameValuePair("client_id", config.getClientID()));
        params.add(new BasicNameValuePair("client_secret", config.getClientSecret()));
        params.add(new BasicNameValuePair("jwt_token", getJWTToken()));
        authPostRequest.setEntity(new UrlEncodedFormEntity(params, Consts.UTF_8));
        HttpResponse response;
        try {
            response = httpClient.execute(authServer, authPostRequest);
            log.debug("$$$$$ " + response.getStatusLine().getStatusCode());
            HttpEntity entity = response.getEntity();
            JsonObject jsonResponse = new JsonParser().parse(EntityUtils.toString(entity)).getAsJsonObject();
            log.debug("Returning access_token " + jsonResponse.get("access_token").getAsString());
            return jsonResponse.get("access_token").getAsString();

        } catch (IOException e) {
            log.debug("Error in generating access token " + e.getMessage());
        }
        return null;

    }

}
```
