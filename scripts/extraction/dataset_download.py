# Install dependencies as needed:
# pip install kagglehub[pandas-datasets]
import kagglehub
from kagglehub import KaggleDatasetAdapter

path = kagglehub.dataset_download(
    "olistbr/brazilian-ecommerce",
    output_dir="./data/olist"
)