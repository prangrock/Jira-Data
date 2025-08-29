from robot.api.deco import keyword
import pyautogui
import time
import subprocess

# Simulate pressing the 'ctrl' key and the '-' key to zoom out
@keyword
def zoom_out():
    pyautogui.keyDown('ctrl')
    pyautogui.press('-')
    pyautogui.press('-')
    pyautogui.press('-')
    pyautogui.press('-')
    pyautogui.press('-')
    pyautogui.keyUp('ctrl')

@keyword
def press_Enter():
    pyautogui.press('enter')
    
@keyword
def deleteWord():
    pyautogui.keyDown('ctrl')
    pyautogui.press('a')
    pyautogui.keyUp('ctrl')
    pyautogui.press('backspace')
