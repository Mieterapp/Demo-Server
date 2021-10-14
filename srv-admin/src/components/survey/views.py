import json
from datetime import datetime
from src.components.content.utils import get_filtered_by_object_id

from django.db.models import Q
from rest_framework import mixins, viewsets
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .models import Survey, SurveyAnswersText, SurveyMembers, SurveyQuestion


class SurveyViewSet(viewsets.ViewSet, mixins.CreateModelMixin):
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        req = request.data
        import logging

        logger = logging.getLogger("tenant")

        logger.debug(f"create Answers: {json.dumps(req)}")
        logger.debug(f"SurveyID: {str(req['survey'])}")

        survey_id = req["survey"]
        answers = req["answers"]
        survey = Survey.objects.all().filter(id=survey_id).first()
        questions = SurveyQuestion.objects.all().filter(survey=survey_id)

        for reason in questions:
            survey_answers = {
                "question": reason,
                "user": request.user,
                "answer1": "",
                "answer2": "",
                "answer3": "",
                "answer4": "",
                "answer5": "",
                "answer6": "",
            }

            # prepare for test
            # reasons = {
            #     "1": {
            #         "type": reason.type1,
            #         "count": reason.count1,
            #     },
            #     "2": {
            #         "type": reason.type2,
            #         "count": reason.count2,
            #     },
            #     "3": {
            #         "type": reason.type3,
            #         "count": reason.count3,
            #     },
            #     "4": {
            #         "type": reason.type4,
            #         "count": reason.count4,
            #     },
            #     "5": {
            #         "type": reason.type5,
            #         "count": reason.count5,
            #     },
            #     "6": {
            #         "type": reason.type6,
            #         "count": reason.count6,
            #     },
            # }
            # for reason_key, reason_data in reasons.items():
            #     if reason_data.get("type"):
            #         survey_answers[f"answer{reason_key}"] = answers[f"{str(reason.id)}_{reason_key}"]
            #         if reason_data.get("type") == "1" and answers[f"{str(reason.id)}_{reason_key}"]:
            #             reason_data["count"] += 1

            if reason.type1 != None:
                survey_answers["answer1"] = answers[str(reason.id) + "_1"]
                if reason.type1 == "1" and answers[str(reason.id) + "_1"]:
                    reason.count1 = reason.count1 + 1

            if reason.type2 != None:
                survey_answers["answer2"] = answers[str(reason.id) + "_2"]
                if reason.type2 == "1" and answers[str(reason.id) + "_2"]:
                    reason.count2 = reason.count2 + 1

            if reason.type3 != None:
                survey_answers["answer3"] = answers[str(reason.id) + "_3"]
                if reason.type3 == "1" and answers[str(reason.id) + "_3"]:
                    reason.count3 = reason.count3 + 1

            if reason.type4 != None:
                survey_answers["answer4"] = answers[str(reason.id) + "_4"]
                if reason.type4 == "1" and answers[str(reason.id) + "_4"]:
                    reason.count4 = reason.count4 + 1

            if reason.type5 != None:
                survey_answers["answer5"] = answers[str(reason.id) + "_5"]
                if reason.type5 == "1" and answers[str(reason.id) + "_5"]:
                    reason.count5 = reason.count5 + 1

            if reason.type6 != None:
                survey_answers["answer6"] = answers[str(reason.id) + "_6"]
                if reason.type6 == "1" and answers[str(reason.id) + "_6"]:
                    reason.count6 = reason.count6 + 1

            sa = SurveyAnswersText.objects.create(**survey_answers)
            sa.save()
            reason.save()

        surveyMembers = {"survey": survey, "user": request.user}
        # t = SurveyMembers.objects.create(**surveyMembers)
        # t.save()
        return Response({"Status": "Danke"})

    def list(self, request):
        surveys = []
        startdate = datetime.now()
        type = Survey.objects.all().filter(
            (
                (Q(date_from=None) & Q(date_to=None))
                | (Q(date_from=None) & Q(date_to__gte=startdate))
                | (Q(date_from__lte=startdate) & Q(date_to__gte=startdate))
                | (Q(date_from__lte=startdate) & Q(date_to=None))
            )
        )
        type = type.exclude(is_active=False)
        ids = get_filtered_by_object_id(self.request.user, type)
        type = type.filter(id__in=ids)
        for dt in type:

            surveyMembers = SurveyMembers.objects.all().filter(
                survey=dt, user=self.request.user
            )
            if len(surveyMembers) > 0:
                continue
            surveys = []
            data = {
                "id": dt.id,
                "title": dt.title,
                "text": dt.text,
                "visible_object": dt.visible_object,
                "date_from": dt.date_from,
                "date_to": dt.date_to,
                "dialog": dt.dialog,
                "text2": dt.text2,
                "question": [],
            }
            questions = SurveyQuestion.objects.filter(survey=dt).order_by("sorting")
            for reason in questions:
                question = {
                    "id": reason.id,
                    "question": reason.question,
                    "multi": reason.multi,
                    "sorting": reason.sorting,
                    "answers": [],
                }
                if reason.type1 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer1,
                            "type": reason.type1,
                            "index": 1,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                if reason.type2 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer2,
                            "type": reason.type2,
                            "index": 2,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                if reason.type3 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer3,
                            "type": reason.type3,
                            "index": 3,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                if reason.type4 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer4,
                            "type": reason.type4,
                            "index": 4,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                if reason.type5 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer5,
                            "type": reason.type5,
                            "index": 5,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                if reason.type6 != None:
                    question["answers"].append(
                        {
                            "answer": reason.answer6,
                            "type": reason.type6,
                            "index": 6,
                            "id": reason.id,
                            "multi": reason.multi,
                        }
                    )
                data["question"].append(question)

            surveys.append(data)
        return Response(surveys)
