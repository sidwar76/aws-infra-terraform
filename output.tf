output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "load_balancer_dns" {
  value = module.load_balancer.lb_dns
}
