variable project {
  description = "Project ID"
}

variable name {
  description = "GKE cluster name"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable machine_type {
  description = "Type of virtual manchine in GCE"
  default     = "g1-small"
}

variable disk_size_gb {
  description = "Instance disk size"
  default     = "20"
}
