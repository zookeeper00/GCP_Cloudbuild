# Configure the Google Cloud provider

  provider "google" {

  project     = "testing-project-419916"

  region      = "asia-east1"  # Choose your desired region

  credentials = file("/home/ushaikh8446/testing-project-419916-a7392315fcde.json")

}

resource "google_compute_instance" "vm_instance" {
 count        = 5
 name         = "your-instance-name-${count.index}"
 machine_type = "e2-standard-2"
 zone         = "asia-east1-a"
 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = 30
     type  = "pd-standard"
   }
 }
 network_interface {
   network = "default"
   access_config {
     // Ephemeral IP
   }
 }
 scheduling {
   preemptible       = true
   automatic_restart = false
   on_host_maintenance = "TERMINATE"
 }
 tags = ["preemptible-vm"]
 metadata = {
   startup-script = <<-EOT
     #!/bin/bash
     echo "Hello, World!" > /var/www/html/index.html
   EOT
 }
}
