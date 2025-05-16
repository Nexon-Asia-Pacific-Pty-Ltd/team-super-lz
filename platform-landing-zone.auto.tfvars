custom_replacements = {
  names = {
    # Defender email security contact
    defender_email_security_contact = "security@teamsuper.com"

    # Resource group names
    management_resource_group_name = "TSF-RG-MGMT-AE"
    asc_export_resource_group_name = "TSF-RG-ASC-MGMT-AE"

    # Resource names
    log_analytics_workspace_name            = "TSF-LAW-MGMT-AE"
    automation_account_name                 = "TSF-AA-MGMT-AE"
    ama_user_assigned_managed_identity_name = "TSF-UAMI-AMA-MGMT-AE"
    dcr_change_tracking_name                = "TSF-DCR-CHANGE-TRACKING-MGMT-AE"
    dcr_defender_sql_name                   = "TSF-DCR-DEFENDER-SQL-MGMT-AE"
    dcr_vm_insights_name                    = "TSF-DCR-VM-INSIGHTS-MGMT-AE"
  }
  resource_group_identifiers = {
    management_resource_group_id = "/subscriptions/$${subscription_id_management}/resourcegroups/$${management_resource_group_name}"
  }
  resource_identifiers = {
    ama_change_tracking_data_collection_rule_id = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_change_tracking_name}"
    ama_mdfc_sql_data_collection_rule_id        = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_defender_sql_name}"
    ama_vm_insights_data_collection_rule_id     = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_vm_insights_name}"
    ama_user_assigned_managed_identity_id       = "$${management_resource_group_id}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$${ama_user_assigned_managed_identity_name}"
    log_analytics_workspace_id                  = "$${management_resource_group_id}/providers/Microsoft.OperationalInsights/workspaces/$${log_analytics_workspace_name}"
  }
}

enable_telemetry = true

tags = {
  deployed_by = "terraform"
  source      = "Azure Landing Zones Accelerator"
}

management_resource_settings = {
  automation_account_name      = "$${automation_account_name}"
  location                     = "$${starter_location_01}"
  log_analytics_workspace_name = "$${log_analytics_workspace_name}"
  resource_group_name          = "$${management_resource_group_name}"
  user_assigned_managed_identities = {
    ama = {
      name = "$${ama_user_assigned_managed_identity_name}"
    }
  }
  data_collection_rules = {
    change_tracking = {
      name = "$${dcr_change_tracking_name}"
    }
    defender_sql = {
      name = "$${dcr_defender_sql_name}"
    }
    vm_insights = {
      name = "$${dcr_vm_insights_name}"
    }
  }
}

management_group_settings = {
  location           = "$${starter_location_01}"
  parent_resource_id = "$${root_parent_management_group_id}"
  policy_default_values = {
    ama_change_tracking_data_collection_rule_id = "$${ama_change_tracking_data_collection_rule_id}"
    ama_mdfc_sql_data_collection_rule_id        = "$${ama_mdfc_sql_data_collection_rule_id}"
    ama_vm_insights_data_collection_rule_id     = "$${ama_vm_insights_data_collection_rule_id}"
    ama_user_assigned_managed_identity_id       = "$${ama_user_assigned_managed_identity_id}"
    ama_user_assigned_managed_identity_name     = "$${ama_user_assigned_managed_identity_name}"
    log_analytics_workspace_id                  = "$${log_analytics_workspace_id}"
  }
  subscription_placement = {
    identity = {
      subscription_id       = "$${subscription_id_identity}"
      management_group_name = "TSF-MG-ALZ-IDENTITY-ALL"
    }
    connectivity = {
      subscription_id       = "$${subscription_id_connectivity}"
      management_group_name = "TSF-MG-ALZ-CONNECTIVITY-ALL"
    }
    management = {
      subscription_id       = "$${subscription_id_management}"
      management_group_name = "TSF-MG-ALZ-MANAGEMENT-ALL"
    }
  }
  policy_assignments_to_modify = {
    TSF-MG-ALZ-ROOT-ALL = {
      policy_assignments = {
        Deploy-MDFC-Config-H224 = {
          parameters = {
            ascExportResourceGroupName                  = "$${asc_export_resource_group_name}"
            ascExportResourceGroupLocation              = "$${starter_location_01}"
            emailSecurityContact                        = "$${defender_email_security_contact}"
            enableAscForServers                         = "DeployIfNotExists"
            enableAscForServersVulnerabilityAssessments = "DeployIfNotExists"
            enableAscForSql                             = "DeployIfNotExists"
            enableAscForAppServices                     = "DeployIfNotExists"
            enableAscForStorage                         = "DeployIfNotExists"
            enableAscForContainers                      = "DeployIfNotExists"
            enableAscForKeyVault                        = "DeployIfNotExists"
            enableAscForSqlOnVm                         = "DeployIfNotExists"
            enableAscForArm                             = "DeployIfNotExists"
            enableAscForOssDb                           = "DeployIfNotExists"
            enableAscForCosmosDbs                       = "DeployIfNotExists"
            enableAscForCspm                            = "DeployIfNotExists"
          }
        }
      }
    }
    connectivity = {
      policy_assignments = {
        Enable-DDoS-VNET = {
          enforcement_mode = "DoNotEnforce"
        }
      }
    }
    corp = {
      policy_assignments = {
        Deploy-Private-DNS-Zones = {
          enforcement_mode = "DoNotEnforce"
        }
      }
    }
  }
}

connectivity_type = "none"