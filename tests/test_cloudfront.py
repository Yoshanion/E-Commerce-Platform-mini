import pytest 

@pytest.fixture(scope="module")
def tf_output(tfstate):
    return tfstate.outputs

def test_cloudfront_distribution_exists(tf_output):
    assert 'cloudfront_distribution_id' in tf_output, "CloudFront Distribution should exist"
    