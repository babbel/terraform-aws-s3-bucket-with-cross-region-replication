provider "aws" {
  alias  = "primary"
  region = "local-1"
}

provider "aws" {
  alias  = "secondary"
  region = "local-2"
}
