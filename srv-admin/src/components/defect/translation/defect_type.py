import swapper
from modeltranslation.translator import TranslationOptions, register


@register(
    swapper.load_model("defect", "DefectType"),
)
class DefectTypeTranslationOptions(TranslationOptions):
    fields = (
        "name",
        "description",
    )
