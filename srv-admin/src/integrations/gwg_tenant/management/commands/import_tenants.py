import os
from django.core.management.base import BaseCommand, CommandError
import psycopg2

conn = psycopg2.connect(
    dbname=os.environ.get("DATABASE_NAME", "postgres"),
    user=os.environ.get("DATABASE_USER", "postgres"),
    password=os.environ.get("DATABASE_USER_PASSWORD", "postgres"),
    host=os.environ.get("DATABASE_HOST", "localhost"),
    port=os.environ.get("DATABASE_PORT", 5432)
)


class Command(BaseCommand):
    help = "imports gwg tenants"

    def add_arguments(self, parser):
        parser.add_argument("csv", type=str)

    def handle(self, *args, **options):
        file = options["csv"]
        try:
            with open(file) as f:
                with conn:
                    with conn.cursor() as cursor:
                        cursor.copy_expert(
                            """
                              COPY public.gwg_tenant_tenant(bukrs, swenr, sgenr, smenr, recnnr, name_last, name_first, partnerid)
                              FROM STDIN
                              DELIMITER ';'
                              CSV HEADER
                            """,
                            f,
                        )
                        self.stdout.write(
                            self.style.SUCCESS(f"Successfully imported {file}")
                        )
        except CommandError as e:
            self.stdout.write(self.style.ERROR(f"couldn't import {file} {e}"))
