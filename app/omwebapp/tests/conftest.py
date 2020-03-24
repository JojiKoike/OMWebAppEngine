"""
WebAPIのUT向けフィクスチャーモジュール
"""
import pytest
from flask import Flask
from app.omwebapp import create_app


@pytest.fixture
def app() -> Flask:
    return create_app()


@pytest.fixture
def client(app: Flask):
    return app.test_client()

