from src.components.issues.issue_answer.models import IssueAnswer
from src.components.issues.issue.models import Issue
from src.components.docu_web.webservices.tickets import (
    build_get_ticket_process_fields_first_step_query,
    get_keywords,
    get_ticket_process_fields_first_step,
)
from django.core.management.base import BaseCommand, CommandError


class Command(BaseCommand):
    help = "import gwg issues"

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS(f"run issue import"))
        self.load_issues()

    def load_issues(self):
        issues = get_keywords()
        for loaded_issue in issues["data"]["issues"]:
            code = loaded_issue["code"]
            try:
                issue = Issue.objects.get(code=code)
                self.stdout.write(self.style.SUCCESS(f"update existing issue {code}"))
                Issue.objects.filter(code=code).update(**loaded_issue)
            except Issue.DoesNotExist:
                self.stdout.write(self.style.SUCCESS(f"create issue {code}"))
                issue = Issue.objects.create(**loaded_issue)

            self.load_issue_details(issue)

    def load_issue_details(self, issue):
        self.stdout.write(self.style.SUCCESS(f"load issue details {issue.code}"))
        questions_queryset = issue.questions.all()
        loaded_questions = get_ticket_process_fields_first_step(
            build_get_ticket_process_fields_first_step_query(issue)
        )
        try:
            issue.description = loaded_questions["data"]["issue"]["description"]
            issue.save()
            print(str(issue))
        except:
            self.stdout.write(
                self.style.WARNING(f"no description field for issue {issue.code}")
            )

        for question in loaded_questions["data"]["questions"]:
            q = question["question"]
            try:
                questions_queryset.get(question=q)
                self.stdout.write(self.style.SUCCESS(f"update existing question {q}"))
                questions_queryset.filter(question=q).update(**question)
            except:
                self.stdout.write(self.style.SUCCESS(f"create question {q}"))
                IssueAnswer.objects.create(issue=issue, **question)
