terraform {
  backend "remote" {
    organization = "ccoe-ttech" # org name from step 2.
    workspaces {
      name = "dev" # name for your app's state.
    }
  }
}