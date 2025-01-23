#!/bin/sh
python3.9 -m venv "$PWD/.venv"
"$PWD/.venv/bin/pip" install -r "$PWD/requirements.txt"
