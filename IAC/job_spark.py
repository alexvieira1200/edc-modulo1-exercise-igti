from pyspark.sql.functions import mean, max, min, col, count
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder.appName("ExercicioSpark")
    .getOrCreate()
)

# Ler os Dadados do Enem 2020
enem = (
    spark
    .read
    .fromat("csv")
    .option("header", True)
    .option("inferSchema", True)
    .option("delimiter",";")
    .load("s3://datalake-alexvieira-349524974723/raw-data/enem/")
)
# Converter para parquet e jogar em outro bucket
(
    enem
    .write
    .mode("overwrite")
    .format("parquet")
    .partitionBy("year")
    .save("s3://datalake-alexvieira-349524974723/staging/enem/")

)