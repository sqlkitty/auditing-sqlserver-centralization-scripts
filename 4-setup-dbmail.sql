/*you need to setup dbmail for your audit findings job (script 5 in github) to actually send an email 
make sure to update everywhere it says yourdbmailprofilename in this script 
and make sure to update the smtp server */

 
use master 
go 
sp_configure 'show advanced options',1 
go 
reconfigure with override 
go 
sp_configure 'Database Mail XPs',1 
go 
reconfigure 
go 
 
-------------------------------------------------------------------------------------------------- 
-- BEGIN Mail Settings yourdbmailprofilename 
-------------------------------------------------------------------------------------------------- 
IF NOT EXISTS(SELECT * FROM msdb.dbo.sysmail_profile WHERE  name = 'yourdbmailprofilename')  
  BEGIN 
    --CREATE Profile [yourdbmailprofilename] 
    EXECUTE msdb.dbo.sysmail_add_profile_sp 
      @profile_name = 'yourdbmailprofilename', 
      @description  = ''; 
  END --IF EXISTS profile 
   
  IF NOT EXISTS(SELECT * FROM msdb.dbo.sysmail_account WHERE  name = 'yourdbmailprofilename') 
  BEGIN 
    --CREATE Account [yourdbmailprofilename] 
    EXECUTE msdb.dbo.sysmail_add_account_sp 
    @account_name            = 'yourdbmailprofilename', 
    @email_address           = 'yourdbmailprofilename@domain.com', 
    @display_name            = 'yourservername SQL Server Alerting', 
    @replyto_address         = 'yourdbmailprofilename@domain.com', 
    @description             = '', 
    @mailserver_name         = 'smtp.domain.com', 
    @mailserver_type         = 'SMTP', 
    @port                    = '25', 
    @username                =  NULL , 
    @password                =  NULL ,  
    @use_default_credentials =  0 , 
    @enable_ssl              =  0 ; 
  END --IF EXISTS  account 
   
IF NOT EXISTS(SELECT * 
              FROM msdb.dbo.sysmail_profileaccount pa 
                INNER JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id 
                INNER JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id   
              WHERE p.name = 'yourdbmailprofilename' 
                AND a.name = 'yourdbmailprofilename')  
  BEGIN 
    -- Associate Account [yourdbmailprofilename] to Profile [yourdbmailprofilename] 
    EXECUTE msdb.dbo.sysmail_add_profileaccount_sp 
      @profile_name = 'yourdbmailprofilename', 
      @account_name = 'yourdbmailprofilename', 
      @sequence_number = 1 ; 
  END  

  