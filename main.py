from tkinter import *
from tkinter import ttk

root = Tk()

root.attributes('-fullscreen', True)

screen = ttk.Frame(root, padding=10)
screen.grid()

font = ("Helvetica", 24)

ttk.Label(screen, text="Hello World!", font=font).grid(column=0, row=0)
ttk.Button(screen, text="Quit", command=root.destroy).grid(column=12, row=12)

root.mainloop()