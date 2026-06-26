#!/usr/bin/env python3
import json
import os
import re
import subprocess
import sys
import time

ROFI_THEME = os.path.expanduser("~/.config/rofi/themes/spotlight-dark.rasi")
_TAG = re.compile(r"<[^>]+>")


def field(notif, key, default=""):
    val = notif.get(key)
    return val.get("data", default) if isinstance(val, dict) else default


def clean(text):
    return " ".join(_TAG.sub("", str(text)).split())


def history():
    out = subprocess.run(["dunstctl", "history"], capture_output=True, text=True).stdout
    return json.loads(out)["data"][0]


def activate(nid, has_action):
    subprocess.run(["dunstctl", "history-pop", str(nid)])
    if not has_action:
        return
    time.sleep(0.15)
    subprocess.run(["dunstctl", "action"])
    time.sleep(0.1)
    subprocess.run(["dunstctl", "close", str(nid)])


def main():
    notifs = history()
    if not notifs:
        subprocess.run(["dunstify", "-u", "low", "Notification center", "History is empty"])
        return

    entries, lines = [], []
    for n in notifs:
        app = clean(field(n, "appname")) or "—"
        summary = clean(field(n, "summary"))
        body = clean(field(n, "body"))
        line = f"[{app}] {summary}"
        if body:
            line += f" — {body}"
        if len(line) > 110:
            line = line[:107] + "..."
        entries.append((field(n, "id", 0), bool(field(n, "default_action_name"))))
        lines.append(line)

    if "--print" in sys.argv:
        print("\n".join(lines))
        return

    rofi = subprocess.run(
        ["rofi", "-dmenu", "-i", "-p", "Notifications", "-theme", ROFI_THEME, "-format", "i"],
        input="\n".join(lines), capture_output=True, text=True,
    )
    sel = rofi.stdout.strip()
    if sel.isdigit() and 0 <= int(sel) < len(entries):
        nid, has_action = entries[int(sel)]
        activate(nid, has_action)


if __name__ == "__main__":
    main()
