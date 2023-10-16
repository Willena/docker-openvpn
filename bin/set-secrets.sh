#!/usr/bin/env bash
set -e

source bin/_helpers.sh
ensure-environment "VPN_HOSTNAME NAMESPACE"

cmd_create="kubectl -n ${NAMESPACE} --dry-run=client -o=yaml create"

mkdir -p deployment

eval "${cmd_create} secret generic ovpn0-key --from-file=ovpn0/server/pki/private/${VPN_HOSTNAME}.key" > deployment/ovpn0-key.yml
eval "${cmd_create} secret generic ovpn0-cert --from-file=ovpn0/server/pki/issued/${VPN_HOSTNAME}.crt" > deployment/ovpn0-cert.yml
eval "${cmd_create} secret generic ovpn0-pki --from-file=ovpn0/server/pki/ca.crt --from-file=ovpn0/server/pki/dh.pem --from-file=ovpn0/server/pki/ta.key" > deployment/ovpn0-pki.yml
eval "${cmd_create} configmap ovpn0-conf --from-file=ovpn0/server/" > deployment/ovpn0-server-conf.yml
eval "${cmd_create} configmap ccd0 --from-file=ovpn0/server/ccd" > deployment/ovpn0-ccd.yml
