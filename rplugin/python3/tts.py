import pynvim
import pyttsx3
from pynvim import Nvim
from translate import Translator

engine = pyttsx3.init()

DEFAULT_LANG = "zh"  # default language


@pynvim.plugin
class Text2SpeechPlugin(object):
    def __init__(self, nvim: Nvim):
        self.nvim = nvim

    @pynvim.command("Text2Speech", nargs="*", range="", sync=False)
    def text2Speech(self, args, range):
        if len(args) > 0:
            text = args[0]
        else:
            text = self.nvim.funcs.getline(range[0], range[1])
            text = "\n".join(map(str, text))

        engine.say(text)
        engine.runAndWait()

    @pynvim.function("Translate", range=True, sync=True)
    def translate(self, args, range):
        lang = DEFAULT_LANG
        text = ""

        if len(args) > 0 and args[0]:
            lang = args[0]

        if len(args) > 1 and args[1]:
            text = [args[1]]
        else:
            text = self.nvim.funcs.getline(range[0], range[1])
            # text = "\n".join(map(str, text))

        # Debugging
        # self.nvim.out_write(f"lang: {lang}\n")
        # self.nvim.out_write(f"text: {text}\n")

        translator = Translator(to_lang=lang)
        translated = []
        for line in text:
            translated.append(translator.translate(line))
        return "\n".join(translated)

    @pynvim.command("Translator", nargs="*", range="", sync=True)
    def translator(self, args, range):
        text = self.translate(args, range)
        text = text.split("\n")

        self.nvim.api.exec("vsp", True)
        win = self.nvim.api.get_current_win()
        buf = self.nvim.api.create_buf(True, True)
        self.nvim.api.win_set_buf(win, buf)
        self.nvim.api.buf_set_lines(buf, 0, -1, False, text)

    # @pynvim.autocmd("VimEnter", pattern="*", eval='expand("<afile>")', sync=True)
    # def onBufEnter(self, filename):
    #     self.translate("zh", "hello world")
