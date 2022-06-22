terraform {
  backend "remote" {
    organization = "ccoe-ttech" # org name from step 2.
    workspaces {
      name = "finops" # name for your app's state.
    }
  }
}