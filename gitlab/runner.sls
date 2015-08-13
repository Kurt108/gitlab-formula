{% from "gitlab/map.jinja" import gitlab with context %}

include:
  - users



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
    - name: gitlab-runner register --tag-list  {{ grains['fqdn'] }},{{gitlab.identifier}},{{ grains['fqdn'] }},{{gitlab.identifier}} --description {{ grains['fqdn'] }}-{{gitlab.identifier}} --non-interactive --url {{ gitlab.url }} --registration-token {{ gitlab.token }}
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




github-gitlab-ci-runner:
  ssh_known_hosts:
    - present
    - name: github.com
    - user: gitlab-runner
    - enc: ssh-rsa
    - fingerprint: {{ salt['pillar.get']('github:fingerprint') }}
    - require:
      - user: gitlab-runner

managed-dotenv:
  file.managed:
    - name: /home/gitlab-runner/.env
    - user: gitlab-runner
    - source: salt://gitlab/dotenv
    - require:
      - user: jenkins
    - template: jinja