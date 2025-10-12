# Conversations

MijnBureau supplies an installation of [Conversations](hhttps://github.com/suitenumerique/conversations). It is AI Assistant developer by LaSuite. It is still a prototype so use in production is not encouraged.

## Configuration

To configure this solution, you can override the default settings for your
[selected environment](https://minbzk.github.io/mijn-bureau-infra/docs/category/installation). The defaults are
located in the folder `helmfile/environments/default`.

| Name                                     | Description                                             |
| ---------------------------------------- | ------------------------------------------------------- |
| `global.domain`                          | The domain name of your MijnBureau instance             |
| `global.hostname.conversations`          | The name of the subdomain for the conversations client  |
| `application.conversations.enabled`      | Enable conversations for your MijnBureau implementation |
| `application.conversations.namespace`    | The Kubernetes namespace name                           |
| `authorization.conversations.enabled`    | Enable conversations for your MijnBureau implementation |
| `tls.conversations.*`                    | The TLS settings for conversations                      |
| `pvc.conversations.*`                    | storage requirements                                    |
| `resources.conversations.*`              | Resources for conversations                             |
| `autoscaling.horizontal.conversations.*` | Autoscaling for conversations.                          |
| `container.conversations.*`              | Container selection                                     |
| `secret.conversations.*`                 | Superuser credentials                                   |
| `ai.llm.*`                               | AI used by conversations                                |

## More information

Conversations is an open-source AI chatbot designed to be simple, secure and privacy-friendly.
