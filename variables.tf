variable "aws-ecs-task-name" {
  type    = string
  default = "minecraft-on-ecs"
}
variable "aws-ecs-cluster-cpu" {
  type    = number
  default = 1024
}
variable "aws-ecs-cluster-memory" {
  type    = number
  default = 2048
}
variable "aws-ecs-container-memory" {
  type    = number
  default = 2048
}
variable "aws-ecs-container-memory-reservation" {
  type    = number
  default = 1024
}
variable "aws-ecs-container-java-memory-heap" {
  type    = string
  default = "1500M"
}
variable "aws-region" {
  type    = string
  default = "ap-northeast-1"
}
variable "aws-availability-zone" {
  type    = string
  default = "ap-northeast-1a"
}
