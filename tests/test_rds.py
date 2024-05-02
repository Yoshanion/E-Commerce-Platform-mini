import pytest

@pytest.fixture(scope="module")
def tf_output(tfstate):
    return tfstate.outputs

def test_rds_instance_exists(tf_output):
    assert 'db_instance_id' in tf_output, "RDS Instance should exist"

def test_rds_multi_az(tf_output):
    assert tf_output['db_instance_multi_za']['value'] == True, "RDS should be multi-AZ"
    