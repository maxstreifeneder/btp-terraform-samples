###############################################################################################
# Setup of names in accordance to naming convention
###############################################################################################
locals {
  random_uuid               = uuid()
  project_subaccount_domain = "connected-experience"
  project_subaccount_cf_org = "connected-experience"
}

###############################################################################################
# Creation of subaccount
###############################################################################################
resource "btp_subaccount" "project" {
  name      = var.subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
}

resource "btp_subaccount_trust_configuration" "simple" {
  subaccount_id     = btp_subaccount.project.id
  identity_provider = var.ias_host
}

###############################################################################################
# Assignment of users as sub account administrators
###############################################################################################
resource "btp_subaccount_role_collection_assignment" "subaccount-admins" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
}

###############################################################################################
# Assignment of users as sub account service administrators
###############################################################################################
resource "btp_subaccount_role_collection_assignment" "subaccount-service-admins" {
  for_each             = toset("${var.subaccount_service_admins}")
  subaccount_id        = btp_subaccount.project.id
  role_collection_name = "Subaccount Service Administrator"
  user_name            = each.value
}

module "kyma_runtime" {
  source         = "SAP-samples/btp-terraform-samples/envinstance-kyma"
  subaccount_id  = btp_subaccount.project.id
  name           = "kyma-cluster"
  administrators = var.subaccount_admins
}

######################################################################
# Add "sleep" resource for generic purposes
######################################################################
resource "time_sleep" "wait_a_few_seconds" {
  create_duration = "30s"
}

######################################################################
# Entitlement of all services and apps
######################################################################
resource "btp_subaccount_entitlement" "name" {
  depends_on = [time_sleep.wait_a_few_seconds]
  for_each = {
    for index, entitlement in var.entitlements :
    index => entitlement
  }
  subaccount_id = btp_subaccount.project.id
  service_name  = each.value.service_name
  plan_name     = each.value.plan_name
}

######################################################################
# Create app subscriptions
######################################################################
resource "btp_subaccount_subscription" "app" {
  subaccount_id = btp_subaccount.project.id
  for_each = {
    for index, entitlement in var.entitlements :
    index => entitlement if contains(["app"], entitlement.type)
  }

  app_name   = each.value.service_name
  plan_name  = each.value.plan_name
  depends_on = [btp_subaccount_entitlement.name]
}

locals {
  # Nested loop over both lists, and flatten the result.
  rc_assignments = distinct(flatten([
    for developer in var.subaccount_developers : [
      for role_collection in var.developer_role_collections : {
        user            = developer
        role_collection = role_collection
      }
    ]
  ]))
}

resource "btp_subaccount_role_collection_assignment" "rolecollections" {
  for_each = { for idx, entry in local.rc_assignments : "${entry.user}-${entry.role_collection}" => entry }

  subaccount_id        = btp_subaccount.project.id
  user_name            = each.value.user
  role_collection_name = each.value.role_collection
  depends_on           = [btp_subaccount_subscription.app, btp_subaccount_entitlement.appstudio]
}
