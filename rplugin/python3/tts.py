import pynvim
import pyttsx3
from pynvim import Nvim

engine = pyttsx3.init()


@pynvim.plugin
class Text2SpeechPlugin(object):
    def __init__(self, nvim: Nvim):
        self.nvim = nvim

    @pynvim.command("Text2Speech")
    def text2SpeechCmd(self):
        engine.say("hello")
        engine.runAndWait()

    @pynvim.function("text2speech")
    def text2SpeechFunc(self, args):
        self.nvim.out_write("text2speech function")
        return "hello alpha2phi"
