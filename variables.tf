variable "name_prefix" {
  description = "A prefix used for naming resources."
}
variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}
variable "repos" {
  type = set(string)
  description = "Name of repositories in codeartifact"
}