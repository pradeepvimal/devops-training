variable "key" {
  default = "unset"
}

resource "google_compute_instance_template" "foobar" {
    name = "gen-etcd-cluster"
    description = "Template for etcd cluster"
    instance_description = "Instance of etcd cluster"
    machine_type = "n1-standard-1"
    can_ip_forward = false
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
    tags = ["http-server",
            "https-server", 
            "devops",
            "training"]

    # Create a new boot disk from an image
    disk {
        source_image = "coreos-stable-766-3-0-v20150908"
        auto_delete = true
        boot = true
    }

    network_interface {
        network = "default"
        access_config {
            // Ephemeral IP
        }
    }

    metadata {
        user-data = "${file("etcd-cloud-config.yml")}"
        sshKeys = "training:${file("training_rsa.pub")}"
    }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }
}
