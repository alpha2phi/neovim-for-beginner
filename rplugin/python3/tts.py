import pynvim
import pyttsx3
from pynvim import Nvim

engine = pyttsx3.init()


@pynvim.plugin
class Text2SpeechPlugin(object):
    def __init__(self, nvim: Nvim):
        self.nvim = nvim

    @pynvim.command("Text2Speech")
    def text2Speech(self):
        self.nvim.current.line = "Hello World"
        # buffer = self.nvim.current.buffer
        # self.nvim.out_write("testing")

    # self.nvim.current.line = "Command with args: {}, range: {}".format(args, range)

    # @pynvim.function("TestFunction", sync=True)
    # def testfunction(self, args):
    #     return 3
    #
    # @pynvim.command("TestCommand", nargs="*", range="")
    # def testcommand(self, args, range):
    #     self.nvim.current.line = "Command with args: {}, range: {}".format(args, range)
    #
    # @pynvim.autocmd("BufEnter", pattern="*.py", eval='expand("<afile>")', sync=True)
    # def on_bufenter(self, filename):
    #     self.nvim.out_write("testplugin is in " + filename + "\n")
