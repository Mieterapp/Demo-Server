# Generated by Django 3.1.4 on 2020-12-30 14:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('issues', '0003_auto_20201229_1752'),
    ]

    operations = [
        migrations.AddField(
            model_name='issueanswer',
            name='code',
            field=models.CharField(blank=True, db_index=True, max_length=100, null=True, verbose_name='Identifier im remote system'),
        ),
    ]
