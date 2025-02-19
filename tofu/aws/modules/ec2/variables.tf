variable "project_name" {
  type        = string
  description = "Project name that will be used as the resource name prefix."
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be associated with the created resources."
}