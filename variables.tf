variable "name_prefix" {
  description = "A prefix used for naming resources."
}
variable "env" {
  description = "Environement name for creating codeArtifact on"
}
variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}