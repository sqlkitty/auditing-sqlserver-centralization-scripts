**Centralizing your SQL Server auditing data **

1. Create an auditing database on your central server and an auditing table to store the data 
1a. Create an auditing user
3. Setup a linked server on all the audited servers that links to your central server 
4. Create an audit collection job on all of your audited servers - depending on SQL Server version there are two different scripts 
5. Setup dbmail so your audit email will work in step 5 
6. Create agent job to send html formatted email of audit findings in the last day 
7. Create agent job to cleanup audit data
