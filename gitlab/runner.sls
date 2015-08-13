{% from "gitlab/map.jinja" import gitlab with context %}



repo-gitlab-ci-multi-runner:
  pkgrepo.managed:
    - humanname: gitlab-ci-multi-runner
    - name: deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ trusty main
    - require_in:
      - pkg: package-gitlab-ci-multi-runner

package-gitlab-ci-multi-runner:
  pkg.latest:
    - name: gitlab-ci-multi-runner


register-runner:
  cmd.run:
    - name: gitlab-runner register --description {{ grains['fqdn'] }}-{{gitlab.identifier}} --non-interactive --url {{ gitlab.url }} --registration-token {{ gitlab.token }}
    - creates: /etc/gitlab-runner/config.toml

install-runner:
  cmd.run:
    - name: gitlab-runner install --user gitlab-runner --working-directory /home/gitlab-runner/
    - creates: /etc/init/gitlab-runner.conf
    - require:
      - cmd: register-runner

start-runner:
  cmd.run:
    - name: gitlab-runner start
    - require:
      - cmd: install-runner
