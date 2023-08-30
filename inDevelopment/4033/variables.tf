######################################################################
# Customer account setup
######################################################################
# subaccount
variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain."
  default     = "yourglobalaccount"
}
# subaccount
variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "UC - Build resilient BTP Apps"
}
# Region
variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "us10"
}
# Cloudfoundry environment label
variable "cf_environment_label" {
  type        = string
  description = "The Cloudfoundry environment label"
  default     = "cf-us10"
}

# Cloudfoundry space name
variable "cf_space_name" {
  type        = string
  description = "The Cloudfoundry space name"
  default     = "development"
}


variable "ias_host" {
  type        = string
  description = "IAS HOST URL"
}

# CLI server
variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cpcli.cf.eu10.hana.ondemand.com"
}

variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount administrators."
  default     = ["james.rapp@sap.com"]
}

variable "subaccount_service_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to each subaccount as subaccount service administrators."
  default     = ["maximilian.streifeneder@sap.com", "james.rapp@sap.com"]
}

variable "cf_space_managers" {
  type        = list(string)
  description = "Defines the colleagues who are Cloudfoundry space managers"
  default     = ["maximilian.streifeneder@sap.com", "james.rapp@sap.com"]
}

variable "cf_space_developers" {
  type        = list(string)
  description = "Defines the colleagues who are Cloudfoundry space developers"
  default     = ["maximilian.streifeneder@sap.com", "james.rapp@sap.com"]
}

variable "cf_space_auditors" {
  type        = list(string)
  description = "Defines the colleagues who are Cloudfoundry space auditors"
  default     = ["maximilian.streifeneder@sap.com", "james.rapp@sap.com"]
}

variable "subaccount_developers" {
  type        = list(string)
  description = "Defines the colleagues who should receive Developer Role Collections"
  default     = ["maximilian.streifeneder@sap.com", "james.rapp@sap.com"]
}

variable "developer_role_collections" {
  type        = list(string)
  description = "Defines the Role Collections that should be assigned to Developers"
  default     = ["Integration_Provisioner"]
}

###
# Entitlements
###
variable "entitlements" {
  type = list(object({
    service_name = string
    plan_name    = string
    type         = string
  }))
  description = "The list of entitlements that shall be added to the subaccount."
  default = [
    {
      service_name = "destination"
      plan_name    = "lite",
      type         = "service"
    },
    {
      service_name = "xsuaa"
      plan_name    = "application",
      type         = "service"
    },
    {
      service_name = "apimanagement-apiportal"
      plan_name    = "apiportal-apiaccess",
      type         = "service"
    },
    {
      service_name = "apimanagement-devportal"
      plan_name    = "devportal-apiaccess",
      type         = "service"
    },
    {
      service_name = "sap-build-apps"
      plan_name    = "free",
      type         = "app"
    },
    {
      service_name = "process-automation-services"
      plan_name    = "free",
      type         = "app"
    },
    {
      service_name = "process-automation-services"
      plan_name    = "standard",
      type         = "service"
    },
    {
      service_name = "integrationsuite"
      plan_name    = "free",
      type         = "app"
    }




  ]
}
