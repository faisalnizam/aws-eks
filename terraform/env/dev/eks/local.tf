locals {
  role_member        = var.child_role
  poc_dev_role     = join("/", [join(":", ["arn:aws:iam:", data.terraform_remote_state.avm.outputs.accounts.poc-dev.account_id, "role"]), local.role_member])

}

