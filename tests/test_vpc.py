import pytest 

@pytest.fixture(scope="module")
def tf_output(tfstate):
    return tfstate.outputs

def test_vpc_exists(tf_output):
    assert 'vpc_id' in tf_output, "VPC should exist"

def test_vpc_cidr_block(tf_output):
    expected_cidr_block = "10.0.0.0/16"
    assert tf_output['vpc_cidr_block']['value'] == expected_cidr_block, f"Expected CIDR block {expected_cidr_block}"
