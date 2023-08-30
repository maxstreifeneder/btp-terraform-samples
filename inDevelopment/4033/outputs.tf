##
data "btp_whoami" "orchestrator" {}

output "subaccount_id" {
  value       = btp_subaccount.project.id
  description = "The ID of the project subaccount."
}

output "org_id" {
  value       = module.cloudfoundry_environment.org_id
  description = "The Cloudfoundry org ID."
}

output "user" {
  value       = data.btp_whoami.orchestrator.id
  description = "logged on user"
}

output "mail" {
  value       = data.btp_whoami.orchestrator.email
  description = "logged on user mail"
}
