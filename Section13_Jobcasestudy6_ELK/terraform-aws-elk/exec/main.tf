module "elk" {
  source = "../"

  key         = "newtest"
  private_key = file("/tmp/newtest.pem")
}

