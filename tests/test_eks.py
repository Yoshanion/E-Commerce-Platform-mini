import pytest

@pytest.fixture(scope="module")

def tf_output(tfstate):
    return tfstate.outputs

def test_eks_cluster_exists(tf_output):
    assert 'cluster_id' in tf_output, "EKS Cluster should exist"