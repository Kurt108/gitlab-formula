{% from "gitlab/map.jinja" import gitlab with context %}



gitlab-ci-multi-runner:
  pkgrepo.managed:
    - humanname: gitlab-ci-multi-runner
    - name: deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ trusty main
    - require_in:
      - pkg: gitlab-ci-multi-runner


  pkg.latest:
    - name: gitlab-ci-multi-runner


