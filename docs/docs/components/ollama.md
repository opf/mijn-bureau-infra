# Ollama - AI LLM

MijnBureau supplies an installation of [Ollama](https://ollama.com/). Ollama is a lightweight
framework for building and running LLMs locally

## Purpose

The purpose of the locally deployed LLM and AI endpoint in this product is solely for
_demo purposes_. For this reason an extremely lightweight model is chosen: Lamma 3.2. The small
size of this models (2GB) means that this model easily fits into memory in most scenario's but is
also essentially useless for situations other than a demo.

## Implementation notes

Ollama needs to be able to download the Lamma 3.2 model.

## Configuration

To configure this solution, you can override the default settings for your environment. The defaults are
located in the folder `helmfile/environments/default`.

| Name                       | Description                          |
| -------------------------- | ------------------------------------ |
| `application.ai.enabled`   | Enable Ollama                        |
| `application.ai.namespace` | The Kubernetes namespace name        |
| `container.ollama.*`       | Container settings to overwrite      |
| `ai.selfhost.*`            | Applicatoin configuration for ollama |
| `resource.ollama.*`        | Resource configuration               |
| `pvc.ollama.*`             | Storage configuration                |

## Your own AI LLM

If you do not want to deploy Ollama but want to use your own AI system disable ollama by setting `application.ai.enabled` and configure your AI endspoint in `ai.llm.*`.
