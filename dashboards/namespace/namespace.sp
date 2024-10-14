locals {
  namespace_common_tags = {
    service = "Kubernetes/Namespace"
  }
}

category "namespace" {
  title = "Namespace"
  color = local.namespace_color
  href  = "/kubernetes_insights.dashboard.namespace_detail?input.namespace_uid={{.properties.'UID' | @uri}}"
  icon  = "format_shapes"
}

query "namespace_count_etcd" {
  sql = <<-EOQ
    select
      count(*) as "Clusters"
    from
      kubernetes_namespace
    where
      tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver'
  EOQ
}
