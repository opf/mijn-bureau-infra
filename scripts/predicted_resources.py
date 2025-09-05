#!/usr/bin/env python3
import argparse
import os
import subprocess
import tempfile

import yaml


def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

# check if helmfile is already installed
def is_helmfile_installed():
    try:
        subprocess.run(["helmfile", "--version"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False

# check if helmfile is already installed
def is_helm_installed():
    try:
        subprocess.run(["helm", "version"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def convert_cpu_to_millicores(cpu):

    result = 0
    if cpu.endswith('m'):
        result = int(cpu[:-1])
    elif is_number(cpu):
        result = int(float(cpu) * 1000)

    return result

def convert_memory_to_mib(memory):

    units = {
      "Ki": 1024,
      "Mi": 1024 ** 2,
      "Gi": 1024 ** 3,
      "K": 1000,
      "M": 1000 ** 2,
      "G": 1000 ** 3,
    }

    if is_number(memory):
      result_bytes = int(memory)
    elif memory.lower().endswith('ki'):
        result_bytes = int(memory[:-2]) * units['Ki']
    elif memory.lower().endswith('mi'):
        result_bytes = int(memory[:-2]) * units['Mi']
    elif memory.lower().endswith('gi'):
        result_bytes = int(memory[:-2]) * units['Gi']
    elif memory.lower().endswith('k'):
        result_bytes = int(memory[:-2])  * units['K']
    elif memory.endswith('M'): # lowercase m is different than uppercase M
        result_bytes = int(memory[:-2]) * units['M']
    elif memory.lower().endswith('k'):
        result_bytes = int(memory[:-2])  * units['K']

    result = result_bytes // units['Mi']

    return result

def calculate_predicted_resources(manifests, detail=False):
    total_cpu_requests = 0
    total_cpu_limits = 0
    total_memory_requests = 0
    total_memory_limits = 0

    for manifest in manifests:
      if detail:
        print(f"Calculating resources for: {manifest['metadata']['name']} of kind {manifest['kind']}")

      if 'spec' in manifest:
          if manifest['kind'] == 'Pod':
              containers = manifest['spec'].get('containers', [])
          else:
              containers = manifest['spec'].get('template', {}).get('spec', {}).get('containers', [])

          for container in containers:
              resources = container.get('resources', {})
              requests = resources.get('requests', {})
              limits = resources.get('limits', {})

              cpu_request = requests.get('cpu', '0')
              memory_request = requests.get('memory', '0')
              cpu_limit = limits.get('cpu', '0')
              memory_limit = limits.get('memory', '0')
              if detail:
                print(f"Container: {container.get('name', 'unknown')}, CPU Request: {cpu_request}, CPU Limit: {cpu_limit}, Memory Request: {memory_request}, Memory Limit: {memory_limit}")

              # Convert CPU to millicores
              total_cpu_requests += convert_cpu_to_millicores(cpu_request)
              total_cpu_limits += convert_cpu_to_millicores(cpu_limit)

              # Convert Memory to MiB
              total_memory_requests += convert_memory_to_mib(memory_request)
              total_memory_limits += convert_memory_to_mib(memory_limit)


    return {
          'cpu_requests_millicores': total_cpu_requests,
          'cpu_limits_millicores': total_cpu_limits,
          'memory_requests_mib': total_memory_requests,
          'memory_limits_mib': total_memory_limits
      }

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calculate required resources")
    parser.add_argument("--environment", type=str, help="name of the environment to render", default="demo")
    parser.add_argument("--detail", action="store_true", help="Show resources per component", default=False)
    args = parser.parse_args()

    # Check if helmfile is installed
    if not is_helmfile_installed():
        print("Helmfile is not installed. Please install Helmfile before running this script.")
        exit(1)


    if not is_helm_installed():
        print("Helm is not installed. Please install Helm before running this script.")
        exit(1)


    # Define the path to the helmfile binary
    helmfile_path = os.path.join(os.getcwd(), "helmfile")

    # Check if the helmfile binary exists
    if not os.path.exists(helmfile_path):
        print(f"Helmfile folder not found at {helmfile_path}. Please ensure it is in the correct location.")
        exit(1)

    # create temporary directory for helmfile output
    temp_dir = tempfile.mkdtemp()

    print(f"Rendering helmcharts with helmfile for environment {args.environment}, this may take a few minutes...")
    try:
        helmfile_result = subprocess.run(["helmfile", "-e", args.environment , "template", "--output-dir", temp_dir, "--skip-cleanup"], check=True, stderr=subprocess.PIPE, stdout=subprocess.DEVNULL)
        print("Helmfile rendered successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error rendering helmfile: {e}")
        exit(1)

    permanent_manifests = []
    extra_manifests = []

    for root, dirs, files in os.walk(temp_dir):
      for file in files:
          if file.endswith(".yaml") or file.endswith(".yml")  or file.endswith(".yaml.gotmpl")  or file.endswith(".yml.gotmpl"):
              with open(os.path.join(root, file), 'r') as f:
                  yaml_content = yaml.safe_load_all(f)
                  if yaml_content is None:
                      continue
                  for doc in yaml_content:
                      if doc is None:
                        continue
                      if 'kind' in doc and doc['kind'] in ['StatefulSet', 'Deployment', 'DaemonSet']:
                          permanent_manifests.append(doc)
                      if 'kind' in doc and doc['kind'] in ['Job', 'CronJob', 'Pod']:
                          extra_manifests.append(doc)


    resources = calculate_predicted_resources(permanent_manifests, args.detail)
    extra_resources = calculate_predicted_resources(extra_manifests, args.detail)

    print("Predicted resources for permanent workloads (StatefulSet, Deployment, DaemonSet):")
    print(f"  CPU Requests: {resources['cpu_requests_millicores']} millicores")
    print(f"  CPU Limits: {resources['cpu_limits_millicores']} millicores")
    print(f"  Memory Requests: {resources['memory_requests_mib']} MiB")
    print(f"  Memory Limits: {resources['memory_limits_mib']} MiB")
    print("Predicted resources for extra workloads (Job, CronJob, Pod):")
    print(f"  CPU Requests: {extra_resources['cpu_requests_millicores']} millicores")
    print(f"  CPU Limits: {extra_resources['cpu_limits_millicores']} millicores")
    print(f"  Memory Requests: {extra_resources['memory_requests_mib']} MiB")
    print(f"  Memory Limits: {extra_resources['memory_limits_mib']} MiB")
