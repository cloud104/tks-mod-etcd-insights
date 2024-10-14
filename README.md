# ETCD Kubernetes Insights Mod for TKS Cockpit

A Kubernetes dashboarding tool that can be used to view dashboards and reports across all of our ETCD Kubernetes clusters.

## Overview

Dashboards can help answer questions like:

- How many resources do I have?
- How old are my resources?
- What are the responsabilities for theses clusters

## Documentation

- ** TODO **

## Getting Started

### Installation

Install Powerpipe (https://powerpipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/powerpipe
```

This mod also requires [Steampipe](https://steampipe.io) with the [Kubernetes plugin](https://hub.steampipe.io/plugins/turbot/kubernetes) as the data source. Install Steampipe (https://steampipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/steampipe
steampipe plugin install kubernetes
```

Steampipe will automatically use your default Kubernetes credentials. Optionally, you can [setup multiple context connections](https://hub.steampipe.io/plugins/turbot/kubernetes#multiple-context-connections) or [customize Kubernetes credentials](https://hub.steampipe.io/plugins/turbot/kubernetes#configuring-kubernetes-cluster-credentials).

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
powerpipe mod install github.com/cloud104/tks-mod-etcd-insights
```

### Browsing Dashboards

Start Steampipe as the data source:

```sh
steampipe service start
```

Start the dashboard server:

```sh
powerpipe server
```

Browse and view your dashboards at **http://localhost:9033**.

## Open Source & Contributing

[Steampipe](https://steampipe.io) and [Powerpipe](https://powerpipe.io) are products produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). They are distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).
