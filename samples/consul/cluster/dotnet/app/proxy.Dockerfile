FROM library/consul:1.12.1

CMD [ "connect", "proxy", "-sidecar-for", "app" ]
