#################################
# Project specific configuration
#################################
# Your global account subdomain
globalaccount        = "xxx"
region               = "us10"
subaccount_name      = "UC - Build resilient BTP Apps 1"
cf_environment_label = "cf-us10"
cf_space_name        = "development"

# Usage within canary landscape
#globalaccount   = "terraformdemocanary"
#region          = "eu12"
#cli_server_url  = "https://cpcli.cf.sap.hana.ondemand.com"

subaccount_admins           = ["martin.frick@sap.com"]
subaccount_service_admins   = ["martin.frick@sap.com", "maximilian.streifeneder@sap.com"]

cf_space_managers           = ["maximilian.streifeneder@sap.com"]
cf_space_developers         = ["maximilian.streifeneder@sap.com"]
cf_space_auditors           = ["maximilian.streifeneder@sap.com"]

subaccount_developers       = ["martin.frick@sap.com", "maximilian.streifeneder@sap.com"]
