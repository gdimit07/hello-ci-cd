# create an agent token for the cluster
resource "buildkite_cluster_agent_token" "fleet" {
  description = "Default cluster token for AWS fleet"
  cluster_id  = data.buildkite_cluster.hello.id
}

resource "aws_cloudformation_stack" "buildkite_agents_fleet" {
  name         = "hello-ci-cd-fleet"
  template_url = "https://s3.amazonaws.com/buildkite-aws-stack/latest/aws-stack.yml"
  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  parameters = {
    AgentsPerInstance   = 1
    InstanceTypes       = "t3.xlarge"
    MaxSize             = 3
    MinSize             = 1
    RootVolumeSize      = 50
    BuildkiteAgentToken = buildkite_cluster_agent_token.fleet.token
  }
}