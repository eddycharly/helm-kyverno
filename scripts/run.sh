#!/bin/sh -e

helm_args=()
kyverno_args=()
policies=()

record_helm_args() {
    helm_args=("${helm_args[@]}" "$@")
}

record_kyverno_args() {
    kyverno_args=("${kyverno_args[@]}" "$@")
}

record_policies() {
    policies=("${policies[@]}" "$@")
}

while [[ $# -ne 0 ]]; do
    case "${1:-}" in
    --policies)
        record_policies $2
        shift
        ;;

    --audit-warn)
        record_kyverno_args $1
        ;;
    -c)
        record_kyverno_args $1
        ;;
    --cluster)
        record_kyverno_args $1
        ;;
    --context)
        record_kyverno_args $1 $2
        shift
        ;;
    -b)
        echo "option $1 not supported"
        exit 1
        ;;
    --git-branch)
        echo "option $1 not supported"
        exit 1
        ;;
    --kubeconfig)
        record_kyverno_args $1 $2
        shift
        ;;
    -o)
        record_kyverno_args $1 $2
        shift
        ;;
    --output)
        record_kyverno_args $1 $2
        shift
        ;;
    -p)
        record_kyverno_args $1
        ;;
    --policy-report)
        record_kyverno_args $1
        ;;
    --registry)
        record_kyverno_args $1
        ;;
    -s)
        record_kyverno_args $1 $2
        shift
        ;;
    --set)
        record_kyverno_args $1 $2
        shift
        ;;
    -i)
        record_kyverno_args $1
        ;;
    --stdin)
        record_kyverno_args $1
        ;;
    -u)
        record_kyverno_args $1 $2
        shift
        ;;
    --userinfo)
        record_kyverno_args $1 $2
        shift
        ;;
    -f)
        record_kyverno_args $1 $2
        shift
        ;;
    --values-file)
        record_kyverno_args $1 $2
        shift
        ;;
    --warn-exit-code)
        record_kyverno_args $1 $2
        shift
        ;;
    --warn-no-pass)
        record_kyverno_args $1
        ;;
    #   -n, --namespace string       Optional Policy parameter passed with cluster flag
    *)
        record_helm_args $1
        ;;
    esac
    shift
done

$HELM_BIN template --namespace $HELM_NAMESPACE "${helm_args[@]}" | $HELM_PLUGIN_DIR/bin/kyverno apply "${policies[@]}" --resource -
