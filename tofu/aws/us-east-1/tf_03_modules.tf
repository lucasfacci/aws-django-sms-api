module "ec2" {
  source       = "../modules/ec2"
  project_name = "aws-django-sms-api"
  tags = {
    "Name" = "GhostAPI"
  }
}