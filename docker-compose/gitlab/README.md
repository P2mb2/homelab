Register New Runner
```sh
docker exec -it gitlab_runner gitlab-runner register
http://172.18.0.2:80/

Enter the registration token:
<Pegue seu token para registro no GitLab > Admin Area > Overview > Runners > Register an instance runner > Copiar token>
Enter a description for the runner:
[d0dd48cad767]: <opcional>
Enter tags for the runner (comma-separated): <opcional>
Enter optional maintenance note for the runner: <opcional>

Registering runner... succeeded                     runner=5jaZNWRS
Enter an executor: custom, docker-ssh, shell, ssh, docker-ssh+machine, docker, parallels, virtualbox, docker+machine, kubernetes:
docker
Enter the default Docker image (for example, ruby:2.7):
ruby:2.7
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

Add Connectivity settings [extra_hosts and clone_url]
```sh
sudo vim ./config/gitlab-runner/config.toml
```

concurrent = 1
check_interval = 0
connection_max_age = "15m0s"
shutdown_timeout = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "docker"
  url = "http://172.18.0.2:80/"
  clone_url = "https://gitlab.jotapombo.org"
  id = 6
  token = "JS3xqHkpe3UXwD5V6Gds"
  token_obtained_at = 2024-11-19T19:00:56Z
  token_expires_at = 0001-01-01T00:00:00Z
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    MaxUploadedArchiveSize = 0
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
  [runners.docker]
    tls_verify = false
    image = "ruby:2.7"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    extra_hosts = ["gitlab.localhost:172.18.0.2"]
    volumes = ["/cache"]
    shm_size = 0
    network_mtu = 0

