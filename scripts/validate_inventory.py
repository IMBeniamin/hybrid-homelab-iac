#!/usr/bin/env python3
import pathlib
import sys
import yaml

root = pathlib.Path(__file__).resolve().parents[1]
hosts = yaml.safe_load((root / "inventory/hosts.yml").read_text())["hosts"]
services = yaml.safe_load((root / "inventory/services.yml").read_text())["services"]

errors = []
for name, svc in services.items():
    if svc["host"] not in hosts:
        errors.append(f"{name}: unknown host {svc['host']}")
    if svc.get("failover") and svc["failover"] not in hosts:
        errors.append(f"{name}: unknown failover host {svc['failover']}")

if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)
print(f"ok: {len(hosts)} hosts, {len(services)} services validated")
