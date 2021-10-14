from __future__ import unicode_literals
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("authentication_local", "0004_auto_20201119_1330"),
    ]

    operations = [
        migrations.RunSQL("INSERT INTO auth_group (id, name) VALUES (1, 'Mieter');"),
    ]