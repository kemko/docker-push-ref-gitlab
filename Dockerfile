FROM inclusivedesign/nodejs

WORKDIR /etc/ansible/playbooks

COPY ansible/* /etc/ansible/playbooks/

RUN ansible-playbook build-image.yml && \
    yum clean all

EXPOSE 9000

USER gitsync

CMD ["/opt/webhook-linux-amd64/webhook", "-hooks", "/etc/webhook/hooks.json", "-port", "9000", "-verbose"] 