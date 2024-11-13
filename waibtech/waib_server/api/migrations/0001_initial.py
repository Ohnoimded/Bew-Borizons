# Generated by Django 5.1.1 on 2024-09-27 02:43

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="EntitiesMaster",
            fields=[
                ("id", models.AutoField(primary_key=True, serialize=False)),
                ("concert_title", models.CharField(max_length=255)),
                ("performance_date", models.DateField()),
                ("performance_time", models.TimeField()),
                ("performance_dow", models.CharField(max_length=10)),
                ("venue", models.CharField(max_length=255)),
                ("artist_name", models.CharField(max_length=255)),
                (
                    "artist_role",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                ("composer", models.CharField(max_length=255)),
                ("piece", models.CharField(max_length=255)),
            ],
            options={
                "db_table": "EntitiesMaster",
            },
        ),
    ]