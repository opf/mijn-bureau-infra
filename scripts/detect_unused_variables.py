#!/usr/bin/env python3

import os
import re
import sys

import yaml

HELMFILE_APPS_DIR = "helmfile/apps"
HELMFILE_ENVIRONMENTS_DIR = "helmfile/environments/default"

def load_yaml_file(path):
  with open(path, "r") as f:
    # Read file and remove Go template lines before parsing YAML
    content = f.read()
    content_no_templates = re.sub(r"\{\{.*?\}\}", "", content)
    return yaml.safe_load(content_no_templates)

def expand_dict_to_value_strings(mydict):
  result = set()
  for key, value in mydict.items():
    if isinstance(value, dict):
      nested_keys = expand_dict_to_value_strings(value)
      result.update(f"{key}.{nk}" for nk in nested_keys)
    else:
      result.add(key)
  return result

def get_env_variable_names(env_dir):
  variable_names = set()
  print(env_dir)
  for fname in os.listdir(env_dir):
    if fname.endswith(".yaml") or fname.endswith(".yaml.gotmpl"):
      env_path = os.path.join(env_dir, fname)
      env_data = load_yaml_file(env_path)
      variables = expand_dict_to_value_strings(env_data)
      variable_names.update(variables)
  return variable_names

def main():
  env_vars = get_env_variable_names(HELMFILE_ENVIRONMENTS_DIR)

  exit=0

  for var in sorted(env_vars):
    # split var by dot
    var_parts = var.split(".")
    found=False

    while len(var_parts) > 1:
      var_joined = ".Values."+".".join(var_parts)

      # Search for usage of var_joined in all files under HELMFILE_APPS_DIR
      for root, _, files in os.walk(HELMFILE_APPS_DIR):
        for fname in files:

          if fname.endswith(".yaml") or fname.endswith(".yaml.gotmpl"):
            fpath = os.path.join(root, fname)
            with open(fpath, "r") as f:
              content = f.read()
              if re.search(r"\{\{.*%s.*\}\}" % re.escape(var_joined), content):
                found = True
                break
        if found:
          break
      if found:
        break
      var_parts.pop()

    if not found:
      print(f"Variable '{var}' not found in any files.")
      exit=1

  sys.exit(exit)

if __name__ == "__main__":
  main()
