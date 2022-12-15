variable "verify_ssl" {
  description = "Verify SSL"
  type        = bool
  default     = true
}

variable "base_url" {
  description = "Base url"
  type        = string
  sensitive   = true
}

variable "long_lived_access_token" {
  description = "Home assistant long lived token"
  type        = string
  sensitive   = true
}

variable "alexa_skill" {
  description = "Alexa skill"
  type        = string
  sensitive   = true
}

variable "debug" {
  description = "debug activated"
  type        = bool
  default     = true
}