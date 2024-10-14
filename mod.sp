mod "etcd_insights" {
  # Hub metadata
  title         = "Etcd Insights"
  description   = "Etcd Insights for TKS Clusters"
  color         = "#0089D6"
  # documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/kubernetes-insights.svg"
  categories    = ["kubernetes", "dashboard", "private", "tks"]

  opengraph {
    title       = "TKS Mod for ETCD K8S Clusters Insights"
    description = "Dashboards and reports for our ETCD Kubernetes Clusters."
    image       = "/images/mods/turbot/kubernetes-insights-social-graphic.png"
  }

  require {
    plugin "kubernetes" {
      min_version = "0.15.0"
    }
  }
}
