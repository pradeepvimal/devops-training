# Configure the Google Cloud provider
provider "google" {
    account_file = "${file("account.json")}"
    project = "devops-training"
    region = "us-central1"
}

resource "google_compute_network" "generated" {
    name = "gen"
    ipv4_range = "10.0.0.0/16"
}


resource "google_compute_firewall" "open-ports" {
    name = "allow-all"
    network = "${google_compute_network.generated.name}"


    allow {
        protocol = "tcp"
        ports = ["22", "80", "1000-9999"]
    }

    allow {
        protocol = "icmp"
    }

    source_tags = ["web"]
}
