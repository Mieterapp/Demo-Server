# Generated by Django 3.1.5 on 2021-03-03 09:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content', '0011_news_documents'),
    ]

    operations = [
        migrations.AddField(
            model_name='offer',
            name='icons',
            field=models.CharField(blank=True, max_length=350, null=True, verbose_name='Icon_URL_App'),
        ),
    ]
