# Coral Team Child Auditor Test

> The component shows statistics about related objects (Account screen below)

<p align="center"> 
![picture](imgs/1.png)
</p>

**Solution**

- I've decided to show only business-valuable objects, because this component is needed by Salesforce users, not by analytics
- This component DOESN'T display system or setup Objects like AccountContentHistory, etc.
- It improves performance - the component renders very quickly 
- The component shows child objects which are presented on SObject's layouts and accessible by Salesforce users
- Child objects are determined dynamically using Metadata API
- The component uses single SOQL to fetch related objects and count them

**Flow"**
![picture](imgs/3.png)

**Spinner**
![picture](imgs/2.png)

**Contact screen**
![picture](imgs/4.png)

**Opportunity screen**
![picture](imgs/5.png)

**Case screen**
![picture](imgs/6.png)
