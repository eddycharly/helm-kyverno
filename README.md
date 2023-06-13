# helm-kyverno

This repository contains an [Helm](https://helm.sh) plugin for [Kyverno](https://kyverno.io).

When exectued the plugin runs Kyverno CLI against templated Helm resources using configured policies.

## Install

```bash
$ helm plugin install https://github.com/eddycharly/helm-kyverno

Downloading and installing kyverno-cli v1.10.0 ...
https://github.com/kyverno/kyverno/releases/download/v1.10.0/kyverno-cli_v1.10.0_darwin_arm64.tar.gz
Installed plugin: kyverno
```

## Update

```bash
$ helm plugin update kyverno

Downloading and installing kyverno-cli v1.10.0 ...
https://github.com/kyverno/kyverno/releases/download/v1.10.0/kyverno-cli_v1.10.0_darwin_arm64.tar.gz
Installed plugin: kyverno
```

## Uninstall

```bash
$ helm plugin uninstall kyverno

Uninstalled plugin: kyverno
```

## Example

```bash
# install some policies
$ mkdir -p ./policies && helm template --repo https://kyverno.github.io/kyverno kyverno-policies kyverno-policies > ./policies/policies.yaml

# evaluate templated resources against local policies
$ helm kyverno --namespace kyverno --repo https://kyverno.github.io/kyverno kyverno kyverno --policies ./policies

Applying 12 policy rules to 68 resources...

pass: 156, fail: 0, warn: 0, error: 0, skip: 2292 
```
