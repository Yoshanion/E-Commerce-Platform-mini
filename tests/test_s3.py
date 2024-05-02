import pytest

@pytest.fixture(scope="module")
def tf_output(tfstate):
    return tfstate.outputs

def test_s3_bucket_exists(tf_output):
    assert 's3_bucket_name' in tf_output, "S3 Bucket should exist"
    

