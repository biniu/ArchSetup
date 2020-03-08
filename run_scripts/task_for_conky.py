
import os
import enum

from colorama import Fore, Back, Style, init
from taskw import TaskWarrior

init(autoreset=True)


def to_color(string, color="${color1}"):
    return "%s%s${color1}" % (color, string)


w = TaskWarrior()
a_tasks = w.load_tasks()

w_tasks = sorted(a_tasks['pending'], key=lambda k: k['urgency'], reverse=True)
# leet chars: ┤┤└└┴┴┐┐││┘┘┌┌│├┬┬┼┼┴┴── ││ ▽▼△▲▵▴▾▿
#{'id': 3, 'description': 'dupa 3', 'entry': '20200228T131832Z', 'modified': '20200228T131832Z', 'status': 'pending', 'uuid': 'f4fbb59a-da26-4de9-a7be-befaa7f0092c', 'urgency': 0.0164384}

color1 = "${color1}"
color2 = "${color2}"

print("┌───────┐")
print("│ TODOs │")
print("├───────┘")


def print_task_table(tasks):
    print("├─ All tasks %s%d%s" %
          (to_color("[", color2), len(w_tasks), to_color("]", color2)))

    print("│   ├─ %s│%s│%s│%s│%s│" % (
        to_color("ID".ljust(4, " "), color2),

        to_color("U".ljust(5, " "), color2),
        to_color("P".ljust(2, " "), color2),
        to_color("Project".ljust(13, " "), color2),
        to_color("Description".ljust(40, " "), color2),
    ))

    print("│   ├" + "─" * 6 + "┼" + "─" * 5 + "┼" + "─" *
          2 + "┼" + "─" * 13 + "┼" + "─" * 40 + "┤")
    for _ in range(0, len(tasks) if len(tasks) < 10 else 10):
        #    print(w_tasks[_])
        print("│   %s─ %s│%s│%s│%s│%s│" % (
            "├" if _ != len(tasks) - 1 and _ != 9 else "└",
            to_color(str(tasks[_]["id"]).ljust(4, " "),
                     color1 if tasks[_]["urgency"] < 6 else color2),
            to_color(str(tasks[_]["urgency"])[:5].ljust(
                5, " "),  color1 if tasks[_]["urgency"] < 6 else color2),
            to_color(str(tasks[_]["priority"] if "priority" in tasks[_]
                         else " ").ljust(2, " "),  color1 if tasks[_]["urgency"] < 6 else color2),
            to_color(str(tasks[_]["project"] if "project" in tasks[_]
                         else " ").ljust(13, " "),  color1 if tasks[_]["urgency"] < 6 else color2),
            to_color(str(tasks[_]["description"]
                         if "description" in tasks[_] else " ").ljust(40, " "),  color1 if tasks[_]["urgency"] < 6 else color2),
        ))


def print_project_table(tasks):
    project_list = []
    for elem in tasks["pending"]:
        if "project" in elem:
            project_list.append({
                "name": elem["project"],
                "pending": 0,
                "completed": 0,
            })
    for elem in tasks["completed"]:
        if "project" in elem:
            print(elem["project"])

    for elem in project_list:
        print(elem)

print_task_table(w_tasks)
#print_project_table(a_tasks)
