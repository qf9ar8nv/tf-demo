terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "spring-test" {
  name = "spring-test-container"
}

resource "docker_container" "spring-test" {
  name  = "spring-test"
  image = docker_image.spring-test-container.latest
  env = ["SPRING_PROFILES_ACTIVE=test", "SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/spring_test?useUnicode=true&characterEncoding=utf8"]
}

resource "docker_image" "mysql" {
  name = "mysql:5.7"
}

resource "docker_container" "mysql" {
  name  = "mysql"
  image = docker_image.mysql.latest
  env   = ["MYSQL_ROOT_PASSWORD=root", "MYSQL_DATABASE=spring_test"]
  volumes {
    container_path = "/var/lib/mysql"
    host_path      = "/var/lib/mysql"
  }
}