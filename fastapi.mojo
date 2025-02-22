# mojo libs
from python import Python
import os
import sys


def main():
    # Python libs
    Python.add_to_path(
        "/shadowcat/code/stock-gallery/.venv/lib/python3.11/site-packages"
    )
    Python.add_to_path("/shadowcat/code/stock-gallery")
    print("pre try")
    try:
        var fastapi = Python.import_module("fastapi")
        print("fastapi")
        var cors = Python.import_module("fastapi.middleware.cors")
        var StaticFiles = Python.import_module("fastapi.staticfiles")
        print("files")
        var uvi = Python.import_module("uvicorn")
        # imports
        var gallery = Python.import_module("routers.gallery")
        var site = Python.import_module("routers.site")
        var base = Python.import_module("routers.base")
        print("routers")

        var app = fastapi.FastAPI()

        var origins: Tuple[
            StringLiteral,
            StringLiteral,
            StringLiteral,
            StringLiteral,
            StringLiteral,
            StringLiteral,
            StringLiteral,
            StringLiteral,
        ] = (
            "http://localhost",
            "http://127.0.0.1",
            "http://[::]",
            "http://12.69.160.95",
            "https://stockgallery.riddell.com",
            "https://stockgalleryqa.riddell.com",
            "https://*.riddell.com",
            "*",
        )
        # var py_code: StringLiteral = """
        # app.add_middleware(
        #     middleware_class=cors.CORSMiddleware,
        #     allow_origins=origins,
        #     allow_credentials=True,
        #     allow_methods=["*"],
        #     allow_headers=["*"])
        # """
        # Python.evaluate(py_code)
        var cors_middleware = cors.CORSMiddleware
        cors_middleware.allow_origins = origins
        cors_middleware.allow_credentials = True
        cors_middleware.allow_methods = ["*"]
        cors_middleware.allow_headers = ["*"]
        app.add_middleware(cors_middleware)

        print("origins")
        # ----------------------------
        app.include_router(gallery.gallery)
        app.include_router(site.pages)
        app.include_router(base.base)
        print("add_routers")
        # ---------------------------------------------------------
        print("mount")
        #
        uvi.run(app)

        # if os.getenv("SITE_ENV") == "QA" or os.getenv("SITE_ENV") == "PRODUCTION":
        #     uvi.run(
        #         app,
        #         host="0.0.0.0",
        #         post=8047,
        #         root_path=".",
        #         workers=8,
        #         log_level="info",
        #         forwarded_allow_ips="*",
        #     )
        # else:
        #     uvi.run(
        #         app,
        #         host: StringLiteral="0.0.0.0",
        #         post=8047,
        #         root_path=".",
        #         workers=8,
        #         log_level="debug",
        #         forwarded_allow_ips="*",
        #         ssl_certfile="./certs/dev-cert.pem",
        #         ssl_keyfile="./certs/dev-key.pem",
        #     )
    except:
        raise Error()


# ---------------------------------------------------------


# ---------------------------------------------------------


# ------------------------------------------------------------------------------
# tricky part
# var py = Python()
# var py_code = """lambda: 'Hello Mojo🔥!'"""
# var py_obj = py.evaluate(py_code)
# print(py_obj)

# if __name__ == "__main__":
#     server.run()
