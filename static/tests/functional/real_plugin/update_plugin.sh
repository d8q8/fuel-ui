#!/usr/bin/env bash

function update_components {
  default=${CONF_PATH}/$1.yaml
  components_file=${CONF_PATH}/$2.yaml

  sudo sh -c "cat ${components_file} ${default} > ${PLUGIN_PATH}/components.yaml"
}

function update_nics {
  nic_file=${CONF_PATH}/$1.yaml
  sudo cp ${nic_file} ${PLUGIN_PATH}/nic_config.yaml
}

function update_nodes {
  node_file=${CONF_PATH}/$1.yaml
  sudo cp ${node_file} ${PLUGIN_PATH}/node_config.yaml
}

function update_bonds {
  bond_file=${CONF_PATH}/$1.yaml
  sudo cp ${bond_file} ${PLUGIN_PATH}/bond_config.yaml
}

case $1 in
  update_components|update_nics|update_nodes|update_bonds)  func=$1; params="${@:2}";;
  *)  func=update_components;  params="$@";;
esac

$func $params

fuel --os-username admin --os-password admin plugins --sync
