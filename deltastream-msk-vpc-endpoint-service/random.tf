# ------------------------------------------
# Supporting Resources
# ------------------------------------------

resource random_string resource-id {

  count = local.create ? 1 : 0

  length  = 4
  special = false
  lower   = true
}
