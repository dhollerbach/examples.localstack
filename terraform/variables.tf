variable "architectures" {
  default     = ["x86_64"]
  description = "The lambda architecture"
  type        = list(string)
}

variable "cloudwatch_log_group_name" {
  default     = ""
  description = "The cloudwatch log group name"
  type        = string
}

variable "cloudwatch_log_group_retention" {
  default     = 7
  description = "The cloudwatch log group retention period in days"
  type        = number
}

variable "environment_variables" {
  default = {
    TEST = "test"
  }
  description = "A map of environment variables"
  type        = any
}

variable "handler" {
  default     = "main.lambda_handler"
  description = "The lambda handler"
  type        = string
}

variable "iam_policy_name" {
  default     = ""
  description = "The iam policy name"
  type        = string
}

variable "lambda_role_name" {
  default     = ""
  description = "The lambda role name"
  type        = string
}

variable "name" {
  default     = "example-python"
  description = "The lambda name. Used for naming throughout the module"
  type        = string
}

variable "output_path" {
  default     = ""
  description = "The lambda output path"
  type        = string
}

variable "publish" {
  default     = true
  description = "The default publish setting"
  type        = string
}

variable "runtime" {
  default     = "python3.9"
  description = "The lambda runtime"
  type        = string
}

variable "source_dir" {
  default     = ""
  description = "The lambda source dir path"
  type        = string
}

variable "timeout" {
  default     = 4
  description = "The lambda timeout"
  type        = number
}
