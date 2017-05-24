#!/bin/python

import re
import sys

filename = "settings.txt"
extensions = []
bufferedCommands = ""
output = ""
first = True

output += "# --------------------------------------------------------------- #\n"
output += "# --- THIS FILE IS AUTO-GENERATED. Edit settings.txt instead! --- #\n"
output += "# --------------------------------------------------------------- #\n\n"

def unleash():
	global extensions
	global bufferedCommands
	global output
	global first
	if len(extensions) == 0:
		print("Error: missing extension", file=sys.stderr)
		sys.exit(1);
	else:
		for ext in extensions:
			if first:
				output += "if"
			else:
				output += "elif"
			output += " check \"%s\"; then\n" % ext
			output += bufferedCommands;
			first = False
	extensions = []
	bufferedCommands = ""

with open(filename, "r") as file:
	for line in file:
		matches = re.search("^(.*):$", line)
		if matches:
			if bufferedCommands:
				unleash()
			extensions.append(matches.group(1))
		else:
			bufferedCommands += line.replace("$0", "$path")

unleash()
output += "else\n"
output += "\techo >&2 \"Unknown file type\"\n"
output += "\texit 1\n"
output += "fi"
print(output)
