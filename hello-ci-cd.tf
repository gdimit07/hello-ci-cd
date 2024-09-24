resource "buildkite_pipeline" "hello-ci-cd" {
  name           = "hello-pipeline"
  repository     = "https://github.com/gdimit07/hello.git"
  cluster_id     = data.buildkite_cluster.hello.id
  default_branch = "main"
  steps          = <<STEPS
  steps:
  - label: ':pipeline:'
    command: buildkite-agent pipeline upload
  STEPS
}

# Find the cluster
data "buildkite_cluster" "hello" {
  name = "hello"
}

data "github_repository" "hello" {
  full_name = "gdimit07/hello"
}

resource "github_repository_webhook" "hello" {
  repository = data.github_repository.hello.name
  configuration {
    url          = buildkite_pipeline.hello-ci-cd.webhook_url
    content_type = "application/json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}
