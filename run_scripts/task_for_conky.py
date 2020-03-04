
import os

from colorama import Fore, Back, Style, init
from taskw import TaskWarrior

init(autoreset=True)

w = TaskWarrior()
a_tasks = w.load_tasks()

w_tasks = sorted(a_tasks['pending'], key=lambda k: k['urgency'], reverse=True) 
#leet chars: ┤┤└└┴┴┐┐││┘┘┌┌│├┬┬┼┼┴┴── ││ ▽▼△▲▵▴▾▿
#{'id': 3, 'description': 'dupa 3', 'entry': '20200228T131832Z', 'modified': '20200228T131832Z', 'status': 'pending', 'uuid': 'f4fbb59a-da26-4de9-a7be-befaa7f0092c', 'urgency': 0.0164384}

#os.system("echo '${color2}'test_1")



print("┌───────┐")
print("│ TODOs │")
print("├───────┘")
print("├─ All tasks ${color2}[${color1}%d${color2}]${color1}" % len(w_tasks))
print("├─ ${color2}" + "ID".ljust(4, " ") +"${color1}│${color2}" + "U".ljust(5, " ") + "${color1}│" + "P".ljust(2, " ") + "│" + "Project".ljust(15, " ") + "│" + "Description".ljust(42, " ") + "│")
print("├" + "─" * 6 + "┼" + "─" * 5 + "┼" + "─" * 2 + "┼" + "─" * 15 + "┼" + "─" * 42 + "┤")
for _ in range(0, len(w_tasks) if len(w_tasks) < 10 else 10):
#    print(w_tasks[_])
    print("%s─ %s│%s│%s│%s│%s│" % (
        "├" if _ != len(w_tasks) - 1  else "└",
        str(w_tasks[_]["id"] if "id" in w_tasks[_] else " ").ljust(4, " "),
        str(w_tasks[_]["urgency"] if "urgency" in w_tasks[_] else " ")[:5].ljust(5, " "),
        str(w_tasks[_]["priority"] if "priority" in w_tasks[_] else " ").ljust(2, " "),
        str(w_tasks[_]["project"] if "project" in w_tasks[_] else " ").ljust(15, " "),
        str(w_tasks[_]["description"] if "description" in w_tasks[_] else " ").ljust(42, " "),
    ))

#print("└" + "─" * 6 + "┴" + "─" * 5 + "┴" + "─" * 2 + "┴" + "─" * 15 + "┴" + "─" * 42 + "┘")
