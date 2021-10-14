import swapper
from modeltranslation.translator import TranslationOptions, register


@register(
    swapper.load_model("defect", "Defect"),
)
class DefectTranslationOptions(TranslationOptions):
    fields = ("name",)
