import swapper
from modeltranslation.translator import TranslationOptions, register


@register(
    swapper.load_model("defect", "Area"),
)
class AreaTranslationOptions(TranslationOptions):
    fields = ("name",)
