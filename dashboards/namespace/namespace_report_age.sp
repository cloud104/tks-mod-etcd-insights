dashboard "namespace_age_report" {

  title         = "TKS ETCD Clusters"
  documentation = file("./dashboards/namespace/docs/namespace_report_age.md")

  tags = merge(local.namespace_common_tags, {
    type     = "Report"
    category = "ETCD"
  })

  container {

    card {
      query = query.namespace_count_etcd
      width = 2
    }

    card {
      type  = "info"
      width = 2
      query = query.namespace_24_hours_count
    }

    card {
      type  = "info"
      width = 2
      query = query.namespace_30_days_count
    }

    card {
      type  = "info"
      width = 2
      query = query.namespace_30_90_days_count
    }

    card {
      width = 2
      type  = "info"
      query = query.namespace_90_365_days_count
    }

    card {
      width = 2
      type  = "info"
      query = query.namespace_1_year_count
    }
  }
  table {

    column "UID" {
      display = "none"
    }

    query = query.namespace_age_table
  }
}

query "namespace_24_hours_count" {
  sql = <<-EOQ
    select
      count(*) as value,
      '< 24 hours' as label
    from
      kubernetes_namespace
    where
      (tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver') and
      creation_timestamp > now() - '1 days' :: interval;
  EOQ
}

query "namespace_30_days_count" {
  sql = <<-EOQ
    select
      count(*) as value,
      '1-30 Days' as label
    from
      kubernetes_namespace
    where
      (tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver') and
      creation_timestamp between symmetric now() - '1 days' :: interval
      and now() - '30 days' :: interval;
  EOQ
}

query "namespace_30_90_days_count" {
  sql = <<-EOQ
    select
      count(*) as value,
      '30-90 Days' as label
    from
      kubernetes_namespace
    where
      (tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver') and
      creation_timestamp between symmetric now() - '30 days' :: interval
      and now() - '90 days' :: interval;
  EOQ
}

query "namespace_90_365_days_count" {
  sql = <<-EOQ
    select
      count(*) as value,
      '90-365 Days' as label
    from
      kubernetes_namespace
    where
      (tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver') and
      creation_timestamp between symmetric (now() - '90 days'::interval)
      and (now() - '365 days'::interval);
  EOQ
}

query "namespace_1_year_count" {
  sql = <<-EOQ
    select
      count(*) as value,
      '> 1 Year' as label
    from
      kubernetes_namespace
    where
      creation_timestamp <= now() - '1 year' :: interval and
      (tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver')
  EOQ
}

query "namespace_age_table" {
  sql = <<-EOQ
    select
      name as "Name",
      now()::date - creation_timestamp::date as "Age in Days",
      creation_timestamp as "Create Time",
      tags->>'cockpit.tks.sh/description' as "Description",
      tags->>'cockpit.tks.sh/cluster_owners' as "Cluster Owners",      
      tags->>'cockpit.tks.sh/cluster_alias' as "Cluster Alias",      
      tags->>'cockpit.tks.sh/cloud_provider' as "Cloud Provider",
      tags->>'cockpit.tks.sh/region' as "Region",
      tags->>'cockpit.tks.sh/active' as "Active",
      tags->>'cockpit.tks.sh/etcd_cluster_type' as "Etcd Cluster Type",
      uid as "UID"
    from
      kubernetes_namespace
    where
      tags->>'cockpit.tks.sh/etcd_cluster_type'='vault' or tags->>'cockpit.tks.sh/etcd_cluster_type'='apiserver'
    order by
      creation_timestamp;
  EOQ
}
