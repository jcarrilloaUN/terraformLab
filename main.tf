terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  token = var.github_token
}

resource "github_repository" "example_codebase" {
  name        = "example"
  description = "My awesome codebase"
  visibility  = "public"

  template {
    owner                  = "trussworks"
    repository             = "terraform-module-template"
    include_all_branches   = true
  }
}

resource "github_repository" "example_webpage" {
  name        = "example"
  description = "My awesome web page"
  private     = false

  pages {
    source {
      branch = "master"
      path   = "/docs"
    }
  }
}

resource "github_branch" "development" {
  repository = github_repository.example_codebase.name
  branch     = "development"
}
